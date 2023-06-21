import 'package:flutter/material.dart';
import 'package:flutter_jwt_auth/pages/view/login_page.dart';

import '../services/manage_secure_storage.dart';
import '../services/wordpress_auth_methods.dart';

class AuthMiddleware extends StatefulWidget {
  final Widget child;

  const AuthMiddleware({super.key, required this.child});

  @override
  AuthMiddlewareState createState() => AuthMiddlewareState();
}

class AuthMiddlewareState extends State<AuthMiddleware> {
  bool isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    validateToken();
  }

  Future<void> validateToken() async {
    String? token = await SecureStorage.getToken();

    if (token == null) {
      navigateToLoginPage();
      return;
    }

    bool isValid = await WordPressAuthMethods().validateUserToken();

    if (!isValid) {
      navigateToLoginPage();
      return;
    }

    setState(() {
      isAuthenticated = isValid;
    });
  }

  void navigateToLoginPage() {
    // Navigate to login page
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!isAuthenticated) {
      // if user is not authenticated, return empty container
      return Container();
    }

    return widget.child;
  }
}
