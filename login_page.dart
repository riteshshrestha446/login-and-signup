import 'package:firebase_auth/firebase_auth.dart';
import 'auth_page.dart';
import 'sign_up.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  final void Function() showRegisterPage;
  const LoginPage({super.key,required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  FocusNode myFocusNode = FocusNode();
  FocusNode hisFocusNode = FocusNode();
  bool isFocus = false;
  bool isForPass = false;
  @override
  void initState() {
    myFocusNode.addListener(() {
      setState(() {
        isFocus = myFocusNode.hasFocus;
      });
      setState(() {
        isForPass = hisFocusNode.hasFocus;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

 void logIn() async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.message ?? "Login failed")),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.security, color: Colors.grey[200], size: 50),
              const SizedBox(height: 10),
              Text(
                "Welcome Back!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 13),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 20,
                  vertical: 3,
                ),
                child: TextField(
                  controller: _emailController,
                  focusNode: myFocusNode,
                  style: TextStyle(
                    color: isFocus ? Colors.white : Colors.grey,
                    fontSize: 16,
                  ),
                  cursorColor: Colors.white60,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsetsGeometry.only(bottom: 10),
                      child: Icon(
                        Icons.email,
                        size: 25,
                        color: isFocus ? Colors.white : Colors.grey,
                      ),
                    ),
                    hintText: "Email",
                    hintStyle: TextStyle(
                      color: isFocus ? Colors.white : Colors.grey,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70, width: 2),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 13),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 20,
                  vertical: 3,
                ),
                child: TextField(
                  obscureText: true,
                  controller: _passwordController,
                  focusNode: hisFocusNode,
                  style: TextStyle(
                    color: isForPass ? Colors.white : Colors.grey,
                    fontSize: 16,
                  ),
                  cursorColor: Colors.white60,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsetsGeometry.only(bottom: 10),
                      child: Icon(
                        Icons.email,
                        size: 25,
                        color: isForPass ? Colors.white : Colors.grey,
                      ),
                    ),
                    hintText: "Password",
                    hintStyle: TextStyle(
                      color: isForPass ? Colors.white : Colors.grey,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70, width: 2),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: logIn,
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(21),
                    ),
                    child: Center(
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.grey[300], fontSize: 15),
                  ),
                  const SizedBox(width: 40),
                  GestureDetector(
                    onTap: widget.showRegisterPage,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey)),
                      ),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
