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
                onRefresh: () async {
                  return courseService.teacherGetCourse(context: context);
                },
                child: Scaffold(
                    appBar: AppBar(
                        title: Text('Giáo viên',
                            style: TextStyle(
                                color: Colors.pink,
                                fontFamily: "Google Sans",
                                fontWeight: FontWeight.bold)),
                        //centerTitle: true,
                        shadowColor: Colors.pink,
                        iconTheme: IconThemeData(
                          color: Colors.pink,
                        ),
                        backgroundColor: Colors.white,
                        //iconTheme: Theme.of(context).iconTheme,
                        actions: <Widget>[
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddCourse()));
                              },
                              tooltip: "Thêm khóa học",
                              icon: Icon(Icons.add))
                        ]),
                    drawer: Drawer(
                        child: ListView(
                            padding: EdgeInsets.zero,
                            children: <Widget>[
                          DrawerHeader(
                            decoration: BoxDecoration(
                              color: Colors.pinkAccent,
                            ),
                            child: Text(user.email,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24)),
                          ),
                          ListTile(
                            leading: SvgPicture.asset(
                                'assets/icons/drawer-home.svg',
                                width: 24,
                                height: 29.2),
                            title: Text("Trang chính"),
                            onTap: () {
                              Navigator.of(context).pop();
                              /*
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => TeacherScreen()));*/
                            },
                          ),
                          ListTile(
                            leading: SvgPicture.asset(
                                'assets/icons/drawer-home.svg',
                                width: 24,
                                height: 29.2),
                            title: Text("Đăng xuất"),
                            onTap: () {
                              AccountServices().logOut(context);
                            },
                          )
                        ])),
                    body: courses.isEmpty
                        ? Center(child: Text('Bạn chưa tạo khóa học nào'))
                        : Column(children: <Widget>[
                            Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  //color: Colors.pinkAccent,
                                  color: Color.fromARGB(255, 232, 232, 232),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Tìm kiếm khóa học",
                                    border: InputBorder.none,
                                    suffixIcon: Icon(Icons.search),
                                  ),
                                  cursorColor: Colors.pink,
                                )),
                            Expanded(
                                child: ListView.builder(
                              itemBuilder: ((context, index) => Container(
                                  margin: EdgeInsets.symmetric(horizontal: 7.5),
                                  child: Card(
                                      shadowColor: Colors.pink,
                                      child: ListTile(
                                        title: Text(courses[index].nameCourse,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Google Sans",
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        subtitle: Text(
                                            'Giáo viên: ${courses[index].teacher}\nMã lớp: ${courses[index].courseID} \nSĩ số: ${courses[index].limit} \nĐã đăng ký: ${courses[index].registered}'),
                                        onTap: () {},
                                      )))),
                              //separatorBuilder:
                              itemCount: courses.length,
                            ))
                          ])))));
  }
}
