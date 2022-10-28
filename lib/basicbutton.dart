// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class BasicButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final VoidCallback onpressed;

  BasicButton(
      {required this.icon, required this.text, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onpressed,
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.indigo,
              shape: StadiumBorder()),
          child: icon,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w900,
          ),
        )
      ],
    );
  }
}
