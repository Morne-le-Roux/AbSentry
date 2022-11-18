// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'rounded_button.dart';

late User _loggedInUser;

void getCurrentUser() {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _loggedInUser = user;
    }
  } catch (e) {
    //TODO: IMPLEMENT CATCH BLOCK
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class UserInit {
  UserInit() {
    getCurrentUser();
    FirebaseFirestore.instance
        .collection("Users")
        .add({"Email": _loggedInUser.email, "UID": _loggedInUser.uid});
  }
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  late String password1;
  late String password2;
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
              "Welcome! Glad you will be joining us.",
              style: TextStyle(
                  fontWeight: FontWeight.w100,
                  color: Colors.grey,
                  fontFamily: "SplashFont",
                  fontSize: 25),
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
                onChanged: (value) => password1 = value,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.grey[50],
                  border: Border.all(color: Colors.grey.shade400)),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                obscureText: true,
                onChanged: (value) => password2 = value,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Confirm Password",
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
                    if (password1 == password2) {
                      password = password1;

                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      if (newUser != null) {
                        UserInit();
                        Navigator.pushNamed(context, "/home");
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Passwords do not match!")));
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
                text: "Register"),
          ),
        ],
      ),
    ));
  }
}
