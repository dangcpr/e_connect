import 'package:e_connect/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class LoginStudent extends StatefulWidget {
  const LoginStudent ({super.key});

  @override
  State<LoginStudent> createState() => _LoginStudent();
  /*Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Đây là màn hình của Học sinh"),)
    );
  }*/
}

class _LoginStudent extends State<LoginStudent> {
  //int _count = 0;
  TextEditingController _email = TextEditingController();
  bool email_error = false;

  TextEditingController _pass = TextEditingController();
  bool pass_error = false;

  bool _isObscure = true;

  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  // @override
  // void initState() {
    
  // }

    @override
  void initState() {
    super.initState();
  }

  void signInUser() {
    _authService.signInUser(
      context: context,
      email: _email.text.toString(),
      password: _pass.text.toString(),
    );
  }
  @override
  Widget build(BuildContext context) {

    // Create a global key that uniquely identifies the Form widget
    // and allows validation of the form.
    //
    // Note: This is a GlobalKey<FormState>,
    // not a GlobalKey<MyCustomFormState>.
    
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            //shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20), //Center of screen
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.5),
                child: Image.asset(
                  'assets/covers/login_cover.jpg', 
                  width: 500),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.5),
                child: SizedBox(
                  width: 350,
                  child: Text("Welcome Back!",
                    style: TextStyle(
                      fontFamily: "Google Sans",
                      fontSize: 26,
                      fontWeight: FontWeight.bold
                    )) 
                )
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.5),
                child: SizedBox(
                  width: 350,
                  child: Text("Vui lòng đăng nhập để tiếp tục",
                    style: TextStyle(
                      fontFamily: "Google Sans",
                      fontSize: 16,
                    )) 
                )
              ),

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
                      if (EmailValidator.validate(value) == false) {
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
                        borderRadius: BorderRadius.circular(30)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.pinkAccent,
                        ),
                        borderRadius: BorderRadius.circular(30)
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.pinkAccent,
                        ),
                        borderRadius: BorderRadius.circular(30)
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.pinkAccent,
                        ),
                        borderRadius: BorderRadius.circular(30)
                      ),
                      labelText: 'Email',
                      labelStyle: const TextStyle(
                        color: Colors.pink,
                      )
                    ),
                  )
                )
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.5),
                child: SizedBox(
                width: 350,
                  child: TextFormField(
                    controller: _pass,
                    obscureText: _isObscure,
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
                        borderRadius: BorderRadius.circular(30)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.pinkAccent,
                        ),
                        borderRadius: BorderRadius.circular(30)
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.pinkAccent,
                        ),
                        borderRadius: BorderRadius.circular(30)
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.pinkAccent,
                        ),
                        borderRadius: BorderRadius.circular(30)
                      ),
                      labelText: 'Mật khẩu',
                      labelStyle: const TextStyle(
                        color: Colors.pink,
                      ),
                      suffixIcon: IconButton(
                        icon: _isObscure ? const Icon(Icons.visibility, color: Colors.grey) : const Icon(Icons.visibility_off, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        }
                      )
                    ),
                  )
                )
              ),

              Padding (
                padding: const EdgeInsets.symmetric(vertical: 1.5),
                child: ElevatedButton(
                  
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                      try {
                        signInUser();
                      } catch(e) {
                        print(e.toString());
                      }
                    }                 
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink, // background (button) color
                    foregroundColor: Colors.white, // foreground (text) color
                  ),
                  child: const Text("ĐĂNG NHẬP",
                    style: TextStyle (
                    fontWeight: FontWeight.bold,
                )),
                )
              ),

              Padding (
                padding: const EdgeInsets.symmetric(),
                child: TextButton(
                  onPressed: () {
                    
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.pink, // foreground (text) color
                  ),
                  child: const Text("QUÊN MẬT KHẨU",
                    style: TextStyle (
                    fontWeight: FontWeight.bold,
                  )),
                )
              )
            ],
          )
        )
      )
    );
  }
}