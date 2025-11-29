import 'package:flutter/material.dart';
import 'package:flutter_jwt_auth/constants/app_routes.dart';
import 'package:flutter_jwt_auth/constants/app_strings.dart';
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
      title: AppStrings.appTitle,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      routes: {
        AppRoutes.login: (context) => const LoginPage(),
        AppRoutes.register: (context) => const RegisterPage(),
        AppRoutes.home: (context) => const AuthMiddleware(child: HomePage()),
        AppRoutes.book: (context) => const AuthMiddleware(child: BookPage()),
        AppRoutes.profile: (context) =>
            const AuthMiddleware(child: ProfilePage()),
      },
      home: const AuthMiddleware(child: HomePage()),
    );
  }
}
