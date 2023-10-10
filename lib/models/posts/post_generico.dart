//import 'package:flutter/material.dart';

class Post {
  String? id;
  String? status;
  String? title;
  String? imageUrl;
  String? description;
  String? creatorName;
  //String? creatorProfileLink;
  // String? creatorImageUrl;
  String? ownerName;
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
    required this.creatorName,
    //this.creatorProfileLink,
    //this.creatorImageUrl,
    this.ownerName,
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

  set setCreatorName(String newCreatorName) {
    creatorName = newCreatorName;
  }

  set setCreatorImageUrl(String newCreatorImageUrl) {
    //creatorImageUrl = newCreatorImageUrl;
  }
  set setOwnerName(String newOwnerName) {
    //ownerName = newOwnerName;
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
