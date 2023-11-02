import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OptionsPage extends StatefulWidget {
  const OptionsPage({super.key, this.idUsuario});
  final String? idUsuario;

  @override
  OptionsPageState createState() => OptionsPageState();
}

class OptionsPageState extends State<OptionsPage> {
  late SharedPreferences _prefs;
  late String _prefsKey;
  late String userId;

  String selectedLanguage = 'pt';
  bool receiveNotifications = true;
  String contactMethod = 'telefone';

  @override
  void initState() {
    super.initState();
    userId = widget.idUsuario ?? 'null';
    _prefsKey = 'user_$userId';
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage =
          _prefs.getString('$_prefsKey-selectedLanguage') ?? 'pt';
      receiveNotifications =
          _prefs.getBool('$_prefsKey-receiveNotifications') ?? true;
      contactMethod =
          _prefs.getString('$_prefsKey-contactMethod') ?? 'telefone';
    });
  }

  Future<void> _saveSettings() async {
    await _prefs.setString('$_prefsKey-selectedLanguage', selectedLanguage);
    await _prefs.setBool(
        '$_prefsKey-receiveNotifications', receiveNotifications);
    await _prefs.setString('$_prefsKey-contactMethod', contactMethod);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Opções do Aplicativo',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Língua',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary)),
            trailing: DropdownButton<String>(
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              value: selectedLanguage,
              onChanged: (String? newValue) {
                setState(() {
                  selectedLanguage = newValue!;
                });
              },
              items: <String>['pt', 'en']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          SwitchListTile(
            title: Text('Notificações',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary)),
            value: receiveNotifications,
            onChanged: (value) {
              setState(() {
                receiveNotifications = value;
              });
            },
          ),
          ListTile(
            title: Text('Formas de Contato',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary)),
            trailing: DropdownButton<String>(
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              value: contactMethod,
              onChanged: (String? newValue) {
                setState(() {
                  contactMethod = newValue!;
                });
              },
              items: <String>['telefone', 'e-mail']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          ListTile(
            title: const Text(
              'Apagar Conta do Usuário',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              // Adicione aqui a lógica para apagar a conta do usuário
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        onPressed: () {
          _saveSettings();
          Navigator.pop(context);
        },
        child: Icon(Icons.save, color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
