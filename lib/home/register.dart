import 'package:e_connect/services/auth_service.dart';
//import 'package:e_connect/models/ModelProvider.dart';

import 'package:e_connect/student/student.dart';
import 'package:e_connect/home/confirm.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _email = TextEditingController();
  String? _errorText_email = null;
  bool email_error = false;

  TextEditingController _pass = TextEditingController();
  String? _errorText_pass = null;
  bool pass_error = false;

  TextEditingController _rePass = TextEditingController();
  String? _errorText_rePass = null;
  bool rePass_error = false;

  TextEditingController _code = TextEditingController();
  String? _errorText_code = null;
  bool code_error = false;

  TextEditingController _role = TextEditingController();
  String? _errorText_role = null;
  final _roleList = ["Giáo viên", "Học sinh"];
  String? _selectedVal = "Giáo viên";

  bool _isObscurePass = true;
  bool _isObscureRePass = true;
  bool _isObscureConfirm = true;
  final _formKey = GlobalKey<FormState>();
  final _formKeyConfirm = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
  }

  void signUpUser() {
    _authService.signUpUser(
      context: context,
      email: _email.text.toString(),
      password: _pass.text.toString(),
      role: _selectedVal.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //initialStep: AuthenticatorStep.signUp,
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: Colors.pink,
        ),
        //builder: Authenticator.builder(),
        home: Scaffold(
            appBar: AppBar(
                title: Text("Đăng ký tài khoản",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Google Sans",
                        fontWeight: FontWeight.bold)),
                backgroundColor: Colors.pink,
                centerTitle: true,
                leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                )),
            body: Center(
                child: ListView(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7.5),
                            child: Image.asset(
                              'assets/icons/register.png',
                              width: 100,
                              height: 100,
                            )),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7.5),
                            child: SizedBox(
                                width: 350,
                                child: DropdownButtonFormField(
                                  value: _selectedVal,
                                  items: _roleList
                                      .map((e) => DropdownMenuItem(
                                            child: Text(e),
                                            value: e,
                                          ))
                                      .toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      _selectedVal = val as String;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      filled: true,
                                      labelText: "Bạn là?",
                                      labelStyle: const TextStyle(
                                        color: Colors.pink,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.pink,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                ))),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7.5),
                            child: SizedBox(
                                width: 350,
                                child: TextFormField(
                                  controller: _email,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Vui lòng nhập Email';
                                    }
                                    if (EmailValidator.validate(value) ==
                                        false) {
                                      return 'Email không hợp lệ';
                                    }
                                    return null;
                                  },
                                  cursorColor: Colors.pink,
                                  decoration: InputDecoration(
                                      //errorText: _errorText_email,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.pinkAccent,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.pinkAccent,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.pinkAccent,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      labelText: 'Email',
                                      labelStyle: const TextStyle(
                                        color: Colors.pink,
                                      )),
                                ))),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7.5),
                            child: SizedBox(
                                width: 350,
                                child: TextFormField(
                                  controller: _pass,
                                  obscureText: _isObscurePass,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Vui lòng nhập mật khẩu';
                                    }
                                    return null;
                                  },
                                  cursorColor: Colors.pink,
                                  decoration: InputDecoration(
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.pinkAccent,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.pinkAccent,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.pinkAccent,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      labelText: 'Mật khẩu',
                                      labelStyle: const TextStyle(
                                        color: Colors.pink,
                                      ),
                                      suffixIcon: IconButton(
                                          icon: _isObscurePass
                                              ? const Icon(Icons.visibility,
                                                  color: Colors.grey)
                                              : const Icon(Icons.visibility_off,
                                                  color: Colors.grey),
                                          onPressed: () {
                                            setState(() {
                                              _isObscurePass = !_isObscurePass;
                                            });
                                          })),
                                ))),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7.5),
                            child: SizedBox(
                                width: 350,
                                child: TextFormField(
                                  controller: _rePass,
                                  obscureText: _isObscureRePass,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Vui lòng nhập lại mật khẩu';
                                    }

                                    if (value != _pass.text) {
                                      return 'Vui lòng nhập khớp mật khẩu ban đầu';
                                    }
                                    return null;
                                  },
                                  cursorColor: Colors.pink,
                                  decoration: InputDecoration(
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.pinkAccent,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.pinkAccent,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.pinkAccent,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      labelText: 'Nhập lại mật khẩu',
                                      labelStyle: const TextStyle(
                                        color: Colors.pink,
                                      ),
                                      suffixIcon: IconButton(
                                          icon: _isObscureRePass
                                              ? const Icon(Icons.visibility,
                                                  color: Colors.grey)
                                              : const Icon(Icons.visibility_off,
                                                  color: Colors.grey),
                                          onPressed: () {
                                            setState(() {
                                              _isObscureRePass =
                                                  !_isObscureRePass;
                                            });
                                          })),
                                ))),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 1.5),
                            child: TextButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    signUpUser();
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                }
                              },
                              style: TextButton.styleFrom(
                                //backgroundColor: Colors.white, // background (button) color
                                foregroundColor:
                                    Colors.pink, // foreground (text) color
                              ),
                              child: const Text("GỬI MÃ XÁC NHẬN",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                            )),
                      ],
                    ),
                  ),
                ]))));
  }
}
