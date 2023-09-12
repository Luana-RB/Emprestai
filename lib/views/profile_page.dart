import 'package:appteste/appbar.dart';
import 'package:appteste/navigationbar.dart';
import 'package:flutter/material.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
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
        Navigator.of(context).pushNamed('/');
        break;
      case 2:
        Navigator.of(context).pushNamed('/user-form');
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
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
//Profile Image
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  'https://cdn-icons-png.flaticon.com/512/1468/1468166.png',
                  width: 350,
                  height: 350,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
//Name
              const Text('Nome do Usuário',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  softWrap:
                      true // Permite que o texto seja quebrado automaticamente
                  ),
              const Row(
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
                  )),
//
                ],
              ),
            ],
          ),
        ));
  }
}
