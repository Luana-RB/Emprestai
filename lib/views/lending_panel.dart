import 'package:appteste/appbar.dart';
import 'package:appteste/views/posts_list.dart';
import 'package:flutter/material.dart';

class LendingPanel extends StatefulWidget {
  const LendingPanel({super.key, this.nomeUsuario});
  final String? nomeUsuario;

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
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50), child: AppBarPage(title: title)),
      drawer: const MyDrawer(),
      body: PostsPanel(nomeUsuario: widget.nomeUsuario.toString()),
    );
  }
}
