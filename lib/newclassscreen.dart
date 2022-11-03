// ignore_for_file: prefer_const_constructors, unnecessary_import, prefer_const_literals_to_create_immutables, must_be_immutable, unused_import, unused_local_variable, prefer_const_constructors_in_immutables

import 'package:absentry/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = FirebaseFirestore.instance;
late User loggedInUser;

class NewClassScreen extends StatefulWidget {
  NewClassScreen({super.key});

  @override
  State<NewClassScreen> createState() => _NewClassScreenState();
}

class _NewClassScreenState extends State<NewClassScreen> {
  final textFieldController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = auth.currentUser!;
      //TODO: THIS IS UPDATED IN A NEW VERSION OF FLUTTER. LEARN WTF IS GOING ON HERE.
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      //TODO: IMPLEMENT CATCH BLOCK
    }
  }

  @override
  Widget build(BuildContext context) {
    String className = "";
    return Scaffold(
        body: DecoratedBox(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/background.jpg",
              ),
              fit: BoxFit.fill)),
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: Colors.grey[50],
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: textFieldController,
                    onChanged: (value) => className = value,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "New Class Name",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                ),
                RoundedButton(
                    color: Colors.grey.shade200,
                    onPressed: () {
                      textFieldController.clear();
                      if (className == "") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Blank Class Names Not Allowed!")));
                      } else {
                        firestore
                            .collection("$loggedInUser")
                            .add({"class name": className});
                      }
                      firestore
                          .collection("$loggedInUser")
                          .add({"class name": className});
                    },
                    text: "Add Class"),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.grey[50],
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Text("This is a test"),
                      Text("This is a test"),
                      Text("This is a test"),
                      Text("This is a test"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
