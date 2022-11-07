// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';

final firestore = FirebaseFirestore.instance;
List _children = [];
List<Widget> _childrenWidgets = [];
Map _childEntry = {};

class NewEntryScreen extends StatefulWidget {
  const NewEntryScreen({super.key});

  @override
  State<NewEntryScreen> createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<NewEntryScreen> {
  @override
  void initState() {
    super.initState();
    getDocs();
    for (var child in _children) {
      _childrenWidgets.add(ChildWidget(child));
    }
    print(_childrenWidgets);
    print(_children);
  }

  Future getDocs() async {
    CollectionReference userData =
        firestore.collection("${loggedInUser.email}");
    QuerySnapshot querySnapshot = await userData.get();
    _children = querySnapshot.docs.map((doc) => doc.data()).toList();
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
        child: Container(),
      ),
    );
  }
}

class ChildWidget extends StatelessWidget {
  final String childName;
  ChildWidget(this.childName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Text(childName),
    );
  }
}
