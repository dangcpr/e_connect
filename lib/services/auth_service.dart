import 'dart:convert';

import 'package:e_connect/constants/error_handling.dart';
import 'package:e_connect/home/confirm.dart';
import 'package:e_connect/home/home_page.dart';
import 'package:e_connect/models/user.dart';
import 'package:e_connect/provider/user_provider.dart';
import 'package:e_connect/student/student.dart';
import 'package:e_connect/teacher/teacher.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:e_connect/constants/global_variables.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';



class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      User user = User(
        id: '',
        email: email,
        password: password,
        role: role,
        token: '',
        verified: false,
        avatar: ''
      );
      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'), 
        body: user.toJson(),
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        res: res, 
        context: context, 
        onSuccess: () => {
          Fluttertoast.showToast(
            msg: 'Tạo tài khoản thành công, vui lòng kiểm tra hộp thư email để nhận mã xác thực.',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          ),

          // if(!jsonDecode(res.body)["verified"]) {
          //   Navigator.push(
          //    context, 
          //   MaterialPageRoute(builder: (_) => Confirm(email: email, pass: password)))
          // }
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
  }

  void signInUser ({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'), 
        body: jsonEncode({
          "email": email,
          "password": password
        }),
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      
      // ignore: use_build_context_synchronously
    httpErrorHandle(
        res: res, 
        context: context, 
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Fluttertoast.showToast(
            msg: 'Đăng nhập thành công',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );

          if(context.mounted) {
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            if(jsonDecode(res.body)['role'] == "Giáo viên") {
              Navigator.pushReplacement(
                context, 
              MaterialPageRoute(builder: (context) => TeacherScreen())); 
            }
            else if (jsonDecode(res.body)['role'] == "Học sinh") {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StudentScreen()));
              
            }
          }
          // if(!jsonDecode(res.body)["verified"]) {
          //   Navigator.push(
          //    context, 
          //   MaterialPageRoute(builder: (_) => Confirm(email: email, pass: password)))
          // }
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
  }
  
  Future<void> getUserData ({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final token = prefs.getString('x-auth-token');

      if(token == null) {
        prefs.setString('x-auth-token', '');
      }
      http.Response tokenRes = await http.post(
        Uri.parse("$uri/tokenIsValid"), 
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var res = jsonDecode(tokenRes.body)['status'];

      if(res == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String> {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          }
        );

        if(context.mounted) {
          var userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.setUser(userRes.body);
        }
      }
      else {
        if(context.mounted) {
          var userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.setUser(
            User(
              id: '',
              email: '',
              password: '',
              role: '',
              token: '',
              verified: false,
              avatar: ''
            ).toJson()
          );
        }
      }
          // if(!jsonDecode(res.body)["verified"]) {
          //   Navigator.push(
          //    context, 
          //   MaterialPageRoute(builder: (_) => Confirm(email: email, pass: password)))
          // }
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
  }
}