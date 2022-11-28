// ignore_for_file: prefer_const_constructors, unnecessary_import, prefer_const_literals_to_create_immutables, must_be_immutable, unused_import, unused_local_variable, prefer_const_constructors_in_immutables

import 'package:absentry/custom_widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';

final _firestore = FirebaseFirestore.instance;
late User _loggedInUser;
String _className = "";
List<String> _childrenList = [];

class NewClassScreen extends StatefulWidget {
  NewClassScreen({super.key});

  @override
  State<NewClassScreen> createState() => _NewClassScreenState();
}

class _NewClassScreenState extends State<NewClassScreen> {
  final textFieldController = TextEditingController();
  final childTextFieldController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = auth.currentUser!;
      _loggedInUser = user;
    } catch (e) {
      //TODO: IMPLEMENT CATCH BLOCK
    }
  }

  @override
  Widget build(BuildContext context) {
    String newChildName = "";
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
                    onChanged: (value) => _className = value,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "New Class Name",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
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
                    onChanged: (value) => newChildName = value,
                    controller: childTextFieldController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Child Name",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                ),
                RoundedButton(
                    color: Colors.grey.shade200,
                    onPressed: () {
                      setState(() {});
                      _childrenList.add(newChildName);
                      childTextFieldController.clear();
                    },
                    text: "Add Child"),
                Text("Children"),
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.grey[50],
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  alignment: Alignment.topLeft,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (var child in _childrenList)
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                border: Border.all(color: Colors.grey.shade300),
                                color: Colors.grey.shade100),
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.person),
                                Text(
                                  child,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (() {
                                    setState(() {
                                      _childrenList.remove(child);
                                    });
                                  }),
                                  child: Icon(Icons.close),
                                )
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
          RoundedButton(
              color: Colors.grey.shade200,
              onPressed: () {
                _firestore.collection("Classes").doc(_className).set(
                    {"ClassID": _className, "CreatedBy": _loggedInUser.email});

                for (var child in _childrenList) {
                  _firestore
                      .collection("Children")
                      .doc("$_className-$child")
                      .set({"ChildName": child, "ClassID": _className});

                  textFieldController.clear();
                  _childrenList = [];

                  setState(() {});
                }
              },
              text: "Add Class")
        ],
      ),
    ));
  }
}
