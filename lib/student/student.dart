import 'package:e_connect/account/account_services.dart';
import 'package:e_connect/models/list_student.dart';
import 'package:e_connect/provider/list_student_provider.dart';
import 'package:e_connect/provider/user_provider.dart';
import 'package:e_connect/services/course_service.dart';
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
  void initState() {
    super.initState();
    CourseSerivce().studentGetCourse(context: context);
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    List<List_Student> list_course_student = Provider.of<ListStudentProvider>(context).courses;

    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
        ),
        home: Builder(
          builder: (context) => RefreshIndicator(
            onRefresh: () async {
              CourseSerivce().studentGetCourse(context: context);
            },
          child:  Scaffold(
            appBar: AppBar(
              title: const Text('Học sinh', 
                style: TextStyle(
                color: Colors.pink,
                fontFamily: "Google Sans",
                fontWeight: FontWeight.bold)),
              //centerTitle: true,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(
                color: Colors.pink,
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    showFormDialog(context);
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
            body: list_course_student.isEmpty ?  Center(child: Text("Bạn chưa tham gia khóa học nào")) 
              : Column(
                  children: <Widget>[
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
                                        title: Text(list_course_student[index].nameCourse,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Google Sans",
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        subtitle: Text(
                                            'Giáo viên: ${list_course_student[index].teacher}\nMã lớp: ${list_course_student[index].courseID}\nSĩ số: ${list_course_student[index].limit} \nĐã đăng ký: ${list_course_student[index].registered}'),
                                        onTap: () {},
                                      )))),
                              //separatorBuilder:
                              itemCount: list_course_student.length,
                            ))
                          ]),
          )
        )
      )
    );
  }

  final GlobalKey<FormState> _keyDialogForm = GlobalKey<FormState>();
  TextEditingController _courseid = TextEditingController();
  TextEditingController _passCourse = TextEditingController();


  //Hiển thị Form Dialog khi muốn tham gia khóa học (vì code file riêng bị lỗi UI không biết fix :))
  bool _isObscureCourse = true;
  Future showFormDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
       return AlertDialog(
        title: Text("Tham gia khóa học"),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              if(_keyDialogForm.currentState!.validate()) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation<Color>(Colors.pink)),
                                SizedBox(
                                  height: 15,
                                ),
                                Text('Loading...')
                              ],
                            )));
                  });
                bool res = await CourseSerivce().joinCourseStudent(
                  context: context, 
                  courseID: _courseid.text, 
                  pass: _passCourse.text
                );

                if (!res) {
                  Navigator.of(context).pop();
                  
                }
                else {
                  await CourseSerivce().studentGetCourse(
                    context: context
                  );
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();

                  _courseid.text = "";
                  _passCourse.text = "";
                }
              }
            },
            child: Text('THAM GIA',
              style: TextStyle(
              color: Colors.pink, fontWeight: FontWeight.bold))),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('ĐÓNG',
              style: TextStyle(
              color: Colors.pink, fontWeight: FontWeight.bold)))
        ],
        content: Form(
          key: _keyDialogForm,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.5),
                  child: SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: _courseid,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập mã khóa học';
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
                        labelText: 'Mã khóa học',
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
                      controller: _passCourse,
                      obscureText: _isObscureCourse,
                      validator: (value) {
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
                        labelText: 'Mật khẩu khóa học',
                        labelStyle: const TextStyle(
                          color: Colors.pink,
                        ),
                        suffixIcon: IconButton(
                          icon: _isObscureCourse ? const Icon(Icons.visibility, color: Colors.grey) : const Icon(Icons.visibility_off, color: Colors.grey),
                          onPressed: () {
                            setState(() {
                              _isObscureCourse = !_isObscureCourse;
                            });
                          }
                        )
                      ),
                    )
                  )
                ),
              ]
            )
          )
        );
      }
    );
  }
}


