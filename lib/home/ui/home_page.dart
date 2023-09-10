
import 'package:appteste/appbar.dart';
import 'package:appteste/routes/app_routes.dart';
import 'package:appteste/views/posts_list.dart';
import 'package:flutter/material.dart';
import 'package:appteste/navigationbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//counter de clicks
class _MyHomePageState extends State<MyHomePage> {
  final scrollController = ScrollController();
  int _selectedIndex = 1;

  void onTap(int index)  {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.of(context).pushNamed('/posts-list');
        break;
      case 1:
        Navigator.of(context).pushNamed('/');
        break;
      case 2:
        Navigator.of(context).pushNamed('/user-form');
        break;
    }
  }
  //late final HomeController _homeController;

  @override
  void initState() {
    super.initState();
    //messages = Messages.of(context);
    //_homeController = context.read<HomeController>();
    //_homeController.initItems(messages);
    scrollController.addListener(() {
      //_homeController.pagination(scrollController);
    });
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
      body: const PostsList(),
      floatingActionButton: FloatingActionButton(
        focusColor: Colors.amberAccent,
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.POSTS_FORM, arguments: null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
