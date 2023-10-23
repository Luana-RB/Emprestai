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

class PostTile extends StatefulWidget {
  const PostTile({super.key, required this.post, required this.idUsuario});
  final Post post;
  final String? idUsuario;

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);
    //Find User

    final User? thisUser = usersProvider.findById(widget.idUsuario.toString());
    String userId = thisUser != null ? thisUser.id.toString() : 'null';

    //o creator é o user cujo id é igual ao id do criador do post, senão, é nulo
    final User? creator = usersProvider.all.isNotEmpty
        ? usersProvider.all.firstWhere(
            (user) => user.id == widget.post.creatorId,
            orElse: () => User(name: 'null', id: 'null'),
          )
        : null;
    String creatorName = creator != null ? creator.name.toString() : 'null';
    String creatorId = creator != null ? creator.id.toString() : 'null';

    final String status = widget.post.status.toString();
    final String id = widget.post.id.toString();

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
              post: widget.post,
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
                        widget.post.title.toString(),
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
                                  arguments: widget.post,
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
                                .remove(widget.post);
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
                                widget.post.description.toString(),
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
