// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:absentry/theming/themes_and_styles.dart';
import 'package:flutter/material.dart';

//Small little button with an icon and some text at the bottom.

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
              foregroundColor: kBackgroundColor,
              backgroundColor: kButtonColor,
              shape: StadiumBorder()),
          child: icon,
        ),
        Text(
          text,
          style: kButtonTextStyle.copyWith(color: kButtonColor),
        )
      ],
    );
  }
}
