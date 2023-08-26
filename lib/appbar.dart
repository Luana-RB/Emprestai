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
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
            ),
            child: Text('Menu'),
          ),
          ListTile(
            title: const Text('Opções'),
            onTap: () {
              if (kDebugMode) {
                print('opções');
              }
            },
          ),
          ListTile(
            title: const Text('Sair'),
            onTap: () {
              if (kDebugMode) {
                print('sair');
              }
            },
          ),
          // Adicione mais itens do menu lateral, se necessário
        ],
      ),
    );
  }
}
