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
        Container(
          color: Colors.white,
          width: 500,
          //decoration: BoxDecoration(
          //border: Border.all(
            //color: Colors.pinkAccent,
            //width: 5.0,
          //),
        //),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
              Container(
                height: 50,
                decoration: const BoxDecoration(color: Colors.pinkAccent,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                    Text(
                      post.id.toString(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //Autor
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text("Criado por: "),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              post.creatorName.toString(),
                              style: const TextStyle(
                                color: Colors.black45,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ), IconButton(
            icon: const Icon(Icons.edit),
            color: Colors.black12,
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.POSTS_FORM,
                arguments: post,
              );},)
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      post.imageUrl.toString(),
                      width: 300,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
              const SizedBox(height: 10),
               Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    post.description.toString(),
                    softWrap: true, // Permite que o texto seja quebrado automaticamente
                  ),
                ),
              ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}