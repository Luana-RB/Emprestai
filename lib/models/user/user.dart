//import 'package:flutter/material.dart';

class User {
  String? id;
  final String name;
  final String email;
  final String password;
  final String groupName;
  String? avatarUrl;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.groupName,
    this.avatarUrl,
  });
}
