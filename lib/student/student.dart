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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Học sinh'),
        centerTitle: true,
        backgroundColor: Colors.pink, 
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
                  MaterialPageRoute(builder: (context) => StudentScreen())
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
      body: Text(user.toJson()),
      
    );
  }
}