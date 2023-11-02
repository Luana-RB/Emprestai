import 'package:appteste/components/post_tile.dart';
import 'package:appteste/models/posts/post_object.dart';
import 'package:appteste/models/user/user.dart';
import 'package:appteste/provider/posts_provider.dart';
import 'package:appteste/provider/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//HomePage
class PostsList extends StatefulWidget {
  const PostsList({super.key, this.idUsuario, required this.fromHomePage});
  final bool fromHomePage;
  final String? idUsuario;

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: Provider.of<PostsProvider>(context).getAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Erro: ${snapshot.error}'),
            ),
          );
        } else {
          List<Post> allPosts = snapshot.data!;
          var filterPostsByStatus =
              Provider.of<PostsProvider>(context).filterPostsByStatus;

          List<Post> filteredPosts =
              filterPostsByStatus(allPosts, "Solicitado");
          filteredPosts = filteredPosts.reversed.toList();

          return Scaffold(
            body: Container(
              color: Theme.of(context).colorScheme.background,
              child: ListView.builder(
                itemCount: filteredPosts.length,
                itemBuilder: (ctx, i) => PostTile(
                  post: filteredPosts[i],
                  idUsuario: widget.idUsuario.toString(),
                  fromHomePage: widget.fromHomePage,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

//Profile Panel
class PostsPanel extends StatefulWidget {
  final String? idUsuario;
  final bool fromHomePage;
  const PostsPanel({super.key, this.idUsuario, required this.fromHomePage});

  bool doesPostBelongToUser(String id, Post post) {
    return id == post.creatorId;
  }

  @override
  State<PostsPanel> createState() => _PostsPanelState();
}

class _PostsPanelState extends State<PostsPanel> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: Provider.of<PostsProvider>(context).getAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Erro: ${snapshot.error}'),
            ),
          );
        } else {
          final List<Post> allPosts = snapshot.data ?? [];
          final usersProvider =
              Provider.of<UsersProvider>(context, listen: false);
          final User? thisUser =
              usersProvider.findById(widget.idUsuario.toString());
          String userId = thisUser != null ? thisUser.id.toString() : 'null';

          var filterPostsByStatus =
              Provider.of<PostsProvider>(context, listen: false)
                  .filterPostsByStatus;

          List<Post> userPosts = allPosts
              .where((post) => widget.doesPostBelongToUser(userId, post))
              .toList();

          List<Post> filteredUserPostsSolicitado =
              filterPostsByStatus(userPosts, "Solicitado");
          filteredUserPostsSolicitado =
              filteredUserPostsSolicitado.reversed.toList();

          List<Post> filteredUserPostsEmprestado =
              filterPostsByStatus(userPosts, "Emprestado");
          filteredUserPostsEmprestado =
              filteredUserPostsEmprestado.reversed.toList();

          List<Post> filteredUserPostsDevolvido =
              filterPostsByStatus(userPosts, "Devolvido");
          filteredUserPostsDevolvido =
              filteredUserPostsDevolvido.reversed.toList();

          List<Post> allFilteredPosts = [
            ...filteredUserPostsSolicitado,
            ...filteredUserPostsEmprestado,
            ...filteredUserPostsDevolvido,
          ];

          return Scaffold(
            body: Container(
              color: Theme.of(context).colorScheme.background,
              child: ListView.builder(
                itemCount: allFilteredPosts.length,
                itemBuilder: (ctx, i) => PostTile(
                  post: allFilteredPosts[i],
                  idUsuario: widget.idUsuario.toString(),
                  fromHomePage: widget.fromHomePage,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
