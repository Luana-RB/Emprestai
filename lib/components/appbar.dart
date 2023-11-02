import 'package:appteste/views/login_page.dart';
import 'package:appteste/views/options_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBarPage extends StatelessWidget {
  const AppBarPage({super.key, required this.title, this.idUsuario});
  final String title;
  final String? idUsuario;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(title,
          style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
      centerTitle: true,
      automaticallyImplyLeading: false,
      actions: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(0, 16, 10, 20),
          child: DropdownButton<String>(
            underline: Container(),
            icon: Icon(Icons.settings,
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                size: 23),
            items: <String>['Configuração', 'Sair'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary)),
              );
            }).toList(),
            onChanged: (String? newValue) async {
              if (newValue == 'Configuração') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OptionsPage(idUsuario: idUsuario),
                    ));
              } else if (newValue == 'Sair') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', false);
              }
            },
          ),
        ),
      ],
    );
  }
}
