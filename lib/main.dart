// ignore_for_file: prefer_const_constructors

import 'package:absentry/home.dart';
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
      theme: ThemeData.dark().copyWith(
          colorScheme: ThemeData.dark().colorScheme.copyWith(
              primary: Color(0xFF0A0E21), secondary: Colors.redAccent.shade400),
          scaffoldBackgroundColor: Color(0xFF0A0E21),
          appBarTheme: ThemeData.dark()
              .appBarTheme
              .copyWith(backgroundColor: Color(0xFF0A0E21))),
      initialRoute: "/home",
      routes: {
        "/home": (context) => HomeScreen(),
      },
    );
  }
}
