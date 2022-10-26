// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BasicButton extends StatelessWidget {
  const BasicButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: null,
      child: Icon(Icons.group_add_rounded),
    );
  }
}
