// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:appteste/components/images/post_picture.dart';
import 'package:appteste/models/posts/post_object.dart';
import 'package:appteste/models/user/user.dart';
import 'package:appteste/provider/posts_provider.dart';
import 'package:appteste/provider/users_provider.dart';
import 'package:appteste/views/post_page.dart';
import 'package:appteste/views/posts_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostTile extends StatefulWidget {
  final Post post;
  final String? idUsuario;
  final bool fromHomePage;
  const PostTile(
      {super.key,
      required this.post,
      required this.idUsuario,
      required this.fromHomePage});

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

//Gets post
  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    await getPostFromSharedPreferences();
  }

//Gets key
  String getPrefsKey() {
    return 'post_${_fetchedPost.id}';
  }

//Gets post by the key
  Future<void> getPostFromSharedPreferences() async {
    final postJson = prefs.getString(getPrefsKey());
    if (postJson != null) {
      Map<String, dynamic> decodedPost =
          jsonDecode(getPrefsKey()); //decodes post by the key
      Post post = Post.fromJson(decodedPost);
      setState(() {
        _fetchedPost = post; //changes post to the fetched post
      });
    }
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

    //the creator is the user whose id is the id of the post creator, or else, is null
    final User? creator = usersProvider.all.isNotEmpty
        ? usersProvider.all.firstWhere(
            (user) => user.id == creatorId,
            orElse: () => User(name: 'null', id: 'null'),
          )
        : null;
    String creatorName = creator != null ? creator.name.toString() : 'null';
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
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
              fromHomePage: widget.fromHomePage,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
//Post
          Container(
            color: Theme.of(context).colorScheme.tertiary,
            width: MediaQuery.of(context).size.width * 1,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10),
                      Visibility(
                          visible: (_fetchedPost.dateOfReturning != null
                                  ? DateTime(
                                          _fetchedPost.dateOfReturning!.year,
                                          _fetchedPost.dateOfReturning!.month,
                                          _fetchedPost.dateOfReturning!.day)
                                      .isBefore(today)
                                  : false) &&
                              (_fetchedPost.status != 'Devolvido'),
                          child: const Icon(Icons.timer)),
                      const SizedBox(width: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
//Title
                          Text(
                            title,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

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
                                      idUsuario: widget.idUsuario.toString(),
                                      fromHomePage: widget.fromHomePage,
                                    ),
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
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text('Excluir Post'),
                                    content: const Text('Tem certeza?'),
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(false),
                                            child: const Text('Não'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(true),
                                            child: const Text('Sim'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ).then(
                                  (confirmed) {
                                    if (confirmed) {
                                      Provider.of<PostsProvider>(context,
                                              listen: false)
                                          .remove(_fetchedPost);
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

//Post Body
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    color: Theme.of(context).colorScheme.tertiary,
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
                            child: Container(
                              color: Theme.of(context).colorScheme.tertiary,
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
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
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
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
