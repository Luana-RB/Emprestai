import 'package:appteste/models/posts/post_generico.dart';
import 'package:flutter/material.dart';

class PostPage extends StatelessWidget {
  final Post post;
  const PostPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
        appBar: AppBar(
      backgroundColor: colorName,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        post.title.toString(),
        style: const TextStyle(color: Colors.white),
      ),
      centerTitle: true,
    ));
  }
}
