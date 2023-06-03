import 'package:e_connect/constants/global_variables.dart';
import 'package:e_connect/models/course.dart';
import 'package:e_connect/teacher/course_screen/docs.dart';
import 'package:e_connect/teacher/course_screen/homework.dart';
import 'package:e_connect/teacher/course_screen/info.dart';
import 'package:e_connect/teacher/course_screen/list_student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class CourseScreen extends StatefulWidget {
  final Course course;

  //const CourseScreen({super.key});
  const CourseScreen({Key? key, required this.course}) : super(key: key);

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  List<Widget> widgets = [];
  @override
  void initState() {
    super.initState();
    widgets = [InfomationScreen(course: widget.course), ListStudentScreen(course: widget.course), HomeworkScreen(course: widget.course), DocumentScreen(course: widget.course)];
  }  
  int _selectedIndex = 0;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  @override
  Widget build(BuildContext context) { 
    return Theme(
      data: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text ('Khóa học', 
            style: TextStyle(
              color: primaryColor,
              fontFamily: "Google Sans",
              fontWeight: FontWeight.bold
            ) 
          ),
          backgroundColor: primaryThemeColor,
          iconTheme: IconThemeData(
            color: primaryColor,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.close,
          spacing: 3,
          openCloseDial: isDialOpen,
          backgroundColor: primaryButtonColor3,
          //renderOverlay: false,
          //visible: true,
          useRotationAnimation: true,
          //closeManually: false,
          animationDuration: const Duration(milliseconds: 500),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40)
          ),
          children: [
            SpeedDialChild(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40)
              ),
              label: "Thêm bài tập",
              backgroundColor: primaryButtonColor3,
              child: Icon(Icons.home_work),
              onTap: () {

              }
            ),
            SpeedDialChild(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40)
              ),
              label: "Thêm tài liệu",
              backgroundColor: primaryButtonColor3,
              child: Icon(Icons.book),
              onTap: () {
                
              }
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          height: 70,
          selectedIndex: _selectedIndex,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          indicatorColor: Color.fromARGB(255, 255, 205, 222),
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: "Thông tin",
            ),
            NavigationDestination(
              icon: Icon(Icons.list),
              label: "Học viên"
            ),
            NavigationDestination(
              icon: Icon(Icons.home_work),
              label: "Bài tập"
            ),
            NavigationDestination(
              icon: Icon(Icons.book),
              label: "Tài liệu"
            )     
          ],
        ),
        body: widgets[_selectedIndex],
      ),
    );
  }
}