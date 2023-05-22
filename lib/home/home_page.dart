import 'package:e_connect/home/register.dart';
import 'package:e_connect/provider/user_provider.dart';
import 'package:e_connect/services/auth_service.dart';
import 'package:e_connect/teacher/teacher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:e_connect/home/login_admin.dart';
import 'package:e_connect/home/login_user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../student/student.dart';

//import '../models/ModelProvider.dart';
class MyHomePageNow extends StatefulWidget {
  const MyHomePageNow({super.key});
  static const String routeName = '/home_page'; 

  @override
  State<MyHomePageNow> createState() => _MyHomePageNowState();
}

class _MyHomePageNowState extends State<MyHomePageNow> {
  @override

  Future<void> signOutCurrentUser(BuildContext context) async {
  // final result = await Amplify.Auth.signOut();
  // if (result is CognitoCompleteSignOut) {
  //   Fluttertoast.showToast(
  //     msg: "Đã đăng xuất tất cả user hiện có",
  //     toastLength: Toast.LENGTH_SHORT,
  //     timeInSecForIosWeb: 1,
  //     backgroundColor: Colors.black,
  //     textColor: Colors.white,
  //     fontSize: 16.0,
  //   );
  // } else if (result is CognitoFailedSignOut) {
  //   Fluttertoast.showToast(
  //     msg: "Lỗi đăng xuất",
  //     toastLength: Toast.LENGTH_SHORT,
  //     timeInSecForIosWeb: 1,
  //     backgroundColor: Colors.black,
  //     textColor: Colors.white,
  //     fontSize: 16.0,
  //   );
  // }
}
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = Provider.of<UserProvider>(context).user.token.isNotEmpty;
    return MaterialApp( 
    home: isLoggedIn
          ? ( Provider.of<UserProvider>(context).user.role == 'Học sinh' ? const StudentScreen() 
            : const TeacherScreen() )
          : DefaultTabController( 
            initialIndex: 0,
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Đăng nhập"),
                centerTitle:  true,
                backgroundColor: Colors.pink,
                bottom: const TabBar(
                  indicatorColor: Colors.white,
                  labelStyle: TextStyle(fontSize: 16),
                  tabs: <Widget>[
                  Tab(
                    text: "Học sinh & Giáo viên",
                  ),
                  Tab(
                    text: "Admin"
                  )
              ],)
              ),
              
              drawer: Drawer(
                child: ListView (
                  padding: EdgeInsets.zero,
                  children: [
                    const DrawerHeader (
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent,
                      ),
                      child: Text("Menu", 
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )
                    ),
                    ListTile(
                      leading: SvgPicture.asset(
                        'assets/icons/drawer-home.svg',
                        width: 24, height: 29.2
                        ),
                      title: const Text("Home",
                        style: TextStyle (
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: SvgPicture.asset(
                        'assets/icons/drawer-courses.svg',
                        width: 24, height: 29.2
                      ),
                      title: const Text(
                        "Đăng xuất",
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ) ),
                      onTap: () {
                        
                      },
                    )
                  ]
                )
              ),
              
              body: const TabBarView(children: <Widget>
              [
                Center(
                  child: LoginStudent(),
                ),
                Center(
                  child: LoginTeacher(),
                )
              ],
              ),

              floatingActionButton: FloatingActionButton.extended(
                label: const Text("Chưa có tài khoản?"),
                highlightElevation: 50,
                backgroundColor: Colors.pink,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Register()),
                  );
                },
              ),

              ),
            )
          );
        }
}