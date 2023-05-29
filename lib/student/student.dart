import 'package:e_connect/account/account_services.dart';
import 'package:e_connect/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class StudentScreen extends StatefulWidget {
  //const StudentScreen({Key? key, required this.email, required this.pass}) : super(key: key);
  const StudentScreen({super.key});
  static const String routeName = '/student';

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
        ),
        home: Builder(
          builder: (context) => RefreshIndicator(
            onRefresh: () async {
            },
          child:  Scaffold(
            appBar: AppBar(
              title: const Text('Học sinh', 
                style: TextStyle(
                color: Colors.white,
                fontFamily: "Google Sans",
                fontWeight: FontWeight.bold)),
              centerTitle: true,
              backgroundColor: Colors.pink,
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                  
                  },
                  tooltip: "Tham gia khóa học",
                  icon: Icon(Icons.add))
              ]),
                        
            drawer: Drawer(
                child: ListView(padding: EdgeInsets.zero, children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.pinkAccent,
                ),
                child: Text(user.email,
                    style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
              ListTile(
                leading: SvgPicture.asset('assets/icons/drawer-home.svg',
                    width: 24, height: 29.2),
                title: Text("Trang chính"),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => StudentScreen()));
                },
              ),
              ListTile(
                leading: SvgPicture.asset('assets/icons/drawer-home.svg',
                    width: 24, height: 29.2),
                title: Text("Đăng xuất"),
                onTap: () {
                  AccountServices().logOut(context);
                },
              )
            ])),
            body: Center(child: Text("Bạn chưa tham gia khóa học nào")),
          )
        )
      )
    );
  }
}
