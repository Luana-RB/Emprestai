import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Post {
  String? id;
  String? status;
  String? title;
  String? description;
  String? creatorId;
  String? ownerId;
  DateTime dateOfLending;
  DateTime? dateOfReturning;

  Post({
    this.id,
    this.status,
    required this.title,
    required this.description,
    required this.creatorId,
    this.ownerId,
    required this.dateOfLending,
    this.dateOfReturning,
  });

  set setId(String newId) {
    id = newId;
  }

  set setStatus(String newStatus) {
    status = newStatus;
  }

  set setTitle(String newTitle) {
    title = newTitle;
  }

  set setDescription(String newDescription) {
    description = newDescription;
  }

  set setOwnerId(String newOwnerId) {
    ownerId = newOwnerId;
  }

  set setDateOfLending(DateTime newDateOfLending) {
    dateOfLending = newDateOfLending;
  }

  set setDateOfReturning(DateTime newDateOfReturning) {
    dateOfReturning = newDateOfReturning;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'title': title,
      'description': description,
      'creatorId': creatorId,
      'ownerId': ownerId,
      'dateOfLending': dateOfLending.toIso8601String(),
      'dateOfReturning': dateOfReturning?.toIso8601String(),
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      status: json['status'],
      title: json['title'],
      description: json['description'],
      creatorId: json['creatorId'],
      ownerId: json['ownerId'],
      dateOfLending: DateTime.parse(json['dateOfLending']),
      dateOfReturning: json['dateOfReturning'] != null
          ? DateTime.parse(json['dateOfReturning'])
          : null,
    );
  }
}

class PostStorage {
  late SharedPreferences _prefs;

  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> savePost(Post post) async {
    final posts = _prefs.getStringList('posts') ?? [];
    final postJson = json.encode(post.toJson());
    posts.add(postJson);
    await _prefs.setStringList('posts', posts);
  }

  List<Post> getPosts() {
    final posts = _prefs.getStringList('posts');
    if (posts != null) {
      return posts
          .map((postJson) => Post.fromJson(json.decode(postJson)))
          .toList();
    } else {
      return [];
    }
  }
}
