// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../custom_widgets/basicbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firebase = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;
late User loggedInUser;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void getCurrentUser() {
    try {
      final user = auth.currentUser!;

      loggedInUser = user;
    } catch (e) {
      //TODO: IMPLEMENT CATCH BLOCK
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
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
