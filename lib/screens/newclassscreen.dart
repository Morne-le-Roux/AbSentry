// ignore_for_file: prefer_const_constructors, unnecessary_import, prefer_const_literals_to_create_immutables, must_be_immutable, unused_import, unused_local_variable, prefer_const_constructors_in_immutables

import 'package:absentry/custom_widgets/rounded_button.dart';
import 'package:absentry/theming/themes_and_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';

class NewClassScreen extends StatefulWidget {
  NewClassScreen({super.key});

  @override
  State<NewClassScreen> createState() => _NewClassScreenState();
}

class _NewClassScreenState extends State<NewClassScreen> {
  final textFieldController = TextEditingController();
  final childTextFieldController = TextEditingController();
  final auth = FirebaseAuth.instance;
  List<String> _childrenList = [];
  String _className = "";
  late User _loggedInUser;
  final _firestore = FirebaseFirestore.instance;

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
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    String newChildName = "";
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: Column(
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
                      color: kBackgroundColor,
                      border: Border.all(color: kButtonColor),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      style: kButtonTextStyle.copyWith(color: kButtonColor),
                      cursorColor: kButtonColor,
                      controller: textFieldController,
                      onChanged: (value) => _className = value,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.group,
                          color: kButtonColor,
                        ),
                        border: InputBorder.none,
                        hintText: "New Class Name",
                        hintStyle: TextStyle(color: kButtonColor.withAlpha(50)),
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
                      color: kBackgroundColor,
                      border: Border.all(color: kButtonColor),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      style: kButtonTextStyle.copyWith(color: kButtonColor),
                      onChanged: (value) => newChildName = value,
                      controller: childTextFieldController,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: kButtonColor.withAlpha(200),
                        ),
                        border: InputBorder.none,
                        hintText: "Child Name",
                        hintStyle: TextStyle(color: kButtonColor.withAlpha(50)),
                      ),
                    ),
                  ),
                  RoundedButton(
                      color: kButtonColor,
                      onPressed: () {
                        setState(() {});
                        _childrenList.add(newChildName);
                        childTextFieldController.clear();
                      },
                      text: "Add Child"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Children List",
                      style: kButtonTextStyle.copyWith(color: kButtonColor),
                    ),
                  ),
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: kBackgroundColor,
                      border: Border.all(color: kButtonColor.withAlpha(200)),
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
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  color: kButtonColor),
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                color: kButtonColor,
                onPressed: () {
                  _firestore.collection("Classes").doc(_className).set({
                    "ClassID": _className,
                    "CreatedBy": _loggedInUser.email
                  });

                  for (var child in _childrenList) {
                    _firestore.collection("Children").doc().set({
                      "ChildName": child,
                      "ClassID": _className,
                      "CreatedBy": _loggedInUser.email
                    });

                    textFieldController.clear();
                    _childrenList = [];

                    setState(() {});
                  }
                },
                text: "Add Class")
          ],
        ));
  }
}
