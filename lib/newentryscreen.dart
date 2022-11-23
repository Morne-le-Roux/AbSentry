// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously

import 'package:absentry/basicbutton.dart';
import 'package:absentry/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

final _firestore = FirebaseFirestore.instance;
List _children = [];
List<Widget> _childrenWidgets = [];
List<Map> _childData = [{}];

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
    _childData = [];
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
          _childData.add(
            {"Name": child["ChildName"], "absent": false, "note": ""},
          );
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
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: _childrenWidgets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        child: _childrenWidgets[index],
                      );
                    }),
              ),
              RoundedButton(
                  color: Colors.grey.shade300,
                  onPressed: () {
                    //TODO:PUSH DATA TO DATABASE
                  },
                  text: "Add Today's Entry")
            ],
          ),
        ),
      ),
    );
  }
}

class ChildEntryWidget extends StatefulWidget {
  final String childName;
  const ChildEntryWidget(this.childName, {super.key});

  @override
  State<ChildEntryWidget> createState() => _ChildEntryWidgetState();
}

class _ChildEntryWidgetState extends State<ChildEntryWidget> {
  bool isChecked = true;
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
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.childName),
            Row(
              children: [
                Text(
                  "Present?",
                  style: TextStyle(
                      color: Colors.black26, fontStyle: FontStyle.italic),
                ),
                Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                      for (var child in _childData) {
                        if (child["Name"] == widget.childName) {
                          child["absent"] = !value;
                        }
                      }
                    });
                  },
                  activeColor: Colors.lightBlue,
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: (() {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            NotesEntry(widget.childName));
                  }),
                  child: Icon(Icons.notes_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NotesEntry extends StatefulWidget {
  final String childName;
  const NotesEntry(this.childName, {super.key});

  @override
  State<NotesEntry> createState() => _NotesEntryState();
}

class _NotesEntryState extends State<NotesEntry> {
  String note = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Child Note"),
      content: TextField(
        maxLines: null,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          hintText: "Please keep it short and sweet ;)",
        ),
        onChanged: (value) {
          note = value;
        },
      ),
      actions: [
        BasicButton(
          icon: Icon(Icons.close_rounded),
          text: "Close",
          onpressed: () {
            Navigator.pop(context);
            note = "";
          },
        ),
        SizedBox(
          width: 150,
        ),
        BasicButton(
            icon: Icon(Icons.check_rounded),
            text: "Add Note",
            onpressed: () {
              Navigator.pop(context);
              for (var child in _childData) {
                if (child["Name"] == widget.childName) {
                  child["note"] = note;
                }
              }
            })
      ],
    );
  }
}
