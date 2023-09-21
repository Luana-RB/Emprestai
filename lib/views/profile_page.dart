import 'package:appteste/appbar.dart';
import 'package:appteste/home/ui/home_page.dart';
import 'package:appteste/image_helper.dart';
import 'package:appteste/navigationbar.dart';
import 'package:appteste/views/chat_selection_page.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key, this.nomeUsuario}) : super(key: key);
  final String? nomeUsuario;

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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MyProfilePage(nomeUsuario: widget.nomeUsuario),
          ),
        );
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(nomeUsuario: widget.nomeUsuario),
          ),
        );
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ChatSelectionPage(nomeUsuario: widget.nomeUsuario),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    String title = "Usuário";
    String nome = (widget.nomeUsuario).toString();

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBarPage(title: title)),
      drawer: const MyDrawer(),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: onTap,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
//Profile Image
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProfilePicture(initials: (nome[0].toUpperCase()))),
            const SizedBox(height: 10),
//Name
            Text(
              nome,
              style: const TextStyle(fontSize: 20),
              softWrap: true,
            ),
            const SizedBox(height: 100),
            Container(
              width: 250,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.pinkAccent, // Cor de fundo do Container
                borderRadius: BorderRadius.circular(10.0), // Borda arredondada
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Sombra
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Pasta de Empréstimos',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            )
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
