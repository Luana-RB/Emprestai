import 'package:appteste/views/posts_list.dart';
import 'package:appteste/views/profile_page.dart';
import 'package:flutter/material.dart';

class LendingPanel extends StatefulWidget {
  const LendingPanel({super.key, this.idUsuario});
  final String? idUsuario;

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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MyProfilePage(idUsuario: widget.idUsuario.toString()),
              ),
            );
          },
        ),
        title: const Text(title, style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: PostsPanel(idUsuario: widget.idUsuario.toString()),
    );
  }
}
