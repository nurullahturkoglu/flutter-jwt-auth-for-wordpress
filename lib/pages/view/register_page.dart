import 'package:flutter/material.dart';
import 'package:flutter_jwt_auth/constants/fonts.dart';

import '../../services/wordpress_auth_methods.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> handleRegister() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      bool isLoginSuccessful = await WordPressAuthMethods().registerToWordPress(
          context, _usernameController.text, _passwordController.text);

      setState(() {
        isLoading = false;
      });

      if (isLoginSuccessful && mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/login', (Route<dynamic> route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade600,
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: isLoading
              ? const CircularProgressIndicator()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 25),

                    // logo
                    Image.asset(
                      'assets/images/logo.png',
                      width: 75,
                    ),
                    const SizedBox(height: 15),

                    // create an account text
                    Text(
                      'Create an Account',
                      style: AppFonts.large(),
                    ),
                    const SizedBox(height: 10),

                    // register container
                    Container(
                      padding: const EdgeInsets.all(25),
                      width: MediaQuery.of(context).size.width * 0.80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: RegisterForm(
                        formKey: _formKey,
                        usernameController: _usernameController,
                        passwordController: _passwordController,
                        onRegisterPressed: handleRegister,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // don't have an account link
                    const LoginLink(),
                  ],
                ),
        ),
      ),
    );
  }
}

class LoginLink extends StatelessWidget {
  const LoginLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 40, right: 40),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Already have an account?',
            style: AppFonts.medium(color: Colors.black),
          ),
          TextButton(
            onPressed: () {
              // Route to login page
              Navigator.of(context).pop();
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.passwordController,
    required this.onRegisterPressed,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final Future<void> Function() onRegisterPressed;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Username', style: AppFonts.medium(color: Colors.black87)),
          const SizedBox(height: 10),

          // username field
          TextFormField(
            controller: usernameController,
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
            ),
            style: AppFonts.small(color: Colors.black87),
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 10),

          Text('Password', style: AppFonts.medium(color: Colors.black87)),
          const SizedBox(height: 10),

          // password field
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
            ),
            style: AppFonts.small(color: Colors.black54),
          ),
          const SizedBox(height: 15),

          // register button
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            onPressed: onRegisterPressed,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create Account',
                  style: AppFonts.medium(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
