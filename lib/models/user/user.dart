//import 'package:flutter/material.dart';

class User {
  String? id;
  String? name;
  String? email;
  String? password;
  String? avatarUrl;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.avatarUrl,
  });

  set setName(String newName) {
    name = newName;
  }

  set setEmail(String newEmail) {
    email = newEmail;
  }

  set setPassword(String newPassword) {
    password = newPassword;
  }

  set setAvatarUrl(String newAvatarUrl) {
    avatarUrl = newAvatarUrl;
  }
}
