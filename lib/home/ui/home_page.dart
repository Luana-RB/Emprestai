import 'package:appteste/appbar.dart';
import 'package:appteste/routes/app_routes.dart';
import 'package:flutter/material.dart';
//import 'package:appteste/main.dart';
//import 'package:appteste/routes/app_routes.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//counter de clicks
class _MyHomePageState extends State<MyHomePage> {
  final scrollController = ScrollController();
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
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        focusColor: Colors.amberAccent,
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.USER_LIST);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
