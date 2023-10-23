import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';
import 'package:appteste/models/posts/post_generico.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostsProvider extends ChangeNotifier {
  final Map<String, Post> _items = {};
  final LocalStorage localStorage = LocalStorage('posts.json');

  // Retorna todos os valores
  List<Post> get all {
    return [..._items.values];
  }

  // Carrega os posts do SharedPreferences e atualiza o _items
  Future<void> loadPostsFromSharedPreferences() async {
    final List<Post> posts = await getPostsFromSharedPreferences();
    for (var post in posts) {
      _items[post.id!] = post;
    }
    notifyListeners();
  }

  // Obtém a lista de posts do SharedPreferences
  Future<List<Post>> getPostsFromSharedPreferences() async {
    List<Post> posts = [];
    final prefs = await SharedPreferences.getInstance();
    final postsJson = prefs.getStringList('posts');
    if (postsJson != null) {
      posts = postsJson
          .map((postJson) => Post.fromJson(json.decode(postJson)))
          .toList();
    }
    return posts;
  }

  // Adiciona um post ao SharedPreferences e atualiza o _items
  Future<void> addPostToSharedPreferences(Post post) async {
    _items[post.id!] = post;
    await savePostsToSharedPreferences();
    notifyListeners();
  }

  // Salva a lista de posts no SharedPreferences
  Future<void> savePostsToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> postsJson =
        _items.values.map((post) => json.encode(post.toJson())).toList();
    await prefs.setStringList('posts', postsJson);
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

  void put(Post post) {
    // Se o post já existe, atualiza-o
    if (post.id != null && _items.containsKey(post.id)) {
      _items.update(post.id!, (_) => post);
      savePostToSharedPreferences(post);
    }

    // Se o post não existe ainda, cria um novo
    if (post.id == null) {
      final id = (_items.length + 1).toString();
      final newPost = Post(
        id: id,
        status: post.status,
        title: post.title,
        description: post.description,
        creatorId: post.creatorId,
        ownerId: post.ownerId,
        dateOfLending: post.dateOfLending,
        dateOfReturning: post.dateOfReturning,
      );
      _items[id] = newPost;
      savePostToSharedPreferences(newPost);
    }
    notifyListeners();
  }

  // Salva o post no SharedPreferences
  Future<void> savePostToSharedPreferences(Post post) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> postsJson = prefs.getStringList('posts') ?? [];
    final postJson = json.encode(post.toJson());
    if (postsJson.contains(postJson)) {
      postsJson.remove(postJson);
    }
    postsJson.add(postJson);
    await prefs.setStringList('posts', postsJson);
  }

  // Remove o post do SharedPreferences
  Future<void> removePostFromSharedPreferences(Post post) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> postsJson = prefs.getStringList('posts') ?? [];
    final postJson = json.encode(post.toJson());
    if (postsJson.contains(postJson)) {
      postsJson.remove(postJson);
      await prefs.setStringList('posts', postsJson);
    }
  }

  void remove(Post post) {
    if (post.id != null) {
      _items.remove(post.id);
      removePostFromSharedPreferences(post);
      notifyListeners();
    }
  }
}
