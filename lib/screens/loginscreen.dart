// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, use_build_context_synchronously

import 'package:absentry/theming/themes_and_styles.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../custom_widgets/rounded_button.dart';
import 'package:lottie/lottie.dart';

//LOGIN SCREEN. FIRST SCREEN TO SHOW UP WHEN USER OPENS UP APP

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance; //Firebase Instance
  bool showSpinner = false; //Spinner for loading times.
  late String email; //Email Entry for login.
  late String password; //Password entry for login.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,

        //Loading Screen
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
                  style: GoogleFonts.bebasNeue(
                      color: kButtonColor, fontSize: 20.0),
                ),
              ),
              SizedBox(
                height: 40,
              ),

              //EMAIL INPUT

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
                    cursorColor: kButtonColor,
                    onChanged: (value) => email = value,

                    //DECORATION

                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.alternate_email_rounded,
                          color: kButtonColor.withAlpha(200),
                        ),
                        iconColor: kButtonColor,
                        border: InputBorder.none,
                        hintText: "Email Address",
                        hintStyle:
                            TextStyle(color: kButtonColor.withAlpha(50))),
                  ),
                ),
              ),

              //PASSWORD INPUT

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
                    cursorColor: kButtonColor,
                    obscureText: true,
                    onChanged: (value) => password = value,

                    //DECORATION

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

              //LOGIN BUTTON
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: RoundedButton(
                    color: kButtonColor,
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (user != null) {
                          setState(() {
                            showSpinner = false;
                          });
                          Navigator.pushNamed(context, "/home");
                        }
                      } catch (e) {
                        setState(() {
                          showSpinner = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                      }
                    },
                    text: "Login"),
              ),

              //REGISTER BUTTON
              Center(
                  child: GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, "/registrationscreen"),
                child: Text(
                  "Not a member? Join here.",
                  style: kButtonTextStyle.copyWith(color: kButtonColor),
                ),
              ))
            ],
          ),
        ));
  }
}
