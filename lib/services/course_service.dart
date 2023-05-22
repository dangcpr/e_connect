import 'dart:convert';

import 'package:e_connect/constants/error_handling.dart';
import 'package:e_connect/models/course.dart';
import 'package:e_connect/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:e_connect/constants/global_variables.dart';
import 'package:provider/provider.dart';
/*
void _dialogBuilder(BuildContext context, http.Response r) { 
    FutureBuilder(
      future: res
      builder: (context, AsyncSnapshot snapshot) {
        final courseID = snapshot.data!; 
        if(snapshot.connectionState == ConnectionState.waiting) {
          if(snapshot.hasData) {
            return Theme(
                data: ThemeData(
                  colorSchemeSeed: Colors.pink
                ),
                child: Dialog(
                  child: AlertDialog(
                    title: const Text('Tạo khóa học thành công'),
                    content: Text("Mã khóa học là: $courseID"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        }, 
                        child: Text('ĐÓNG')
                      )
                    ],
                  )
              )
            );
          } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
          }
        }

        return Theme(
          data: ThemeData(
            colorSchemeSeed: Colors.pink
          ),
          child: const Dialog(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Loading...')
                ],
              )
            ),
          )
        );
      });
    // await Future.delayed(const Duration(seconds: 3));
    // if (!mounted) return;
    //   Navigator.of(context).pop();
    }
*/
class CourseSerivce {
  Future<String> createCourseTeacher ({
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
        registered: 0
      );

      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response res = await http.post(
        Uri.parse('$uri/course/create'),
        body: course.toJson(),
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        }
      );

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
    } catch(e) {
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
}