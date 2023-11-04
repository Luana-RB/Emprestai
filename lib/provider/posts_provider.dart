import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:appteste/models/posts/post_object.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostsProvider extends ChangeNotifier {
//List
//saves the list of encoded post to string
  Future<void> saveListToSharedPreferences(List<Post> posts) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> postStrings =
        posts.map((post) => jsonEncode(post)).toList();
    await prefs.setStringList("postList", postStrings);
  }

//gets string list and decodes to post
  Future<List<Post>> getListFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? listaString = prefs.getStringList("postList");
    if (listaString == null || listaString.isEmpty) {
      return [];
    }
    List<Post> posts = [];
    for (String item in listaString) {
      Map<String, dynamic> decodedPost = jsonDecode(item);
      Post post = Post.fromJson(decodedPost);
      posts.add(post);
    }
    return posts;
  }

//Values
//Retorns all posts values
  Future<List<Post>> getAll() async {
    List<Post> allPosts = await getListFromSharedPreferences();
    return allPosts;
  }

//Retorns list size/how many posts it has
  Future<int> getCount() async {
    List<Post> lista = await getListFromSharedPreferences();
    return lista.length;
  }

//Retorns post based on index
  Future<Post> byIndex(int i) async {
    List<Post> allPosts = await getAll();
    if (i >= 0 && i < allPosts.length) {
      return allPosts[i];
    } else {
      throw Exception('Índice fora do intervalo');
    }
  }

//Retorns post based on Id
  Future<Post> findById(String id) async {
    List<Post> allPosts = await getAll();
    return allPosts.firstWhere(
      (post) => post.id == id,
      orElse: () => Post(
          creatorId: '',
          title: '',
          description: '',
          dateOfLending: DateTime.now()),
    );
  }

//Retorns posts based on status
  List<Post> filterPostsByStatus(List<Post> posts, String status) {
    return posts.where((post) => post.status == status).toList();
  }

//Post state
//Add
  void put(Post post) async {
    if (post.id != null) {
      // If ID already exists, updates it
      await updatePost(post);
    } else {
      // If ID doesn't exist, creates it
      int count = await getCount();
      String id = (count + 1).toString();
      post.id = id;
      savePostToSharedPreferences(post);
    }
    notifyListeners();
  }

// Updates post with the new data
  Future<void> updatePost(Post post) async {
    final List<Post> allPosts = await getAll();
    for (int i = 0; i < allPosts.length; i++) {
      if (allPosts[i].id == post.id) {
        allPosts[i] = post;
        await saveListToSharedPreferences(allPosts); // Saves updated list
        break;
      }
    }
    notifyListeners();
  }

// Saves post in SharedPreferences
  Future<void> savePostToSharedPreferences(Post post) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("post${post.id}", jsonEncode(post));
    List<Post> lista = await getListFromSharedPreferences();
    int existingIndex = lista.indexWhere((element) => element.id == post.id);
    if (existingIndex != -1) {
      lista[existingIndex] = post;
    } else {
      lista.add(post);
    }
    await saveListToSharedPreferences(lista);
  }

//Deletes post
  void remove(Post post) {
    removePostFromSharedPreferences(post);
  }

// Removes post from SharedPreferences
  Future<void> removePostFromSharedPreferences(Post post) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("post${post.id}")) {
      prefs.remove("post${post.id}");
      List<Post> lista = await getListFromSharedPreferences();
      lista.removeWhere((element) => element.id == post.id);
      await saveListToSharedPreferences(lista);
      notifyListeners();
    }
  }

//Gets post
  Future<Post?> getPostFromSharedPreferences(Post post) async {
    final prefs = await SharedPreferences.getInstance();
    String? postString = prefs.getString("post${post.id}");
    if (postString != null) {
      Map<String, dynamic> decodedPost = jsonDecode(postString);
      return Post.fromJson(decodedPost);
    }
    return null;
  }
}
