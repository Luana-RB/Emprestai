import 'package:appteste/views/posts_form.dart';
import 'package:appteste/components/posts_list.dart';
import 'package:appteste/views/profile_page.dart';
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
        backgroundColor: Theme.of(context).colorScheme.onTertiary,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyProfilePage(
                  idUsuario: widget.idUsuario.toString(),
                ),
              ),
            );
          },
        ),
        title: Text(title,
            style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
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
            backgroundColor: Theme.of(context).colorScheme.secondary,
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
            child: Icon(
              Icons.add,
              size: 40,
              color: Theme.of(context).colorScheme.background,
            ),
          ),
        ),
      ),
    );
  }
}
