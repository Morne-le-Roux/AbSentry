// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, unused_import, prefer_const_literals_to_create_immutables

import 'package:absentry/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("assets/splash-bubbles.json"),
          Text(
            "AbSentry",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.indigoAccent),
          )
        ],
      ),
      nextScreen: HomeScreen(),
      duration: 500,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      splashIconSize: 100,
    );
  }
}
