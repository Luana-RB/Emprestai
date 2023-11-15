import 'package:appteste/components/appbar.dart';
import 'package:appteste/components/chat_tile.dart';
import 'package:appteste/models/user/user.dart';
import 'package:appteste/provider/users_provider.dart';
import 'package:appteste/views/home_page.dart';
import 'package:appteste/components/navigationbar.dart';
import 'package:appteste/views/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatSelectionPage extends StatefulWidget {
  const ChatSelectionPage({super.key, this.idUsuario});
  final String? idUsuario;
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

  @override
  Widget build(BuildContext context) {
    String title = "Bate-papos";
    final UsersProvider chatUsers = Provider.of(context);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBarPage(title: title)),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: onTap,
      ),
      body: FutureBuilder<int>(
        future: chatUsers.getCount(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Erro: ${snapshot.error}');
          } else {
            int itemCount = snapshot.data ?? 0;
            return ListView.builder(
              itemCount: itemCount,
              itemBuilder: (ctx, i) {
                return FutureBuilder<User>(
                  future: chatUsers.byIndex(i),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (userSnapshot.hasError) {
                      return Text('Erro: ${userSnapshot.error}');
                    } else {
                      User user = userSnapshot.data!;
                      return ChatTile(user: user);
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
