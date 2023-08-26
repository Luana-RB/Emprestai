import 'package:flutter/material.dart';

class PostViewModel {
  final int id;
  final String title;
  final String urlImage;
  final String status;
  final Color backGroundColor;
  final String creatorName;
  final String creatorGroup;

  PostViewModel({
    required this.id,
    required this.title,
    required this.urlImage,
    required this.status,
    required this.backGroundColor,
    required this.creatorName,
    required this.creatorGroup,
  });
  /*
  factory PostViewModel.fromPostModel(PostModel postModel) {
    return PostViewModel(
      id: postModel.id,
      title: postModel.title,
      urlImage: postModel.urlImage,
      status: postModel.status,
      backGroundColor: postModel.colorGroup,
    );
  }*/
}
