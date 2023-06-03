import 'package:e_connect/models/course.dart';
import 'package:flutter/material.dart';

class ListStudentScreen extends StatefulWidget {
  //const ListStudentScreen({super.key});
  final Course course;
  const ListStudentScreen({Key? key, required this.course}) : super(key: key);
  @override
  State<ListStudentScreen> createState() => _ListStudentScreenState();
}

class _ListStudentScreenState extends State<ListStudentScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Màn hình danh sách học viên')),
    );
  }
}