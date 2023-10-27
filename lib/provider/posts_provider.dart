import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:appteste/models/posts/post_object.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostsProvider extends ChangeNotifier {
//Lista
//salva a lista de post encodados para string
  Future<void> saveListToSharedPreferences(List<Post> posts) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> postStrings =
        posts.map((post) => jsonEncode(post)).toList();
    await prefs.setStringList("postList", postStrings);
  }

//busca a lista de strings e decoda para post
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

//Valores
//Retorna os valores dos posts
  Future<List<Post>> getAll() async {
    List<Post> allPosts = await getListFromSharedPreferences();
    return allPosts;
  }

//Retorna o tamanho da lista / quantos posts tem
  Future<int> getCount() async {
    List<Post> lista = await getListFromSharedPreferences();
    return lista.length;
  }

//Retorna post baseado no índice
  Future<Post> byIndex(int i) async {
    List<Post> allPosts = await getAll();
    if (i >= 0 && i < allPosts.length) {
      return allPosts[i];
    } else {
      throw Exception('Índice fora do intervalo');
    }
  }

//Retorna post baseado no Id
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

//Retorna posts baseados no status
  List<Post> filterPostsByStatus(List<Post> posts, String status) {
    return posts.where((post) => post.status == status).toList();
  }

//Estado de post
//Acionar
  void put(Post post) async {
    if (post.id != null) {
      // Se o ID do post já existe, atualize-o
      await updatePost(post);
    } else {
      // Se o ID do post não existe, crie um novo
      int count = await getCount();
      String id = (count + 1).toString();
      post.id = id;
      savePostToSharedPreferences(post);
    }
    notifyListeners();
  }

// Atualize o post existente com os novos dados
  Future<void> updatePost(Post post) async {
    final List<Post> allPosts = await getAll();
    for (int i = 0; i < allPosts.length; i++) {
      if (allPosts[i].id == post.id) {
        allPosts[i] =
            post; // Substitui o post antigo pelo post atualizado na lista
        await saveListToSharedPreferences(allPosts); // Salva a lista atualizada
        break;
      }
    }
    notifyListeners();
  }

// Salva o post no SharedPreferences
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

//Deleta post
  void remove(Post post) {
    removePostFromSharedPreferences(post);
  }

// Remove o post do SharedPreferences
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

//Busca post
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
