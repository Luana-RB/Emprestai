import 'package:flutter/material.dart';

class Post {
  final String title;
  final String imageUrl;
  final String description;
  final String creatorName;
  final String creatorProfileLink;

  Post({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.creatorName,
    required this.creatorProfileLink,
  });
}

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          post.imageUrl,
          width: 300,
          height: 200,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 10),
        Text(
          post.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(post.description),
        const SizedBox(height: 10),
        Row(
          children: [
            const Text("Criado por: "),
            InkWell(
              onTap: () {
                // Aqui você pode adicionar a navegação para o perfil do criador.
                // Por exemplo, usando o Navigator.push para navegar para a página do perfil.
              },
              child: Text(
                post.creatorName,
                style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
