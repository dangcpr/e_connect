import 'package:flutter/material.dart';
import 'package:e_connect/services/auth_service.dart';
import 'package:pinput/pinput.dart';

class Confirm extends StatefulWidget {
    const Confirm({Key? key, required this.email}) : super(key: key);
    final String email;

  @override
  State<Confirm> createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {

  TextEditingController _otp = TextEditingController();
  final focusNode = FocusNode();

  //final _formKey = GlobalKey<FormState>();
  final _formKeyConfirm = GlobalKey<FormState>();
   final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    AuthService().sendOTP(context: context, email: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //builder: Authenticator.builder(),
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: Colors.pink,
        ),
        home: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(       
            title: Text("Xác thực tài khoản", 
              style: TextStyle(fontFamily: "Google Sans", color: Colors.white, fontWeight: FontWeight.bold),),
            backgroundColor: Colors.pink,
            centerTitle: true,
          ),
          
          
          body: Center(
            child: Form (
              key: _formKeyConfirm,
                  child: Column (
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7.5),
                          child: Image.asset('assets/icons/register.png', 
                          width: 100, height: 100,)
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7.5),
                          child: Center (
                            child: Text("Vui lòng kiểm tra hộp thư đến và spam của email " + widget.email + " để nhận mã xác thực", textAlign: TextAlign.center,)
                          )
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                            width: 350,
                            height: 74,
                          /*
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
                                labelText: 'Mã xác thực',
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
                            */
                            child: Pinput(
                              controller: _otp,
                              focusNode: focusNode,
                              errorTextStyle: TextStyle(fontFamily: "Google Sans", fontSize: 14, color: const Color.fromARGB(255, 204, 0, 0)),
                              defaultPinTheme: PinTheme(
                                textStyle: TextStyle(
                                  fontSize: 22,
                                  height: 2.0,
                                  color: Colors.pink,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(19),
                                  border: Border.all(color: Colors.pink),
                                ),
                              ),
                              validator: (value) {
                                return value != '' ? null : 'Vui lòng nhập mã xác nhận';
                              },       
                            )
                          )
                        ),

                    Padding (
                      padding: const EdgeInsets.symmetric(vertical: 1.5),
                          child: ElevatedButton(
                            
                            onPressed: () {      
                                if(_formKeyConfirm.currentState!.validate()) {
                                  AuthService().verifiedEmail(context: context, email: widget.email, otp: _otp.text);
                                }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink, // background (button) color
                              foregroundColor: Colors.white, // foreground (text) color
                              
                            ),
                            child: const Text("XÁC THỰC",
                              style: TextStyle (
                              fontWeight: FontWeight.bold,
                          )),
                      )
                    ),

                    Padding (
                      padding: const EdgeInsets.symmetric(vertical: 7.5),
                      child: ElevatedButton(
                        onPressed: () {
                          AuthService().sendOTP(context: context, email: widget.email);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.pink
                        ),
                        child: const Text('GỬI LẠI MÃ',
                          style: TextStyle(fontWeight: FontWeight.bold))
                      )
                    )

                    
                      

                  ],
                ), 
              )
          )
        )
      );
  }      
}