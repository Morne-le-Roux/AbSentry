// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:absentry/screens/class_selection_screen.dart';
import 'package:absentry/screens/home.dart';
import 'package:absentry/screens/loginscreen.dart';
import 'package:absentry/screens/newclassscreen.dart';
import 'package:absentry/screens/registrationscreen.dart';
import 'package:absentry/screens/report_screen_selection.dart';
import 'package:absentry/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const AbSentry());
}

class AbSentry extends StatelessWidget {
  const AbSentry({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => SplashScreen(),
        "/login": (context) => LoginScreen(),
        "/registrationscreen": (context) => RegistrationScreen(),
        "/home": (context) => HomeScreen(),
        "/newClassScreen": (context) => NewClassScreen(),
        "/classSelection": (context) => ClassSelection(),
        "/reportScreen": (context) => ReportScreenSelection(),
      },
    );
  }
}
