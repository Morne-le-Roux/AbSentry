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
