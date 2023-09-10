import 'package:appteste/components/post_tile.dart';
import 'package:appteste/provider/posts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostsList extends StatefulWidget {
  const PostsList({super.key});

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
          itemBuilder: (ctx, i) => PostTile(post: posts.byIndex(i)),
        ),
      ),
    );
  }
}