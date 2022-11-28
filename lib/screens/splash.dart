// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, unused_import, prefer_const_literals_to_create_immutables

import 'package:absentry/screens/home.dart';
import 'package:absentry/screens/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: DecoratedBox(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/background.jpg",
                    ),
                    fit: BoxFit.fill)),
            child: AnimatedSplashScreen(
              backgroundColor: Colors.transparent,
              splash: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "AbSentry",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.grey.shade700,
                        fontFamily: "SplashFont",
                        fontSize: 70.0),
                  )
                ],
              ),
              nextScreen: LoginScreen(),
              duration: 3000,
              splashTransition: SplashTransition.fadeTransition,
              pageTransitionType: PageTransitionType.fade,
              splashIconSize: 100,
            )));
  }
}
