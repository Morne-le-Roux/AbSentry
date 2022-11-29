// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:absentry/custom_widgets/class_widget.dart';

final _firestore = FirebaseFirestore.instance;

class ClassSelection extends StatefulWidget {
  const ClassSelection({super.key});

  @override
  State<ClassSelection> createState() => _ClassSelectionState();
}

class _ClassSelectionState extends State<ClassSelection> {
  List _allClasses = []; //List for snapshots from database
  List<Widget> _classWidgets = []; //All widgets for every class
  bool showSpinner = false;

  @override
  void initState() {
    //clear lists on page init
    _allClasses = [];
    _classWidgets = [];

    //show spinner
    setState(() {
      showSpinner = true;
    });

    //gets all classes for logged in user.
    //creates widgets for them and display them.
    //Clears the spinner on success.
    getClasses();
    super.initState();
  }

  //grabs class data from database
  Future getClasses() async {
    CollectionReference classData =
        _firestore.collection("Classes"); //Creates Database Reference
    QuerySnapshot querySnapshot = await classData.get();
    _allClasses = querySnapshot.docs
        .map((doc) => doc.data())
        .toList(); //Adds all snapshots of all te docs into _allClasses
    try {
      createClassWidgets(); //Creates ClassWidgets for viewing
      setState(() {
        showSpinner = false; //clears spinner
      });
    } on Exception catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void createClassWidgets() {
    //This creates a widget for the class for viewing
    for (var entry in _allClasses) {
      _classWidgets.add(ClassWidget(classID: entry["ClassID"]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        //spinner
        inAsyncCall: showSpinner,
        child: DecoratedBox(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/background.jpg",
                  ),
                  fit: BoxFit.fill)),
          child: Expanded(
            //main list of classes
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
