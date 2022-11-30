// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, use_build_context_synchronously

import 'package:absentry/theming/themes_and_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../custom_widgets/rounded_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:lottie/lottie.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showSpinner = false;
  late User _loggedInUser;
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  late String password1;
  late String password2;

  void getCurrentUser() {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        _loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void userInit() {
    getCurrentUser();
    FirebaseFirestore.instance
        .collection("Users")
        .add({"Email": _loggedInUser.email, "UID": _loggedInUser.uid});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        color: kBackgroundColor,
        progressIndicator: SizedBox(
            height: 150,
            width: 150,
            child: Lottie.asset("assets/loadingindicator.json")),
        child: DecoratedBox(
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
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
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
                    color: kButtonColor,
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        if (password1 == password2) {
                          password = password1;

                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          if (newUser != null) {
                            userInit();
                            setState(() {
                              showSpinner = false;
                            });
                            Navigator.pushNamed(context, "/home");
                          }
                        } else {
                          setState(() {
                            showSpinner = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Passwords do not match!")));
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                      }
                    },
                    text: "Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
