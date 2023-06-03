import 'dart:convert';

import 'package:e_connect/models/course.dart';
import 'package:flutter/material.dart';

class InfomationScreen extends StatefulWidget {
  //const InfomationScreen({super.key});
  final Course course;
  const InfomationScreen({Key? key, required this.course}) : super(key: key);
  @override
  State<InfomationScreen> createState() => _InfomationScreenState();
}

class _InfomationScreenState extends State<InfomationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('${jsonDecode(jsonEncode(widget.course))}'))
    );
  }
}