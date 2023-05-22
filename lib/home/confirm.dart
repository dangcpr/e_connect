import 'package:e_connect/student/student.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Confirm extends StatefulWidget {
    const Confirm({Key? key, required this.email, required this.pass}) : super(key: key);
    final String email, pass;

  @override
  State<Confirm> createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {

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
  //final _formKey = GlobalKey<FormState>();
  final _formKeyConfirm = GlobalKey<FormState>();
   final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    //_configureAmplify();
  }

  // final _amplifyInstance = Amplify;

  // void _configureAmplify() async {
  //   try {

  //     await Amplify.addPlugin(AmplifyAuthCognito());
  //     await Amplify.configure(amplifyconfig);
  //     safePrint('Successfully configured');
  //   } on Exception catch (e) {
  //     safePrint('Error configuring Amplify: $e');
  //   }
  // }
  
  Future<void> _submitCode(BuildContext context) async {
    if(_formKeyConfirm.currentState!.validate()) {
                                
      final confirmationCode = _code.text;
      //try {

            
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => StudentScreen()));
       //on AuthException catch (e)  {
        //if(!mounted) return;
       // Fluttertoast.showToast(
       //     msg: e.message,
       //     toastLength: Toast.LENGTH_SHORT,
        //    timeInSecForIosWeb: 1,
        //    backgroundColor: Colors.black,
        //    textColor: Colors.white,
        //    fontSize: 16.0,
        //);
      //}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      //initialStep: AuthenticatorStep.signUp,
      child: MaterialApp(
        //builder: Authenticator.builder(),
        home: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(       
            title: Text("Đăng ký tài khoản"),
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
            )
          ),
          
          
          body: Center(
            child: Form (
              key: _formKeyConfirm,
                  child: Column (
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7.5),
                          child: Image.asset('lib/assets/icons/register.png', 
                          width: 100, height: 100,)
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7.5),
                          child: SizedBox(
                          width: 350,
                            child: TextFormField(
                              controller: _code,
                              obscureText: _isObscureConfirm,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập mã xác nhận';
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
                                labelText: 'Mã xác nhận',
                                labelStyle: const TextStyle(
                                  color: Colors.pink,
                                ),
                                suffixIcon: IconButton(
                                  icon: _isObscureConfirm ? const Icon(Icons.visibility, color: Colors.grey) : const Icon(Icons.visibility_off, color: Colors.grey),
                                  onPressed: () {
                                    setState(() {
                                      _isObscureConfirm = !_isObscureConfirm;
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
                                _submitCode(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink, // background (button) color
                              foregroundColor: Colors.white, // foreground (text) color
                              
                            ),
                            child: const Text("ĐĂNG KÝ TÀI KHOẢN",
                              style: TextStyle (
                              fontWeight: FontWeight.bold,
                          )),
                          )
                    )

                      

                      ],
                  ), 
                )
          )
        )
      )
    );
  }      
}