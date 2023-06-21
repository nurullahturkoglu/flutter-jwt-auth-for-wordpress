import 'package:flutter/material.dart';
import 'package:flutter_jwt_auth/constants/fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade600,
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
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
              const RegisterContainer(),
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

class RegisterContainer extends StatelessWidget {
  const RegisterContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      width: MediaQuery.of(context).size.width * 0.80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const RegisterForm(),
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
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Username', style: AppFonts.medium(color: Colors.black87)),
          const SizedBox(height: 10),

          // username field
          TextFormField(
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
              backgroundColor: MaterialStateProperty.all(Colors.green),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            onPressed: () {
              // Kayıt olma işlemleri burada gerçekleştirilebilir
            },
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
