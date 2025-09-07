import 'package:flutter/material.dart';
import 'package:my_app/src/provider/user_provider.dart';
import 'package:my_app/src/view/create_cake_view.dart';
import 'package:my_app/src/view/home_view.dart';
import 'package:my_app/src/view/cake_list_view.dart';
import 'package:my_app/src/view/register_view.dart';
import 'package:provider/provider.dart';
import 'package:my_app/theme/theme_provider.dart';
import 'package:my_app/src/view/login_view.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return MaterialApp(
      title: 'Sweet Dreams Bakery',
      theme: themeProvider.themeData,
      routes: {
        '/home': (context) => const HomePage(),
        '/create_cake': (context) => CreateCakePage(),
        '/cake_list': (context) => CakeListPage(),
        '/login': (context) => LoginView(),
        '/register': (context) => const RegisterView(),
      },

      home: userProvider.isLoggedIn ? const HomePage() : LoginView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
