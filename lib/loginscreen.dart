// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'rounded_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DecoratedBox(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/background.jpg",
              ),
              fit: BoxFit.fill)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              "AbSentry",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey.shade700,
                  fontFamily: "SplashFont",
                  fontSize: 80.0),
            ),
          ),
          Center(
            child: Text(
              "Welcome back! We missed you.",
              style: TextStyle(
                  fontWeight: FontWeight.w100,
                  color: Colors.grey,
                  fontFamily: "SplashFont",
                  fontSize: 30),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.grey[50],
                  border: Border.all(color: Colors.grey.shade400)),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onChanged: (value) => email = value,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Email Address",
                    hintStyle: TextStyle(color: Colors.grey.shade400)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.grey[50],
                  border: Border.all(color: Colors.grey.shade400)),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                obscureText: true,
                onChanged: (value) => password = value,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RoundedButton(
                color: Colors.grey.shade300,
                onPressed: () async {
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, "/home");
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                text: "Login"),
          ),
          Center(
              child: Text(
            "Not a member? Join here.",
            style: TextStyle(color: Colors.grey.shade700),
          ))
        ],
      ),
    ));
  }
}
