// ignore_for_file: unnecessary_null_comparison

import 'package:appteste/models/user/user.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UsersProvider extends ChangeNotifier {
  //List
//saves the list of encoded post to string
  Future<void> saveListToSharedPreferences(List<User> users) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> userStrings =
        users.map((user) => jsonEncode(user)).toList();
    await prefs.setStringList("userList", userStrings);
  }

//gets string list and decodes to post
  Future<List<User>> getListFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? listaString = prefs.getStringList("userList");
    if (listaString == null || listaString.isEmpty) {
      return [];
    }
    List<User> users = [];
    for (String item in listaString) {
      Map<String, dynamic> decodedUser = jsonDecode(item);
      User user = User.fromJson(decodedUser);
      users.add(user);
    }
    return users;
  }

//Values
//Retorns all posts values
  Future<List<User>> getAll() async {
    List<User> allUsers = await getListFromSharedPreferences();
    return allUsers;
  }

//Retorns list size/how many posts it has
  Future<int> getCount() async {
    List<User> lista = await getListFromSharedPreferences();
    return lista.length;
  }

//Retorns post based on index
  Future<User> byIndex(int i) async {
    List<User> allUsers = await getAll();
    if (i >= 0 && i < allUsers.length) {
      return allUsers[i];
    } else {
      throw Exception('Índice fora do intervalo');
    }
  }

//Retorns post based on Id
  Future<User> findById(String id) async {
    List<User> allUsers = await getAll();
    return allUsers.firstWhere((user) => user.id == id,
        orElse: () => User(
              name: '',
              email: '',
              password: '',
            ));
  }

//Post state
//Add
  void put(User user) async {
    if (user.id != null) {
      // If ID already exists, updates it
      await updateUser(user);
    } else {
      // If ID doesn't exist, creates it
      int count = await getCount();
      String id = (count + 1).toString();
      user.id = id;
      saveUserToSharedPreferences(user);
    }
    notifyListeners();
  }

// Updates post with the new data
  Future<void> updateUser(User user) async {
    final List<User> allUsers = await getAll();
    for (int i = 0; i < allUsers.length; i++) {
      if (allUsers[i].id == user.id) {
        allUsers[i] = user;
        await saveListToSharedPreferences(allUsers); // Saves updated list
        break;
      }
    }
    notifyListeners();
  }

// Saves post in SharedPreferences
  Future<void> saveUserToSharedPreferences(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("user${user.id}", jsonEncode(user));
    List<User> lista = await getListFromSharedPreferences();
    int existingIndex = lista.indexWhere((element) => element.id == user.id);
    if (existingIndex != -1) {
      lista[existingIndex] = user;
    } else {
      lista.add(user);
    }
    await saveListToSharedPreferences(lista);
  }

//Deletes post
  void remove(User user) {
    removeUserFromSharedPreferences(user);
  }

// Removes post from SharedPreferences
  Future<void> removeUserFromSharedPreferences(User user) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("user${user.id}")) {
      prefs.remove("user${user.id}");
      List<User> lista = await getListFromSharedPreferences();
      lista.removeWhere((element) => element.id == user.id);
      await saveListToSharedPreferences(lista);
      notifyListeners();
    }
  }

//Gets post
  Future<User?> getUserFromSharedPreferences(User user) async {
    final prefs = await SharedPreferences.getInstance();
    String? userString = prefs.getString("user${user.id}");
    if (userString != null) {
      Map<String, dynamic> decodedUser = jsonDecode(userString);
      return User.fromJson(decodedUser);
    }
    return null;
  }
}
