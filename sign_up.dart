import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'auth_page.dart';

import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final void Function() showLoginPage;
  const SignUp({super.key, required this.showLoginPage});

  @override
  State<SignUp> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  FocusNode myFocusNode = FocusNode();
  FocusNode hisFocusNode = FocusNode();
  FocusNode confirmPass = FocusNode();
  bool isFocus = false;
  bool isForPass = false;
  bool isForCon = false;
  @override
  @override
void initState() {
  super.initState();

  myFocusNode.addListener(() {
    setState(() {
      isFocus = myFocusNode.hasFocus;
    });
  });

  hisFocusNode.addListener(() {
    setState(() {
      isForPass = hisFocusNode.hasFocus;
    });
  });

  confirmPass.addListener(() {
    setState(() {
      isForCon = confirmPass.hasFocus;
    });
  });
}


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    myFocusNode.dispose();
    hisFocusNode.dispose();
    confirmPass.dispose();
    super.dispose();
  }

  void signUp() async {
    try {
      if (_confirmController.text != _passwordController.text) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("The sign Up failed")));
        return;
      }
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Sign in Sucessfully")));
      await FirebaseAuth.instance.signOut();
      widget.showLoginPage;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "Password doesn't match")));
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
              Icon(Icons.waving_hand, color: Colors.grey[200], size: 50),
              const SizedBox(height: 10),
              Text(
                "Create new account",
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
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 20,
                  vertical: 3,
                ),
                child: TextField(
                  obscureText: true,
                  controller: _confirmController,
                  focusNode: confirmPass,
                  style: TextStyle(
                    color: isForCon ? Colors.white : Colors.grey,
                    fontSize: 16,
                  ),
                  cursorColor: Colors.white60,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsetsGeometry.only(bottom: 10),
                      child: Icon(
                        Icons.email,
                        size: 25,
                        color: isForCon ? Colors.white : Colors.grey,
                      ),
                    ),
                    hintText: "Confirm Password",
                    hintStyle: TextStyle(
                      color: isForCon ? Colors.white : Colors.grey,
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
              GestureDetector(
                onTap: signUp,
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
                        "Sign Up",
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
                    "Already have an account?",
                    style: TextStyle(color: Colors.grey[300], fontSize: 15),
                  ),
                  const SizedBox(width: 40),
                  GestureDetector(
                    onTap: widget.showLoginPage,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey)),
                      ),
                      child: Text(
                        "Log In",
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
