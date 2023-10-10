import 'package:appteste/home/home_page.dart';
import 'package:appteste/provider/chat_users_provider.dart';
import 'package:appteste/provider/posts_provider.dart';
import 'package:appteste/provider/users_provider.dart';
import 'package:appteste/routes/app_routes.dart';
import 'package:appteste/views/chat_page.dart';
import 'package:appteste/views/chat_selection_page.dart';
import 'package:appteste/views/login_page.dart';
import 'package:appteste/views/posts_form.dart';
import 'package:appteste/views/posts_list.dart';
import 'package:appteste/views/profile_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  MyApp({super.key, required this.isLoggedIn});
  final FluroRouter router = FluroRouter();

  @override
  Widget build(BuildContext context) {
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
        home: isLoggedIn ? const MyHomePage() : const LoginPage(),
        routes: {
          AppRoutes.POSTS_LIST: (context) => const PostsList(),
          AppRoutes.PROFILE_PAGE: (_) => const MyProfilePage(),
          AppRoutes.CHAT_SELECTION: (_) => const ChatSelectionPage(),
          AppRoutes.CHAT_PAGE: (_) => const ChatPage(),
          AppRoutes.HOME: (_) => const MyHomePage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == AppRoutes.POSTS_FORM) {
            // Extrai o argumento do nome de usuário
            final nomeUsuario = settings.arguments as String?;
            return MaterialPageRoute(
              builder: (context) =>
                  PostsForm(nomeUsuario: nomeUsuario.toString()),
            );
          }
          return null;
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
