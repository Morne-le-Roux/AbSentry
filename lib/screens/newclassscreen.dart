// ignore_for_file: prefer_const_constructors, unnecessary_import, prefer_const_literals_to_create_immutables, must_be_immutable, unused_import, unused_local_variable, prefer_const_constructors_in_immutables

import 'package:absentry/custom_widgets/rounded_button.dart';
import 'package:absentry/theming/themes_and_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';

//SCREEN THAT ALLOWS USER TO CREATE A NEW CLASS AND SAVES IT TO THE DATABASE
class NewClassScreen extends StatefulWidget {
  NewClassScreen({super.key});

  @override
  State<NewClassScreen> createState() => _NewClassScreenState();
}

class _NewClassScreenState extends State<NewClassScreen> {
  //TextEditingController for the Class Name TextField
  final textFieldController = TextEditingController();
  //TextEditingController for the Child Name TextField
  final childTextFieldController = TextEditingController();
  //Firebase Auth Instance
  final auth = FirebaseAuth.instance;
  //List of Children that added to the class before the data is pushed to the DB
  List<String> _childrenList = [];
  //ClassName for the new Class before the data is pushed to the DB
  String _className = "";
  //Current LoggedInUser
  late User _loggedInUser;
  //DB
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();

    getCurrentUser(); //This grabs the currently logged in user's details.
  }

  void getCurrentUser() {
    //This grabs the currently logged in user's details.
    try {
      final user = auth.currentUser!;
      _loggedInUser = user;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    String newChildName =
        ""; //Sets the child's name before being added to the list.
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: Column(
          children: [
            SizedBox(
              height: 40,
            ),

            //ClassName TextField

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

                  //ChildName TextField

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

                  //Button that adds new child's name to the list

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

                  //CONTAINER THAT LISTS ALL OF THE NEW KIDS NAMES

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

                                  //THIS REMOVES THE NAME OUT OF THE LIST

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

            //ON TAP PUSHES ABOVE DATA TO THE DB
            RoundedButton(
                color: kButtonColor,
                onPressed: () {
                  _firestore
                      .collection(_loggedInUser.uid)
                      .doc(_className)
                      .set({"ClassID": _className});

                  for (var child in _childrenList) {
                    _firestore
                        .collection(_loggedInUser.uid)
                        .doc(_className)
                        .collection("Children")
                        .doc(child)
                        .set({
                      "ChildName": child,
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
