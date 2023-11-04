import 'dart:io';
import 'package:appteste/components/images/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture(
      {Key? key,
      required this.initials,
      this.userImage,
      required this.userId,
      this.color,
      required this.size,
      required this.isSelect})
      : super(key: key);

  final String? userImage;
  final String initials;
  final String userId;
  final Color? color;
  final double size;
  final bool isSelect;

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
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
    return 'imagePath_u${widget.userId}';
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
        Center(
          child: FittedBox(
            fit: BoxFit.contain,
            child: CircleAvatar(
              backgroundColor: widget.color,
              radius: MediaQuery.of(context).size.width * widget.size,
              foregroundImage: _image != null ? FileImage(_image!) : null,
              child: Text(
                widget.initials,
                style: TextStyle(
                    fontSize: 48,
                    color: Theme.of(context).colorScheme.background),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        widget.isSelect
            ? TextButton(
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
                child: Text(
                  'Select Photo',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
