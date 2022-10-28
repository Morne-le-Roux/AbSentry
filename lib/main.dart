// ignore_for_file: prefer_const_constructors

import 'package:absentry/home.dart';
import 'package:absentry/newclassscreen.dart';
import 'package:absentry/newentryscreen.dart';
import 'package:absentry/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AbSentry());
}

class AbSentry extends StatelessWidget {
  const AbSentry({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => SplashScreen(),
        "/home": (context) => HomeScreen(),
        "/newClassScreen": (context) => NewClassScreen(),
        "/newEntryScreen": (context) => NewEntryScreen(),
      },
    );
  }
}
