import 'dart:io';
import 'package:appteste/components/images/image_helper.dart';
import 'package:appteste/models/posts/post_object.dart';
import 'package:appteste/provider/posts_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
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
  late Post post;

//estado inicial
  @override
  void initState() {
    super.initState();
    imageHelper = ImageHelper(context);
    _image = null;
    post = Post(
        id: null,
        imagePath: null,
        title: '',
        description: '',
        creatorId: '',
        dateOfLending: DateTime.now());
    initPrefs();
    _image = post.imagePath != null ? File(post.imagePath!) : null;
  }

//busca imagem inicial
  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    // ignore: use_build_context_synchronously
    post = await Provider.of<PostsProvider>(context, listen: false)
        .findById(widget.postId);
    getImageFromSharedPreferences();
  }

//busca key
  String getPrefsKey() {
    return 'imagePath_${widget.postId}';
  }

//busca string pela key
  Future<void> getImageFromSharedPreferences() async {
    final imagePath = post.imagePath;
    if (imagePath != null) {
      setState(() {
        _image = File(imagePath);
      });
    }
  }

//salva o novo string no key
  Future<void> saveImagePathToPrefs(String path) async {
    post.imagePath = path;
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
