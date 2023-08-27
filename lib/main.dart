import 'package:appteste/home/ui/home_page.dart';
import 'package:appteste/provider/users_provider.dart';
import 'package:appteste/routes/app_routes.dart';
import 'package:appteste/views/user_form.dart';
import 'package:appteste/views/user_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import 'pages/perguntas.dart';
//import 'home/ui/home_page.dart';
//import './appbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UsersProvider>(
          create: (ctx) => UsersProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Emprestaí',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
        routes: {
          //AppRoutes.HOME: (context) => const MyHomePage(),
          AppRoutes.USER_LIST: (context) => const UserList(),
          AppRoutes.USER_FORM: (_) => const UserForm(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
