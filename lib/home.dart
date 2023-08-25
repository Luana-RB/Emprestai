import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//counter de clicks
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
//aumenta o counter
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      drawer: Drawer(
        // Aqui você pode adicionar o conteúdo do seu menu lateral
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
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
