import 'dart:io';
import 'package:appteste/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostPicture extends StatefulWidget {
  const PostPicture({Key? key, required this.postId}) : super(key: key);

  final String postId;

  @override
  State<PostPicture> createState() => _PostPictureState();
}

class _PostPictureState extends State<PostPicture> {
  late File? _image;
  late ImageHelper imageHelper;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    imageHelper = ImageHelper(context);
    _image = null;
    initPrefs();
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    getImageFromSharedPreferences();
  }

  String getPrefsKey() {
    return 'imagePath_${widget.postId}';
  }

  Future<void> getImageFromSharedPreferences() async {
    final imagePath = prefs.getString(getPrefsKey());
    if (imagePath != null) {
      setState(() {
        _image = File(imagePath);
      });
    }
  }

  Future<void> saveImagePathToPrefs(String path) async {
    await prefs.setString(getPrefsKey(), path);
  }

  FileImage? getImageFromPath() {
    final prefsKey = 'imagePath_${widget.postId}';
    final imagePath = prefs.getString(prefsKey);
    if (imagePath != null) {
      return FileImage(File(imagePath));
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final XFile? files = await imageHelper.pickImage();
        if (files != null) {
          final croppedFile = await imageHelper.crop(
            file: files,
            cropStyle: CropStyle.circle,
          );
          if (croppedFile != null) {
            await saveImagePathToPrefs(croppedFile.path);
            setState(() {
              _image = File(croppedFile.path);
            });
          }
        }
      },
      child: const Text('Selecione Imagem Demonstrativa'),
    );
  }
}
