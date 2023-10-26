import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:appteste/models/posts/post_generico.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostsProvider extends ChangeNotifier {
//Lista

//salva a lista de strings
  void saveListToSharedPreferences(List<String> listaString) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("listaString", listaString);
  }

//busca a lista de strings
  Future<List<String>> getListFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? listaString = prefs.getStringList("listaString");
    return listaString ?? [];
  }

//Valores

  // Retorna todos os valores decodificados
  Future<List<Post>> decodePostsFromSharedPreferences(
      List<String> listaString) async {
    List<Post> decodedPosts = [];
    for (int i = 0; i < listaString.length; i++) {
      String jsonString = await SharedPreferences.getInstance()
          .then((prefs) => prefs.getString(listaString[i]) ?? '');

      // Verifica se jsonString é um JSON válido antes de decodificar
      if (jsonString.isNotEmpty) {
        dynamic decodedData = jsonDecode(jsonString);
        if (decodedData is Map<String, dynamic>) {
          Post post = Post.fromJson(decodedData);
          decodedPosts.add(post);
        }
      }
    }
    return decodedPosts;
  }

  Future<List<Post>> get all async {
    final List<String> listaString = await getListFromSharedPreferences();
    return decodePostsFromSharedPreferences(listaString);
  }

//returns lenght
  Future<int> getCount() async {
    List<String> lista = await getListFromSharedPreferences();
    return lista.length;
  }

// Retorna posts com base nos índices
  Future<Post> byIndex(int i) async {
    List<Post> allPosts = await all;
    if (i >= 0 && i < allPosts.length) {
      return allPosts[i];
    } else {
      throw Exception('Índice fora do intervalo');
    }
  }

  Future<Post> findById(String id) async {
    List<Post> allPosts = await all;
    return allPosts.firstWhere(
      (post) => post.id == id,
      orElse: () => Post(
          creatorId: '',
          title: '',
          description: '',
          dateOfLending: DateTime.now()),
    );
  }

//returns posts filtered by their status
  List<Post> filterPostsByStatus(List<Post> posts, String status) {
    return posts.where((post) => post.status == status).toList();
  }

  void put(Post post) async {
    // Gere um novo ID para o post
    int count = await getCount();
    String id = (count + 1).toString();
    post.id = id;
    // Adiciona ele na lista
    savePostToSharedPreferences(post);
    notifyListeners();
  }

  // Salva o post no SharedPreferences
  Future<void> savePostToSharedPreferences(Post post) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("post${post.id}", jsonEncode(post));
    List<String> lista =
        await getListFromSharedPreferences(); // Espera a operação assíncrona
    lista.add("post${post.id}");
    saveListToSharedPreferences(lista);
  }

// Remove o post do SharedPreferences
  Future<void> removePostFromSharedPreferences(Post post) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("post${post.id}")) {
      prefs.remove("post${post.id}");
      //list
      List<String> lista = await getListFromSharedPreferences();
      lista.remove("post${post.id}");
      saveListToSharedPreferences(lista);
    }
    notifyListeners();
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

  void remove(Post post) {
    if (post.id != null) {
      removePostFromSharedPreferences(post);
      notifyListeners();
    }
  }
}
