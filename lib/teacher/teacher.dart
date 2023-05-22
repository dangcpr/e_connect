import 'package:e_connect/account/account_services.dart';
import 'package:e_connect/provider/user_provider.dart';
import 'package:e_connect/teacher/add_course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TeacherScreen extends StatefulWidget {

  //const TeacherScreen({Key? key, required this.email, required this.pass}) : super(key: key);
  const TeacherScreen({super.key});
  static const String routeName = '/teacher';

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giáo viên'),
        centerTitle: true,
        backgroundColor: Colors.pink,
        actions: <Widget> [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => AddCourse()));
            },
            tooltip: "Thêm khóa học", 
            icon: Icon(Icons.add))
        ]
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget> [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.pinkAccent,
              ),
              child: Text(
                user.email,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24
                )
              ),
            ),


            ListTile(
              leading: SvgPicture.asset('assets/icons/drawer-home.svg', width: 24, height: 29.2),
              title: Text("Trang chính"),
              onTap: () {
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => TeacherScreen())
                );
              },
            ),

            ListTile(
              leading: SvgPicture.asset('assets/icons/drawer-home.svg', width: 24, height: 29.2),
              title: Text("Đăng xuất"),
              onTap: () {
                AccountServices().logOut(context);
              },
            )
          ]
        )
      ),
      body: Center(child: Text("Bạn chưa tạo khóa học nào")),
    );
  }
}