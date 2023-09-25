import 'package:appteste/home/ui/home_page.dart';
import 'package:appteste/provider/chat_users_provider.dart';
import 'package:appteste/provider/posts_provider.dart';
import 'package:appteste/provider/users_provider.dart';
import 'package:appteste/routes/app_routes.dart';
import 'package:appteste/views/chat_page.dart';
//import 'package:appteste/views/login_page.dart';
import 'package:appteste/views/chat_selection_page.dart';
import 'package:appteste/views/login_page.dart';
import 'package:appteste/views/posts_form.dart';
import 'package:appteste/views/posts_list.dart';
import 'package:appteste/views/profile_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final FluroRouter router = FluroRouter();

  @override
  Widget build(BuildContext context) {
    bool isUserLog = false;
    StatefulWidget path;
    if (isUserLog = true) {
      path = const LoginPage();
    } else {
      path = const MyHomePage();
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UsersProvider>(
          create: (ctx) => UsersProvider(),
        ),
        ChangeNotifierProvider<PostsProvider>(
          create: (ctx) => PostsProvider(),
        ),
        ChangeNotifierProvider<ChatUsersProvider>(
          create: (ctx) => ChatUsersProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Emprestaí',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
          useMaterial3: true,
        ),
        home: MyHomePage(),
        routes: {
          AppRoutes.POSTS_LIST: (context) => const PostsList(),
          AppRoutes.POSTS_FORM: (_) => const PostsForm(),
          AppRoutes.PROFILE_PAGE: (_) => const MyProfilePage(),
          AppRoutes.CHAT_SELECTION: (_) => const ChatSelectionPage(),
          AppRoutes.CHAT_PAGE: (_) => const ChatPage(),
          AppRoutes.HOME: (_) => const MyHomePage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
