// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, use_build_context_synchronously

import 'package:absentry/theming/themes_and_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../custom_widgets/rounded_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: kBackgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        color: kBackgroundColor,
        progressIndicator: SizedBox(
            height: 150,
            width: 150,
            child: Lottie.asset("assets/loadingindicator.json")),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //MAIN HEADING

            Center(
              child: Hero(
                tag: "splashToLogin",
                child: Text(
                  "AbSentry",
                  style: GoogleFonts.bebasNeue(
                      color: kButtonColor, fontSize: 90.0),
                ),
              ),
            ),

            //SUB HEADING

            Center(
              child: Text(
                "Welcome back! We missed you.",
                style:
                    GoogleFonts.bebasNeue(color: kButtonColor, fontSize: 20.0),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: kBackgroundColor,
                    border: Border.all(color: kButtonColor)),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  style: kButtonTextStyle.copyWith(color: kButtonColor),
                  onChanged: (value) => email = value,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.alternate_email_rounded,
                        color: kButtonColor.withAlpha(200),
                      ),
                      iconColor: kButtonColor,
                      border: InputBorder.none,
                      hintText: "Email Address",
                      hintStyle: TextStyle(color: kButtonColor.withAlpha(50))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: kBackgroundColor,
                    border: Border.all(color: kButtonColor)),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  style: kButtonTextStyle.copyWith(color: kButtonColor),
                  obscureText: true,
                  onChanged: (value) => password1 = value,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.password,
                      color: kButtonColor.withAlpha(200),
                    ),
                    border: InputBorder.none,
                    hintText: "Password",
                    hintStyle: TextStyle(color: kButtonColor.withAlpha(50)),
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
                    color: kBackgroundColor,
                    border: Border.all(color: kButtonColor)),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  style: kButtonTextStyle.copyWith(color: kButtonColor),
                  obscureText: true,
                  onChanged: (value) => password2 = value,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.password,
                      color: kButtonColor.withAlpha(200),
                    ),
                    border: InputBorder.none,
                    hintText: "Confirm Password",
                    hintStyle: TextStyle(color: kButtonColor.withAlpha(50)),
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
      ),
    );
  }
}
