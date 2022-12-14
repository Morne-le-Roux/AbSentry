// ignore_for_file: use_build_context_synchronously

import 'package:absentry/theming/themes_and_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:absentry/custom_widgets/class_widget.dart';
import 'package:lottie/lottie.dart';

// class selection screen. Will display a list of widgets of the logged in users's classes.
//On Tap on one of the widgets will open up the new entry screen for the day's entry.

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
    CollectionReference classData = _firestore.collection(
        FirebaseAuth.instance.currentUser!.uid); //Creates Database Reference
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
        color: kBackgroundColor,
        progressIndicator: SizedBox(
            height: 150,
            width: 150,
            child: Lottie.asset("assets/loadingindicator.json")),
        //spinner
        inAsyncCall: showSpinner,

        //! DO NOT REMOVE DECORATED BOX
        //! CODE DOES NOT WORK WITHOUT IT
        //! I DON'T KNOW WHY

        child: DecoratedBox(
          decoration: BoxDecoration(color: kBackgroundColor),
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
