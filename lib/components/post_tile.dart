// ignore_for_file: unnecessary_null_comparison

import 'package:appteste/components/post_picture.dart';
import 'package:appteste/models/posts/post_generico.dart';
import 'package:appteste/models/user/user.dart';
import 'package:appteste/provider/posts_provider.dart';
import 'package:appteste/provider/users_provider.dart';
import 'package:appteste/views/post_page.dart';
import 'package:appteste/views/posts_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostTile extends StatefulWidget {
  const PostTile({super.key, required this.post, required this.idUsuario});
  final Post post;
  final String? idUsuario;

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  late Post _fetchedPost;
  late SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    _fetchedPost = widget.post;
    initPrefs();
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    await getPostFromSharedPreferences();
  }

  Future<void> getPostFromSharedPreferences() async {
    final postJson = prefs.getString(getPrefsKey());
    if (postJson != null) {
      final post = Post.fromJson(postJson);
      setState(() {
        _fetchedPost = post;
      });
    }
  }

  String getPrefsKey() {
    return 'post_${widget.post.id}';
  }

  @override
  Widget build(BuildContext context) {
    final String status = _fetchedPost.status ?? "";
    final String id = _fetchedPost.id ?? "";
    final String title = _fetchedPost.title ?? "";
    final String description = _fetchedPost.description ?? "";
    final String creatorId = _fetchedPost.creatorId ?? "";
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);

    //Find User
    final User? thisUser = usersProvider.findById(widget.idUsuario.toString());
    String userId = thisUser != null ? thisUser.id.toString() : 'null';

    //o creator é o user cujo id é igual ao id do criador do post, senão, é nulo
    final User? creator = usersProvider.all.isNotEmpty
        ? usersProvider.all.firstWhere(
            (user) => user.id == creatorId,
            orElse: () => User(name: 'null', id: 'null'),
          )
        : null;
    String creatorName = creator != null ? creator.name.toString() : 'null';

    Color colorName;

    switch (status) {
      case 'Solicitado':
        colorName = Colors.pinkAccent;
      case 'Emprestado':
        colorName = Colors.orangeAccent;
      case 'Devolvido':
        colorName = Colors.green;
        break;
      default:
        colorName = Colors.black;
    }
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostPage(
              post: _fetchedPost,
              idUsuario: widget.idUsuario,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
//Post
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width * 0.94,
            height: MediaQuery.of(context).size.height * 0.35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
//PostHeader
                Container(
                  height: MediaQuery.of(context).size.height * 0.055,
                  decoration: BoxDecoration(
                    color: colorName,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(width: 10),
//Title
                      Text(
                        title,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(id),
//Edit
                      Visibility(
                        visible: userId == creatorId,
                        child: IconButton(
                          icon: const Icon(Icons.edit),
                          color: Colors.white30,
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostsForm(
                                    idUsuario: widget.idUsuario.toString()),
                                settings: RouteSettings(
                                  arguments: _fetchedPost,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
//Delete
                      Visibility(
                        visible: userId == creatorId,
                        child: IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.white30,
                          onPressed: () {
                            Provider.of<PostsProvider>(context, listen: false)
                                .remove(_fetchedPost);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
//Post Body
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
//Image
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: FittedBox(
                              fit: BoxFit.contain,
                              child: PostPicture(
                                postId: id,
                                isSelect: true,
                                width: 0.45,
                                height: 0.25,
                              )),
                        ),
                      ),

                      const SizedBox(width: 15),
//Description
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                description,
                                softWrap: true,
                              ),
                            ),

//Creator's name
                            Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: () {},
                                child: Text(
                                  creatorName,
                                  style: const TextStyle(color: Colors.black45),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
