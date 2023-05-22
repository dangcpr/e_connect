import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response res,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch(res.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      Fluttertoast.showToast(
        msg: jsonDecode(res.body)['msg'],
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      break;
    case 500:
      Fluttertoast.showToast(
        msg: jsonDecode(res.body)['error'],
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      break;

      default:
      Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      
  }
}