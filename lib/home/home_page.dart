import 'package:e_connect/home/register.dart';
import 'package:e_connect/provider/user_provider.dart';
import 'package:e_connect/services/auth_service.dart';
import 'package:e_connect/teacher/teacher.dart';
import 'package:flutter/material.dart';
import 'package:e_connect/home/login_user.dart';
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
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn =
        Provider.of<UserProvider>(context).user.token.isNotEmpty;
    return isLoggedIn
        ? (Provider.of<UserProvider>(context).user.role == 'Học sinh'
            ? const StudentScreen()
            : const TeacherScreen())
        : MaterialApp(
            theme: ThemeData(
              useMaterial3: true,
              primaryColor: Colors.pink,
            ),
            home: Builder(
                builder: (context) => DefaultTabController(
                      initialIndex: 0,
                      length: 2,
                      child: Scaffold(
                        /*
            appBar: AppBar(
              title: Text("Đăng nhập",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Google Sans",
                  fontWeight: FontWeight.bold)),
              centerTitle: true,
              //shadowColor: Colors.grey,
              backgroundColor: Colors.pink,
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              bottom: const TabBar(
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: "Google Sans",
                  fontWeight: FontWeight.bold),
                tabs: <Widget>[
                Tab(
                  text: "Học sinh & Giáo viên",
                ),
                Tab(text: "Admin")
                ],
              )),
            
            drawer: Drawer(
              backgroundColor: Colors.white,
              child:
                ListView(padding: EdgeInsets.zero, children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  ),
                  child: Text(
                  "Menu",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  )),
                ListTile(
                leading: SvgPicture.asset(
                  'assets/icons/drawer-home.svg',
                  width: 24,
                  height: 29.2),
                title: const Text("Home",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
                onTap: () {
                  Navigator.pop(context);
                },
                ),
                ListTile(
                leading: SvgPicture.asset(
                  'assets/icons/drawer-courses.svg',
                  width: 24,
                  height: 29.2),
                title: const Text("Đăng xuất",
                  style:
                    TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {},
                )
              ])),
              */
                        body: SafeArea(
                          child: Center(
                            child: LoginStudent(),
                          ),
                        ),
                        floatingActionButton: FloatingActionButton.extended(
                          label: const Text("Chưa có tài khoản?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Google Sans",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          highlightElevation: 50,
                          backgroundColor: Colors.pink,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const Register()),
                            );
                          },
                        ),
                      ),
                    )));
  }
}
