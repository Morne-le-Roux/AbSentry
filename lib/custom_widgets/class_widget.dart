import 'package:absentry/theming/themes_and_styles.dart';
import 'package:flutter/material.dart';
import '../screens/newentryscreen.dart';

class ClassWidget extends StatefulWidget {
  final String classID; //name of class
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
            color: kBackgroundColor,
            border: Border.all(color: kButtonColor),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Center(
              child: Text(
            widget.classID,
            style: kButtonTextStyle.copyWith(color: kButtonColor),
          )),
        ),
      ),
      onTap: () {
        //opens class entry screen on tap
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewEntryScreen(
              classID: widget.classID,
            ),
          ),
        );
      },
    );
  }
}
