import 'package:appteste/models/posts/post_generico.dart';
import 'package:appteste/models/user/user.dart';
import 'package:appteste/provider/posts_provider.dart';
import 'package:appteste/provider/users_provider.dart';
import 'package:appteste/views/post_page.dart';
import 'package:appteste/views/posts_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostTile extends StatelessWidget {
  const PostTile({super.key, required this.post, required this.nomeUsuario});
  final Post post;
  final String? nomeUsuario;

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);
    //o solicitante é o user cujo nome é igual ao nome do criador do post, senão, é nulo
    final User? solicitant = usersProvider.all.isNotEmpty
        ? usersProvider.all.firstWhere(
            (user) => user.name == post.creatorName,
            orElse: () => User(name: 'null'),
          )
        : null;
    //final User owner = usersProvider.all.firstWhere((user) => user.name == post.ownerName,  orElse: () => null);
    final String status = post.status.toString();
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
              post: post,
              creator: solicitant,
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
            width: 500,
            height: 290,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
//PostHeader
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: colorName,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(width: 10),
//Title
                      Text(
                        post.title.toString(),
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 150),
//Edit
                      Visibility(
                        visible: nomeUsuario == solicitant?.name,
                        child: IconButton(
                          icon: const Icon(Icons.edit),
                          color: Colors.white30,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostsForm(
                                    nomeUsuario: nomeUsuario.toString()),
                                settings: RouteSettings(
                                  arguments: post,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
//Delete
                      Visibility(
                        visible: nomeUsuario == solicitant?.name,
                        child: IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.white30,
                          onPressed: () {
                            Provider.of<PostsProvider>(context, listen: false)
                                .remove(post);
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
//Image
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            post.imageUrl.toString(),
                            width: 280,
                            height: 210,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
//Description
                      SizedBox(
                        width: 170,
                        height: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                post.description.toString(),
                                softWrap: true,
                              ),
                            ),

//Creator's name
                            Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: () {},
                                child: Text(
                                  post.creatorName.toString(),
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
