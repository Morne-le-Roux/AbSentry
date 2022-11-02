// ignore_for_file: prefer_const_constructors, unnecessary_import, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NewClassScreen extends StatelessWidget {
  const NewClassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String className;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
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
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.grey[50],
                      border: Border.all(color: Colors.white)),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    onChanged: (value) => className = value,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Class Name",
                        hintStyle: TextStyle(color: Colors.grey[400])),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
