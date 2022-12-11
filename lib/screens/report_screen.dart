// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  final String classID = "";
  const ReportScreen({super.key, required classID});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
//FirestoreAuth Instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
