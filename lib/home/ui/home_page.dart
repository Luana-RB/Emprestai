import 'package:appteste/appbar.dart';
import 'package:appteste/routes/app_routes.dart';
import 'package:appteste/views/chat_selection_page.dart';
import 'package:appteste/views/posts_list.dart';
import 'package:appteste/views/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:appteste/navigationbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.nomeUsuario});
  final String? nomeUsuario;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final scrollController = ScrollController();
  int _selectedIndex = 1;

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
  void initState() {
    super.initState();
    scrollController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    const String title = 'Emprestaí';
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50), child: AppBarPage(title: title)),
      drawer: const MyDrawer(),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: onTap,
      ),
      body: PostsList(
        nomeUsuario: widget.nomeUsuario.toString(),
      ),
      floatingActionButton: FloatingActionButton(
        focusColor: Colors.amberAccent,
        onPressed: () {
          Navigator.of(context)
              .pushNamed(AppRoutes.POSTS_FORM, arguments: null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
