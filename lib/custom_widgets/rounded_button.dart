// ignore_for_file: unnecessary_statements, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, unnecessary_this

import 'package:absentry/theming/themes_and_styles.dart';
import 'package:flutter/material.dart';

//General use round button. Repurposed it from an older project.

class RoundedButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;
  final String text;
  RoundedButton(
      {required this.color, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: this.color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: this.onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            this.text,
            style: kButtonTextStyle,
          ),
        ),
      ),
    );
  }
}
