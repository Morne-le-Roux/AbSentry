// ignore_for_file: prefer_const_constructors, unnecessary_import, prefer_const_literals_to_create_immutables, must_be_immutable, unused_import, unused_local_variable, prefer_const_constructors_in_immutables

import 'package:absentry/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/rendering.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

late User loggedInUser;
String className = "";
List<String> _childrenList = [];

class NewClassScreen extends StatefulWidget {
  NewClassScreen({super.key});

  @override
  State<NewClassScreen> createState() => _NewClassScreenState();
}

class _NewClassScreenState extends State<NewClassScreen> {
  final textFieldController = TextEditingController();
  final childTextFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // getCurrentUser();
  }

  // void getCurrentUser() {
  //   try {
  //     final user = auth.currentUser!;
  //     loggedInUser = user;
  //   } catch (e) {
  //     //TODO: IMPLEMENT CATCH BLOCK
  //   }
  // }

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
                    onChanged: (value) => className = value,
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
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (var child in _childrenList)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            child,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
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
                // InitClass().addClass(className: className);
              },
              text: "Add Class")
        ],
      ),
    ));
  }
}

// class InitClass {
//   late final String? className;

//   addClass({required className}) {
//     for (var child in _childrenList) {
//       db.collection(className).add({"Name": child});
//     }

//     // db.collection(className).add(_childrenList);
//   }
// }
