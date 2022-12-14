// ignore_for_file: use_build_context_synchronously

import 'package:absentry/create_excel.dart';
import 'package:absentry/custom_widgets/rounded_button.dart';
import 'package:absentry/screens/report_screen.dart';
import 'package:absentry/theming/themes_and_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:lottie/lottie.dart';

class ReportScreenSelection extends StatefulWidget {
  const ReportScreenSelection({super.key});

  @override
  State<ReportScreenSelection> createState() => _ReportScreenSelectionState();
}

class _ReportScreenSelectionState extends State<ReportScreenSelection> {
//FirestoreAuth Instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//Excel instance

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

//grabs class data from DB

  Future getClasses() async {
    CollectionReference classData = _firestore.collection(
        FirebaseAuth.instance.currentUser!.uid); // Creates DB reference
    QuerySnapshot querySnapshot = await classData.get();
    _allClasses = querySnapshot.docs.map((doc) => doc.data()).toList();

    try {
      createClassWidgets();
      setState(() {
        showSpinner = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void createClassWidgets() {
    for (var entry in _allClasses) {
      _classWidgets.add(GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: kBackgroundColor,
              border: Border.all(color: kButtonColor),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Center(
                child: Text(
              entry["ClassID"],
              style: kButtonTextStyle.copyWith(color: kButtonColor),
            )),
          ),
        ),
        onTap: () {
          //opens class entry screen on tap
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ReportScreen(
                      classID: entry["ClassID"],
                    )),
          );
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: kBackgroundColor,
      progressIndicator: SizedBox(
          height: 150,
          width: 150,
          child: Lottie.asset("assets/loadingindicator.json")),
      inAsyncCall: showSpinner,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: kButtonColor),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
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
              RoundedButton(
                  color: kButtonColor,
                  onPressed: () {
                    generateExcel(className: "class 1", mapOfEntries: null);
                  },
                  text: "Download Report")
            ],
          ),
        ),
      ),
    );
  }
}
