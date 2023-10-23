import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';
import 'package:appteste/data/dummy_posts.dart';
import 'package:appteste/models/posts/post_generico.dart';

class PostsProvider extends ChangeNotifier {
  final Map<String, Post> _items = {...dummyPosts};
  final LocalStorage localStorage = LocalStorage('posts.json');

//returns all values
  List<Post> get all {
    return [..._items.values];
  }

//returns lenght
  int get count {
    return _items.length;
  }

//returns posts based by their indices
  Post byIndex(int i) {
    return _items.values.elementAt(i);
  }

//returns posts bades by their id
  Post? findById(String id) {
    return _items[id];
  }

  //returns posts filtered by their status
  List<Post> filterPostsByStatus(List<Post> posts, String status) {
    return posts.where((post) => post.status == status).toList();
  }

  //verify if user is not null
  void put(Post post) {
//if post already exists, updates it
    if (post.id != null &&
        !post.id!.trim().isNotEmpty &&
        _items.containsKey(post.id)) {
      _items.update(post.id!, (_) => post);
    }

//if post doesn't exists yet, creats it
    if (post.id == null) {
      final id = (_items.length + 1).toString();
      _items.putIfAbsent(
          id,
          () => Post(
                id: id,
                status: post.status,
                title: post.title,
                description: post.description,
                creatorId: post.creatorId,
                ownerId: post.ownerId,
                dateOfLending: post.dateOfLending,
                dateOfReturning: post.dateOfReturning,
              ));
    }
    notifyListeners();
  }

//Deletes posts
  void remove(Post post) {
    if (post.id != null) {
      _items.remove(post.id);
      notifyListeners();
    }
  }

  Future<void> savePost(Map<String, dynamic> post) async {
    try {
      await localStorage.setItem(post['id'].toString(), post);
      if (kDebugMode) {
        print('Post salvo com sucesso.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Falha ao salvar o post: $e');
      }
    }
  }

  Future<List<Map<String, dynamic>>> getPosts() async {
    final List<Map<String, dynamic>> posts = [];

    // final keys = localStorage.keys;
    // for (var key in keys) {
    //   final post = localStorage.getItem(key);
    //   if (post != null) {
    //     posts.add(post);
    //   }
    // }

    return posts;
  }
}
