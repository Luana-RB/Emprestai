import 'package:appteste/models/posts/post_generico.dart';
import 'package:appteste/routes/app_routes.dart';
import 'package:flutter/material.dart';

class PostTile extends StatelessWidget {
  const PostTile({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                decoration: const BoxDecoration(
                  color: Colors.pinkAccent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 10),
//Título
                    Text(
                      post.title.toString(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
//Edição
                    // IconButton(
                    //   icon: const Icon(Icons.edit),
                    //   color: Colors.black12,
                    //   onPressed: () {
                    //     Navigator.of(context).pushNamed(
                    //       AppRoutes.POSTS_FORM,
                    //       arguments: post,
                    //     );
                    //   },
                    // )
                  ],
                ),
              ),
//Corpo do Post
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
//Imagem
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            10.0), // Mesmo valor do Container
                        child: Image.network(
                          post.imageUrl.toString(),
                          width: 280,
                          height: 210,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
//Descrição
                    SizedBox(
                      width: 170,
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              post.description.toString(),
                              softWrap: true,
                            ),
                          ),

// Nome do criador
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                post.creatorName.toString(),
                                style: const TextStyle(
                                  color: Colors.black45,
                                  decoration: TextDecoration.underline,
                                ),
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
    );
  }
}
