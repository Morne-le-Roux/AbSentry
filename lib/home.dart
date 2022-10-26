// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'basicbutton.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("AbSentry"),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              BasicButton(),
            ],
          ),
        ],
      ),
    );
  }
}
