import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppBarPage extends StatelessWidget {
  const AppBarPage({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(title),
      centerTitle: true,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Abre o drawer (menu lateral)
            },
          );
        },
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.2,
       child: Drawer(
  child: Column(
      children: <Widget>[
        Container(
          height: 100,
          color: Colors.pinkAccent,
          child: const Center(
            child: Text(
              'Menu',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(onPressed: (){}, icon: const Icon(Icons.settings, size: 40)),
        ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton(onPressed: (){ exit(0);}, child: const Text('Sair', style: TextStyle(
                fontSize: 18,)),
      ),)
      ],
    ),
    ));
  }
}
