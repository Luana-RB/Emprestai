import 'package:appteste/components/post_tile.dart';
import 'package:appteste/models/posts/post_generico.dart';
import 'package:appteste/models/user/user.dart';
import 'package:appteste/provider/posts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostsList extends StatefulWidget {
  const PostsList({super.key, this.nomeUsuario});
  final String? nomeUsuario;

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  @override
  Widget build(BuildContext context) {
    final PostsProvider posts = Provider.of(context);
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 255, 224, 235),
        child: ListView.builder(
          itemCount: posts.count,
          itemBuilder: (ctx, i) => PostTile(
            post: posts.byIndex(i),
            nomeUsuario: widget.nomeUsuario.toString(),
          ),
        ),
      ),
    );
  }
}

class PostsPanel extends StatefulWidget {
  final String nomeUsuario;
  const PostsPanel({super.key, required this.nomeUsuario});

  bool doesPostBelongToUser(User user, Post post) {
    return user.name == post.creatorName;
  }

  @override
  State<PostsPanel> createState() => _PostsPanelState();
}

class _PostsPanelState extends State<PostsPanel> {
  @override
  Widget build(BuildContext context) {
    final PostsProvider posts = Provider.of(context);

// Filtrar os posts que pertencem ao usuário com base no nome de usuário fornecido
    final List<Post> userPosts = posts.all
        .where((post) =>
            widget.doesPostBelongToUser(User(name: widget.nomeUsuario), post))
        .toList();

    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 255, 224, 235),
        child: ListView.builder(
          itemCount: userPosts.length,
          itemBuilder: (ctx, i) => PostTile(
            post: userPosts[i],
            nomeUsuario: widget.nomeUsuario.toString(),
          ),
        ),
      ),
    );
  }
}
