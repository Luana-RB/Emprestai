import 'dart:io';
import 'package:appteste/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostPicture extends StatefulWidget {
  const PostPicture({
    Key? key,
    required this.postId,
    required this.isSelect,
    required this.height,
    required this.width,
  }) : super(key: key);

  final String postId;
  final bool isSelect;
  final double height;
  final double width;

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.isSelect
            ? Center(
                //child: FittedBox(
                //fit: BoxFit.contain,
                child: Container(
                  width: MediaQuery.of(context).size.width * widget.width,
                  height: MediaQuery.of(context).size.height * widget.height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    image: _image != null
                        ? DecorationImage(
                            image: FileImage(_image!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: Text(
                    widget.isSelect != true ? 'sem' : '',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                // ),
              )
            : const SizedBox(width: 10),
        const SizedBox(height: 8),
        widget.isSelect
            ? const SizedBox.shrink()
            : TextButton(
                onPressed: () async {
                  final XFile? files = await imageHelper.pickImage();
                  if (files != null) {
                    final croppedFile = await imageHelper.crop(
                      file: files,
                      cropStyle: CropStyle.rectangle,
                    );
                    if (croppedFile != null) {
                      await saveImagePathToPrefs(croppedFile.path);
                      setState(() {
                        _image = File(croppedFile.path);
                      });
                    }
                  }
                },
                child: const Text('Select Photo'),
              )
      ],
    );
  }
}
