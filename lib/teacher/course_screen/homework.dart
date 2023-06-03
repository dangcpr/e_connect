import 'package:e_connect/models/course.dart';
import 'package:flutter/material.dart';

class HomeworkScreen extends StatefulWidget {
  //const HomeworkScreen({super.key});
  final Course course;
  const HomeworkScreen({Key? key, required this.course}) : super(key: key);
  @override
  State<HomeworkScreen> createState() => _HomeworkScreenState();
}

class _HomeworkScreenState extends State<HomeworkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Màn hình bài tập'))
    );
  }
}