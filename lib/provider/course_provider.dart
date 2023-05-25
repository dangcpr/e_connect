import 'dart:convert';

import 'package:e_connect/models/course.dart';
import 'package:e_connect/models/user.dart';
import 'package:flutter/material.dart';

class CourseProvider extends ChangeNotifier {
  List<Course> _courses = [];
  
  List<Course> get courses => _courses;
  
  /*
  void addCourse(String course) {
    Course _course = Course.fromJson(course);
    _courses.add(_course);
    notifyListeners();
  }
  */

  void teacherSetCourse(String course) {
    Iterable i = json.decode(course);
    _courses = List<Course>.from(i.map((model) => Course.fromMap(model)));
    notifyListeners();
  }
}