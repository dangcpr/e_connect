import 'package:e_connect/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    email: '',
    password: '',
    role: '',
    token: '',
    verified: false,
    avatar: ''
  );
  
  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}