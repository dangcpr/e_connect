import 'dart:convert';

import 'package:e_connect/models/list_student.dart';
import 'package:flutter/material.dart';

class ListStudentProvider extends ChangeNotifier {
  List<List_Student> _courses = [];

  List<List_Student> get courses => _courses;

  void studentSetCourse(String course) {
    Iterable i = json.decode(course);
    _courses = List<List_Student>.from(i.map((model) => List_Student.fromMap(model)));
    notifyListeners();
  }
}
