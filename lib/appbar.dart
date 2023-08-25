import 'package:flutter/material.dart';

class AppBarPage extends StatefulWidget {
  const AppBarPage({super.key, required this.title});
  final String title;

  @override
  State<AppBarPage> createState() => _AppBarState();
}

class _AppBarState extends State<AppBarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context)
                    .openDrawer(); // Abre o drawer (menu lateral)
              },
            );
          },
        ),
      ),
      drawer: Drawer(
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
                // Adicione a lógica para o item 1 aqui
              },
            ),
            ListTile(
              title: const Text('Sair'),
              onTap: () {
                // Adicione a lógica para o item 2 aqui
              },
            ),
            // Adicione mais itens do menu lateral, se necessário
          ],
        ),
      ),
    );
  }
}
