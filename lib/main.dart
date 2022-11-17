// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:absentry/home.dart';
import 'package:absentry/loginscreen.dart';
import 'package:absentry/newclassscreen.dart';
import 'package:absentry/newentryscreen.dart';
import 'package:absentry/registrationscreen.dart';
import 'package:absentry/splash.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
      url: 'https://guzpebjezmnkdrnjmolj.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd1enBlYmplem1ua2Rybmptb2xqIiwicm9sZSI6ImFub24iLCJpYXQiOjE2Njg3MDk1NzQsImV4cCI6MTk4NDI4NTU3NH0.ZbOZZnDh5_MPpJ2Y3_uL4pjebtsL6uCngL2bsLIe_JM');

  runApp(AbSentry());
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
        "/newEntryScreen": (context) => NewEntryScreen(),
      },
    );
  }
}
