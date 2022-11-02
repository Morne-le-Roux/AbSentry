// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  color: Colors.grey,
                  fontFamily: "SplashFont",
                  fontSize: 70.0),
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
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.grey[50],
                  border: Border.all(color: Colors.grey.shade300)),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Email Address",
                    hintStyle: TextStyle(color: Colors.grey[400])),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.grey[50],
                  border: Border.all(color: Colors.grey.shade300)),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
