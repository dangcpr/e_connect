import 'package:e_connect/account/account_services.dart';
import 'package:e_connect/models/course.dart';
import 'package:e_connect/provider/course_provider.dart';
import 'package:e_connect/provider/user_provider.dart';
import 'package:e_connect/services/course_service.dart';
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
  final CourseSerivce courseService = CourseSerivce();
  @override
  void initState() {
    super.initState();
    courseService.teacherGetCourse(context: context);
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    List<Course> courses = Provider.of<CourseProvider>(context).courses;

    return MaterialApp( 
      theme: ThemeData(
        useMaterial3: true,
        
      ),
      home: Builder(
        builder: (context) => RefreshIndicator(
          onRefresh: () async { return courseService.teacherGetCourse(context: context); }, 
          child: Scaffold(
            appBar: AppBar(
              title: Text('Giáo viên', style: TextStyle(color: Colors.white, fontFamily: "Google Sans", fontWeight: FontWeight.bold)),
              centerTitle: true,
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              backgroundColor: Colors.pink,
              //iconTheme: Theme.of(context).iconTheme,
              actions: <Widget> [
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddCourse()));
                  },
                  tooltip: "Thêm khóa học", 
                  icon: Icon(Icons.add)
                )
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
                        MaterialPageRoute(builder: (_) => TeacherScreen())
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
            body: courses.isEmpty ? Text('Bạn chưa tạo khóa học nào') : 
              ListView.builder(
                itemBuilder: ((context, index) => 
                  Card(
                    child: ListTile(
                      title: Text(courses[index].nameCourse, style: TextStyle(color: Colors.black, fontFamily: "Google Sans", fontWeight: FontWeight.bold)),
                      subtitle: Text('Giáo viên: ${courses[index].teacher}\nMã lớp: ${courses[index].courseID} \nSĩ số: ${courses[index].limit} \nĐã đăng ký: ${courses[index].registered}'),
                      onTap: () {
                        
                      },
                    )
                  )), 
                  //separatorBuilder: 
                itemCount: courses.length,
                )
          )
        )
      )
    ); 
  }
}