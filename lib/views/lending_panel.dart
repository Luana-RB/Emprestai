import 'package:appteste/views/posts_form.dart';
import 'package:appteste/views/posts_list.dart';
import 'package:flutter/material.dart';

class LendingPanel extends StatefulWidget {
  const LendingPanel({super.key, this.idUsuario, required this.fromHomePage});
  final String? idUsuario;
  final bool fromHomePage;

  @override
  State<LendingPanel> createState() => _LendingPanelState();
}

class _LendingPanelState extends State<LendingPanel> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    const String title = 'Painel de Empréstimo';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(title, style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: PostsPanel(
        idUsuario: widget.idUsuario.toString(),
        fromHomePage: false,
      ),
//New Post
      floatingActionButton: Align(
        alignment: const Alignment(0.975, 0.975),
        child: SizedBox(
          width: 70, // Ajuste a largura conforme necessário
          height: 70,
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostsForm(
                      idUsuario: widget.idUsuario.toString(),
                      fromHomePage: false),
                ),
              );
            },
            child: const Icon(Icons.add, size: 40),
          ),
        ),
      ),
    );
  }
}
