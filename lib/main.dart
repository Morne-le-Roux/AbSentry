import 'package:absentry/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AbSentry());
}

class AbSentry extends StatelessWidget {
  const AbSentry({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/home",
      routes: {
        "/home": (context) => const HomeScreen(),
      },
    );
  }
}
