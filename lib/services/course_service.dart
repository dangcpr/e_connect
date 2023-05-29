import 'dart:convert';

import 'package:e_connect/constants/error_handling.dart';
import 'package:e_connect/models/course.dart';
import 'package:e_connect/provider/course_provider.dart';
import 'package:e_connect/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:e_connect/constants/global_variables.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CourseSerivce {
  Future<String> createCourseTeacher({
    required BuildContext context,
    required String nameCourse,
    required String dateStart,
    required String dateEnd,
    required String pass,
    required int limit,
  }) async {
    try {
      Course course = Course(
          id: '',
          teacher: '',
          courseID: '',
          nameCourse: nameCourse,
          dateStart: dateStart,
          dateEnd: dateEnd,
          pass: pass,
          limit: limit,
          registered: 0);

      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response res = await http.post(Uri.parse('$uri/course/create'),
          body: course.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          });

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          res: res,
          context: context,
          onSuccess: () async {
            Fluttertoast.showToast(
              msg: 'Tạo khóa học thành công',
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0,
            );

            courseid_create = json.decode(res.body)['courseID'];
          });
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    return courseid_create;
  }

  Future<void> teacherGetCourse({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      http.Response res = await http.get(Uri.parse('$uri/course/teacher/get'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });
      // ignore: use_build_context_synchronously
      httpErrorHandle(
          res: res,
          context: context,
          onSuccess: () async {
            Provider.of<CourseProvider>(context, listen: false)
                .teacherSetCourse(res.body);
            Fluttertoast.showToast(
              msg: 'Lấy khóa học thành công',
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          });
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
