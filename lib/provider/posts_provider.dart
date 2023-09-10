import 'dart:math';

import 'package:appteste/data/dummy_posts.dart';
import 'package:appteste/models/posts/post_generico.dart';
import 'package:flutter/material.dart';

class PostsProvider extends ChangeNotifier {
  final Map<String, Post> _items = {...dummyPosts};
//retorna os valores
  List<Post> get all {
    return [..._items.values];
  }
//retorna o tamanho
  int get count {
    return _items.length;
  }
//retorna o valor baseado no índice
  Post byIndex(int i) {
    return _items.values.elementAt(i);
  }
  Post? findById(String id) {
    return _items[id];
  }
  //verify if user is not null
  void put(Post post) {
    if (post.id == null) {
      return;
    }
//if post already exists, it will update it
    if (post.id != null &&
        !post.id!.trim().isNotEmpty &&
        _items.containsKey(post.id)) {
      _items.update(post.id!, (_) => post);
    }
//if post doesn't exists yet, it will creat it
    else {
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(
          id,
          () => Post(
                id: id,
                //status: post.status,
                title: post.title,
                imageUrl: post.imageUrl,
                description: post.description,
                creatorName: post.creatorName,
                creatorProfileLink: post.creatorProfileLink,
                //creatorImageUrl: post.creatorImageUrl,
                //ownerName: post.ownerName,
                //ownerProfileLink: post.ownerProfileLink,
                //ownerImageUrl: post.ownerImageUrl,
                dateOfLending: post.dateOfLending,
                //dateOfReturning: post.dateOfReturning,
              ));
    }
    notifyListeners();
  }

  void remove(Post post) {
    if (post.id != null) {
      _items.remove(post.id);
      notifyListeners();
    }
  }
}