import 'package:flutter/material.dart';
import 'package:flutter_jwt_auth/pages/view/books_page.dart';
import 'package:flutter_jwt_auth/pages/view/login_page.dart';
import 'package:flutter_jwt_auth/pages/view/profile_page.dart';
import 'package:flutter_jwt_auth/pages/view/register_page.dart';
import 'package:flutter_jwt_auth/pages/view/home_page.dart';
import 'package:flutter_jwt_auth/widgets/auth_middleware.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JWT Auth Tutorial',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const AuthMiddleware(child: HomePage()),
        '/book': (context) => const AuthMiddleware(child: BookPage()),
        '/profile': (context) => const AuthMiddleware(child: ProfilePage()),
      },
      home: const AuthMiddleware(child: HomePage()),
    );
  }
}
