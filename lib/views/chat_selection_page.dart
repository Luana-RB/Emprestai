import 'package:appteste/appbar.dart';
import 'package:appteste/components/chat_tile.dart';
import 'package:appteste/home/ui/home_page.dart';
import 'package:appteste/navigationbar.dart';
import 'package:appteste/provider/chat_users_provider.dart';
import 'package:appteste/views/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatSelectionPage extends StatefulWidget {
  const ChatSelectionPage({super.key, this.nomeUsuario});
  final String? nomeUsuario;
  @override
  State<ChatSelectionPage> createState() => _ChatSelectionPageState();
}

class _ChatSelectionPageState extends State<ChatSelectionPage> {
  final scrollController = ScrollController();
  int _selectedIndex = 2;

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
  Widget build(BuildContext context) {
    String title = "Bate-papos";
    final ChatUsersProvider chatUsers = Provider.of(context);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBarPage(title: title)),
      drawer: const MyDrawer(),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: onTap,
      ),
      body: ListView.builder(
        itemCount: chatUsers.count,
        itemBuilder: (ctx, i) => ChatTile(user: chatUsers.byIndex(i)),
      ),
    );
  }
}