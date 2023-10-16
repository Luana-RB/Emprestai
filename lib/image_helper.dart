import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageHelper {
  final scrollController = ScrollController();
  final BuildContext context;
//Initializing ImagePicker and ImageCropper
  ImageHelper(
    this.context, {
    ImagePicker? imagePicker,
    ImageCropper? imageCropper,
  })  : _imagePicker = imagePicker ?? ImagePicker(),
        _imageCropper = imageCropper ?? ImageCropper();
  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;

//pick only 1 Image
  Future<XFile?> pickImage({
    ImageSource source = ImageSource.gallery,
    int imageQuality = 100,
  }) async {
    return await _imagePicker.pickImage(
      source: source,
      imageQuality: imageQuality,
    );
  }

//crop Image
  Future<CroppedFile?> crop({
    required XFile file,
    CropStyle cropStyle = CropStyle.rectangle,
  }) async =>
      await _imageCropper.cropImage(
        cropStyle: cropStyle,
        sourcePath: file.path,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.pink,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),

          /// this settings is required for Web
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            enableResize: true,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
                const CroppieViewPort(width: 480, height: 480, type: 'circle'),
          )
        ],
      );

// Salva o arquivo em SharedPreferences
  void saveImageToSharedPreferences(XFile file) async {
    final prefs = await SharedPreferences.getInstance();
    final bytes = await file.readAsBytes();
    final encoded = base64Encode(bytes);
    prefs.setString('image', encoded);
  }

  // Resgata o arquivo de SharedPreferences
  Future<XFile?> getImageFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = prefs.getString('image');
    if (encoded != null) {
      final bytes = base64Decode(encoded);
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/temp.png');
      await file.writeAsBytes(bytes);
      return XFile(file.path);
    }
    return null;
  }
}
