import 'package:appteste/appbar.dart';
import 'package:flutter/material.dart';

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
    return const Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50), child: AppBarPage(title: title)),
      drawer: MyDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
