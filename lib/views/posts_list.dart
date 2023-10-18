import 'package:appteste/components/post_tile.dart';
import 'package:appteste/models/posts/post_generico.dart';
import 'package:appteste/models/user/user.dart';
import 'package:appteste/provider/posts_provider.dart';
import 'package:appteste/provider/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//HomePage
class PostsList extends StatefulWidget {
  const PostsList({super.key, this.idUsuario});
  final String? idUsuario;

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  @override
  Widget build(BuildContext context) {
    final PostsProvider postsProvider = Provider.of(context);
    final List<Post> allPosts = postsProvider.all;
    var filterPostsByStatus = postsProvider.filterPostsByStatus;

    List<Post> filteredPosts = filterPostsByStatus(allPosts, "Solicitado");
    filteredPosts = filteredPosts.reversed.toList();

    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 255, 224, 235),
        child: ListView.builder(
          itemCount: filteredPosts.length,
          itemBuilder: (ctx, i) => PostTile(
            post: filteredPosts[i],
            idUsuario: widget.idUsuario.toString(),
          ),
        ),
      ),
    );
  }
}

//Profile Panel
class PostsPanel extends StatefulWidget {
  final String? idUsuario;
  const PostsPanel({super.key, this.idUsuario});

  bool doesPostBelongToUser(String id, Post post) {
    return id == post.creatorId;
  }

  @override
  State<PostsPanel> createState() => _PostsPanelState();
}

class _PostsPanelState extends State<PostsPanel> {
  @override
  Widget build(BuildContext context) {
    //Find User
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final User? thisUser = usersProvider.findById(widget.idUsuario.toString());
    String userId = thisUser != null ? thisUser.id.toString() : 'null';

    final PostsProvider posts = Provider.of(context);
    final List<Post> userPosts = posts.all
        .where((post) => widget.doesPostBelongToUser(userId, post))
        .toList();

    var filterPostsByStatus = posts.filterPostsByStatus;

    List<Post> filteredUserPostsSolicitado =
        filterPostsByStatus(userPosts, "Solicitado");
    filteredUserPostsSolicitado = filteredUserPostsSolicitado.reversed.toList();

    List<Post> filteredUserPostsEmprestado =
        filterPostsByStatus(userPosts, "Emprestado");
    filteredUserPostsEmprestado = filteredUserPostsEmprestado.reversed.toList();

    List<Post> filteredUserPostsDevolvido =
        filterPostsByStatus(userPosts, "Devolvido");
    filteredUserPostsDevolvido = filteredUserPostsDevolvido.reversed.toList();

    List<Post> allFilteredPosts = [
      ...filteredUserPostsSolicitado,
      ...filteredUserPostsEmprestado,
      ...filteredUserPostsDevolvido,
    ];
    return Container(
      color: const Color.fromARGB(255, 255, 224, 235),
      child: ListView.builder(
        itemCount: allFilteredPosts.length,
        itemBuilder: (ctx, i) => PostTile(
          post: allFilteredPosts[i],
          idUsuario: widget.idUsuario.toString(),
        ),
      ),
    );
  }
}
