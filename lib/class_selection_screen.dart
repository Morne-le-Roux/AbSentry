// ignore_for_file: use_build_context_synchronously

import 'package:absentry/newentryscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

final _firestore = FirebaseFirestore.instance;

List _allClasses = [];
List<Widget> _classWidgets = [];

class ClassSelection extends StatefulWidget {
  const ClassSelection({super.key});

  @override
  State<ClassSelection> createState() => _ClassSelectionState();
}

class _ClassSelectionState extends State<ClassSelection> {
  bool showSpinner = false;
  @override
  void initState() {
    _allClasses = [];
    _classWidgets = [];
    setState(() {
      showSpinner = true;
    });

    getChildren();
    super.initState();
  }

  Future getChildren() async {
    CollectionReference classData = _firestore.collection("Classes");
    QuerySnapshot querySnapshot = await classData.get();
    _allClasses = querySnapshot.docs.map((doc) => doc.data()).toList();
    try {
      createClassWidgets();
      setState(() {
        showSpinner = false;
      });
    } on Exception catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void createClassWidgets() {
    for (var entry in _allClasses) {
      _classWidgets.add(ClassWidget(classID: entry["ClassID"]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: DecoratedBox(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/background.jpg",
                  ),
                  fit: BoxFit.fill)),
          child: Expanded(
            child: ListView.builder(
                itemCount: _classWidgets.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    child: _classWidgets[index],
                  );
                }),
          ),
        ),
      ),
    );
  }
}

class ClassWidget extends StatefulWidget {
  final String classID;
  const ClassWidget({super.key, required this.classID});

  @override
  State<ClassWidget> createState() => _ClassWidgetState();
}

class _ClassWidgetState extends State<ClassWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Center(child: Text(widget.classID)),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewEntryScreen(
                      classID: widget.classID,
                    )));
      },
    );
  }
}
