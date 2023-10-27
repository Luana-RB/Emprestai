class Post {
  String? id;
  String? status;
  String? title;
  String? description;
  String? creatorId;
  String? ownerId;
  DateTime? dateOfLending;
  DateTime? dateOfReturning;
  String? imagePath;

  Post({
    this.id,
    this.status,
    required this.title,
    required this.description,
    required this.creatorId,
    this.ownerId,
    required this.dateOfLending,
    this.dateOfReturning,
    this.imagePath,
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
      'dateOfLending': dateOfLending?.toIso8601String(),
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
      dateOfLending: json['dateOfLending'] != null
          ? DateTime.parse(json['dateOfLending'])
          : null,
      dateOfReturning: json['dateOfReturning'] != null
          ? DateTime.parse(json['dateOfReturning'])
          : null,
    );
  }
}
