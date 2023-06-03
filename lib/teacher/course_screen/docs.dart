import 'package:e_connect/models/course.dart';
import 'package:flutter/material.dart';

class DocumentScreen extends StatefulWidget {
  final Course course;
  const DocumentScreen({Key? key, required this.course}) : super(key: key);
  //const DocumentScreen({super.key});
  

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Màn hình tài liệu')),
    );
  }
}