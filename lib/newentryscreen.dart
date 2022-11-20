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
      _childrenWidgets.add(ChildEntryWidget(child["ChildName"]));
    }
  }

  Future getChildren() async {
    CollectionReference childrenData = _firestore.collection("Children");
    QuerySnapshot querySnapshot = await childrenData.get();
    List allChildren =
        querySnapshot.docs.reversed.map((doc) => doc.data()).toList();

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
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
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

class ChildEntryWidget extends StatelessWidget {
  final String childName;
  const ChildEntryWidget(this.childName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(childName),
            Row(
              children: [
                Checkbox(
                  value: true,
                  onChanged: (value) {},
                  activeColor: Colors.lightBlue,
                ),
                Icon(Icons.notes_rounded),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
