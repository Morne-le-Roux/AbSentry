// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

final _firestore = FirebaseFirestore.instance;
List _children = [];
List<Widget> _childrenWidgets = [];

class NewEntryScreen extends StatefulWidget {
  const NewEntryScreen({super.key});

  @override
  State<NewEntryScreen> createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<NewEntryScreen> {
  bool showSpinner = false;
  @override
  void initState() {
    _children = [];
    _childrenWidgets = [];
    setState(() {
      showSpinner = true;
    });

    super.initState();
    getChildren();
  }

  void createChildWidgets() {
    for (var child in _children) {
      _childrenWidgets.add(ChildWidget(child["ChildName"]));
    }
  }

  Future getChildren() async {
    CollectionReference childrenData = _firestore.collection("Children");
    QuerySnapshot querySnapshot = await childrenData.get();
    List allChildren = querySnapshot.docs.map((doc) => doc.data()).toList();

    try {
      for (var child in allChildren) {
        if (child["ClassID"] == "Class 1") {
          _children.add(child);
        }
      }
      createChildWidgets();
      setState(() {
        showSpinner = false;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: DecoratedBox(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/background.jpg",
                    ),
                    fit: BoxFit.fill)),
            child: ListView.builder(
                itemCount: _childrenWidgets.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    child: _childrenWidgets[index],
                  );
                })),
      ),
    );
  }
}

class ChildWidget extends StatelessWidget {
  final String childName;
  const ChildWidget(this.childName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        padding: EdgeInsets.all(8),
        child: Text(childName),
      ),
    );
  }
}
