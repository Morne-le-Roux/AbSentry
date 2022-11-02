// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class NewEntryScreen extends StatelessWidget {
  const NewEntryScreen({super.key});

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
      ),
    );
  }
}
