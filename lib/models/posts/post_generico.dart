import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
      'title': title,
      'description': description,
      'creatorId': creatorId,
      'ownerId': ownerId,
      'dateOfLending': dateOfLending.millisecondsSinceEpoch,
      'dateOfReturning': dateOfReturning != null
          ? dateOfReturning!.millisecondsSinceEpoch
          : null,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'],
      status: map['status'],
      title: map['title'],
      description: map['description'],
      creatorId: map['creatorId'],
      ownerId: map['ownerId'],
      dateOfLending: DateTime.fromMillisecondsSinceEpoch(map['dateOfLending']),
      dateOfReturning: map['dateOfReturning'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateOfReturning'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));
}
