// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../custom_widgets/basicbutton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
      ),
    );
  }
}
