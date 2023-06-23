import 'package:flutter/material.dart';
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
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    if (!isAuthenticated) {
      // if user is not authenticated, return a circular progress indicator
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return widget.child;
  }
}
