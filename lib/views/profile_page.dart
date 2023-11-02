import 'package:appteste/components/appbar.dart';
import 'package:appteste/components/images/profile_picture.dart';
import 'package:appteste/models/user/user.dart';
import 'package:appteste/provider/users_provider.dart';
import 'package:appteste/views/home_page.dart';
import 'package:appteste/components/navigationbar.dart';
import 'package:appteste/views/chat_selection_page.dart';
import 'package:appteste/views/lending_panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key, this.idUsuario}) : super(key: key);
  final String? idUsuario;

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final scrollController = ScrollController();
  int _selectedIndex = 0;

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
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final User? thisUser = usersProvider.all.isNotEmpty
        ? usersProvider.all.firstWhere(
            (user) => user.id == widget.idUsuario.toString(),
            orElse: () => User(name: 'null', id: 'null'))
        : null;
    String userName = thisUser != null ? thisUser.name.toString() : 'null';
    String userId = thisUser != null ? thisUser.id.toString() : 'null';

    const String title = 'Perfil de Usuário';
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50), child: AppBarPage(title: title)),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: onTap,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40),
//Profile Image
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProfilePicture(
                  initials: userName[0].toUpperCase(),
                  userId: userId,
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  size: 0.2,
                  isSelect: true,
                )),
            const SizedBox(height: 16),
//Name
            Text(
              userName,
              style: TextStyle(
                  fontSize: 25, color: Theme.of(context).colorScheme.secondary),
              softWrap: true,
            ),
            const SizedBox(height: 40),
//Panel Button
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.11,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10.0), // Borda arredondada
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.shadow,
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LendingPanel(
                          idUsuario: userId,
                          fromHomePage: false,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Painel de Empréstimos',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
