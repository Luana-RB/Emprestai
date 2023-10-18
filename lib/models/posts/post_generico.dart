//import 'package:flutter/material.dart';

class Post {
  String? id;
  String? status;
  String? title;
  String? imageUrl;
  String? description;
  String? creatorId;
  //String? creatorProfileLink;
  // String? creatorImageUrl;
  String? ownerId;
  //String? ownerProfileLink;
  //String? ownerImageUrl;
  DateTime dateOfLending;
  //String? dateOfReturning;

  Post({
    this.id,
    this.status,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.creatorId,
    //this.creatorProfileLink,
    //this.creatorImageUrl,
    this.ownerId,
    //this.ownerProfileLink,
    //this.ownerImageUrl,
    required this.dateOfLending,
    //this.dateOfReturning,
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

  set setImageUrl(String newImageUrl) {
    imageUrl = newImageUrl;
  }

  set setDescription(String newDescription) {
    description = newDescription;
  }

  set setCreatorImageUrl(String newCreatorImageUrl) {
    //creatorImageUrl = newCreatorImageUrl;
  }
  set setOwnerId(String newOwnerId) {
    ownerId = newOwnerId;
  }

  set setOwnerProfileLink(String newOwnerProfileLink) {
    //ownerProfileLink = newOwnerProfileLink;
  }
  set setOwnerImageUrl(String newOwnerImageUrl) {
    //ownerImageUrl = newOwnerImageUrl;
  }
  set setDateOfLending(DateTime newDateOfLending) {
    dateOfLending = newDateOfLending;
  }

  set setDateOfReturning(String newDateOfReturning) {
    //dateOfReturning = newDateOfReturning;
  }
}
