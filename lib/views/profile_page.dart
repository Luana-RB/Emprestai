import 'package:appteste/appbar.dart';
import 'package:appteste/image_helper.dart';
import 'package:appteste/navigationbar.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final scrollController = ScrollController();
  int _selectedIndex = 0;

  void onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.of(context).pushNamed('/profile-page');
        break;
      case 1:
        Navigator.of(context).pushNamed('/home-page');
        break;
      case 2:
        Navigator.of(context).pushNamed('/chat-selection');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    String title = "Usuário";
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBarPage(title: title)),
      drawer: const MyDrawer(),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: onTap,
      ),
      body: const Center(
        child: Column(
          children: [
            SizedBox(height: 10),
//Profile Image
            Padding(
                padding: EdgeInsets.all(8.0),
                child: ProfilePicture(initials: "LP")),
            SizedBox(height: 10),
//Name
            Text(
              'Nome do Usuário',
              style: TextStyle(fontSize: 20),
              softWrap: true,
            ),
            Row(
              children: [
//Email
                Expanded(
                  child: Text(
                    'Email do Usuário',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black38,
                    ),
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key, required this.initials});

  final String initials;
  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    final imageHelper = ImageHelper(context);
    return Column(
      children: [
        Center(
          child: FittedBox(
            fit: BoxFit.contain,
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 64,
              foregroundImage: _image != null ? FileImage(_image!) : null,
              child: Text(
                widget.initials,
                style: const TextStyle(fontSize: 48),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () async {
            final XFile? files = await imageHelper.pickImage();
            if (files != null) {
              final croppedFile = await imageHelper.crop(
                file: files,
                cropStyle: CropStyle.circle,
              );
              if (croppedFile != null) {
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
