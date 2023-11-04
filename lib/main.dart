import 'package:appteste/views/home_page.dart';
import 'package:appteste/provider/posts_provider.dart';
import 'package:appteste/provider/users_provider.dart';
import 'package:appteste/routes/app_routes.dart';
import 'package:appteste/views/chat_page.dart';
import 'package:appteste/views/chat_selection_page.dart';
import 'package:appteste/views/login_page.dart';
import 'package:appteste/views/options_page.dart';
import 'package:appteste/views/posts_form.dart';
import 'package:appteste/views/profile_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp]) // Defines as vertical
      .then((_) {
    runApp(MyApp(isLoggedIn: isLoggedIn));
  });
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
      ],
      child: MaterialApp(
        title: 'Emprestaí',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.pinkAccent,
              primary: Colors.pinkAccent,
              secondary: Colors.black,
              tertiary: Colors.white,
              onTertiary: const Color.fromARGB(255, 255, 174, 189),
              background: const Color.fromARGB(255, 255, 224, 235),
              shadow: Colors.black54),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.pinkAccent,
              inversePrimary: const Color.fromARGB(255, 55, 55, 55),
              primary: Colors.pinkAccent,
              secondary: Colors.white,
              tertiary: const Color.fromARGB(255, 55, 55, 55),
              onTertiary: const Color.fromARGB(255, 55, 55, 55),
              background: const Color.fromARGB(255, 34, 34, 34),
              shadow: Colors.black54),
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        home: isLoggedIn ? const MyHomePage() : const LoginPage(),
        routes: {
          AppRoutes.PROFILE_PAGE: (_) => const MyProfilePage(),
          AppRoutes.CHAT_SELECTION: (_) => const ChatSelectionPage(),
          AppRoutes.CHAT_PAGE: (_) => const ChatPage(),
          AppRoutes.HOME: (_) => const MyHomePage(),
          AppRoutes.OPTIONS: (_) => const OptionsPage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == AppRoutes.POSTS_FORM) {
            final idUsuario = settings.arguments as String?;
            return MaterialPageRoute(
              builder: (context) => PostsForm(
                idUsuario: idUsuario.toString(),
                fromHomePage: true,
              ),
            );
          }
          return null;
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
