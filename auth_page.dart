import 'package:firebase/sign_up.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isShow = true;
  @override
  Widget build(BuildContext context) {
    void toggleScreen() {
      setState(() {
        isShow = !isShow;
      });
      
    }

    if (isShow) {
      return LoginPage(showRegisterPage: toggleScreen);
    } else {
      return SignUp(showLoginPage: toggleScreen);
    }
  }
}
