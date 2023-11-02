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

//estado inicial, post que mostra é o post repassado
  @override
  void initState() {
    super.initState();
    _fetchedPost = widget.post;
    initPrefs();
  }

//busca o post inicial
  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    await getPostFromSharedPreferences();
  }

//busca a key
  String getPrefsKey() {
    return 'post_${_fetchedPost.id}';
  }

//busca post pela key
  Future<void> getPostFromSharedPreferences() async {
    final postJson = prefs.getString(getPrefsKey());
    if (postJson != null) {
      Map<String, dynamic> decodedPost =
          jsonDecode(getPrefsKey()); //decodifica o post pela String
      Post post = Post.fromJson(decodedPost);
      setState(() {
        _fetchedPost = post; //muda post para post buscado
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

    //o creator é o user cujo id é igual ao id do criador do post, senão, é nulo
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
                                Provider.of<PostsProvider>(context,
                                        listen: false)
                                    .remove(_fetchedPost);
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
