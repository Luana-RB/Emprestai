import 'package:appteste/home/ui/home_page.dart';
import 'package:appteste/provider/posts_provider.dart';
import 'package:appteste/provider/users_provider.dart';
import 'package:appteste/routes/app_routes.dart';
import 'package:appteste/views/posts_form.dart';
import 'package:appteste/views/posts_list.dart';
//import 'package:appteste/views/user_form.dart';
//import 'package:appteste/views/user_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        ),
        ChangeNotifierProvider<PostsProvider>(
          create: (ctx) => PostsProvider(),
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
          AppRoutes.POSTS_LIST: (context) => const PostsList(),
          AppRoutes.POSTS_FORM: (_) => const PostsForm(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
