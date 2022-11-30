// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:absentry/theming/themes_and_styles.dart';
import 'package:flutter/material.dart';
import '../custom_widgets/basicbutton.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          SizedBox(height: 30),
          Center(
            child: Hero(
              tag: "splashToLogin",
              child: Text(
                "AbSentry",
                style:
                    GoogleFonts.bebasNeue(color: kButtonColor, fontSize: 90.0),
              ),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BasicButton(
                  icon: Icon(Icons.group_add),
                  text: "New Class",
                  onpressed: () {
                    Navigator.pushNamed(context, "/newClassScreen");
                  },
                ),
                BasicButton(
                  icon: Icon(Icons.list_alt),
                  text: "New Entry",
                  onpressed: () {
                    Navigator.pushNamed(context, "/classSelection");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
