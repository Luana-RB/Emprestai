import 'package:appteste/components/appbar.dart';
import 'package:appteste/routes/app_routes.dart';
import 'package:appteste/views/chat_selection_page.dart';
import 'package:appteste/components/posts_list.dart';
import 'package:appteste/views/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:appteste/components/navigationbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.idUsuario});
  final String? idUsuario;

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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyProfilePage(idUsuario: widget.idUsuario),
          ),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(idUsuario: widget.idUsuario),
          ),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ChatSelectionPage(idUsuario: widget.idUsuario),
          ),
        );
        break;
    }
  }

  // Método para recarregar a lista de posts
  void reloadPostsList() {
    setState(() {});
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
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: onTap,
      ),
      body: PostsList(
        key: UniqueKey(),
        idUsuario: widget.idUsuario.toString(),
        fromHomePage: true,
      ),
//New Post
      floatingActionButton: Align(
        alignment: const Alignment(0.975, 0.975),
        child: SizedBox(
          width: 70,
          height: 70,
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(AppRoutes.POSTS_FORM, arguments: widget.idUsuario)
                  .then((value) {
                reloadPostsList();
              });
            },
            child: Icon(Icons.add,
                size: 40, color: Theme.of(context).colorScheme.background),
          ),
        ),
      ),
    );
  }
}
