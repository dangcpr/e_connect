// ignore_for_file: use_build_context_synchronously
import 'package:e_connect/services/course_service.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({super.key});

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  List<GlobalKey<FormState>> _formKey = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];
  TextEditingController _nameCourse = TextEditingController();
  TextEditingController _dateStart = TextEditingController();
  late DateTime _dateStartTime;
  TextEditingController _dateEnd = TextEditingController();
  late DateTime _dateEndTime;
  TextEditingController _pass = TextEditingController();
  TextEditingController _limit = TextEditingController();
  bool _isSecurePass = true;

  final CourseSerivce _courseService = CourseSerivce();
  //late Future<String> courseID;

  Future<void> createCourse() async {
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

    String courseid = await _courseService.createCourseTeacher(
        context: context,
        nameCourse: _nameCourse.text,
        dateStart: _dateStart.text,
        dateEnd: _dateEnd.text,
        limit: int.tryParse(_limit.text)!,
        pass: _pass.text);

    Navigator.of(context).pop();

    await CourseSerivce().teacherGetCourse(context: context);

    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Tạo khóa học thành công",
                  style: TextStyle(
                      fontFamily: "Google Sans",
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              content: Text("Mã số khóa học: $courseid"),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('ĐÓNG',
                        style: TextStyle(
                            color: Colors.pink, fontWeight: FontWeight.bold)))
              ]);
        });

    Navigator.of(context).pop();
  }

  List<Step> stepList() => [
        Step(
            isActive: _activeStepIndex >= 0,
            state:
                _activeStepIndex > 0 ? StepState.complete : StepState.indexed,
            title: const Text(
              'Tên khóa học',
              style: TextStyle(fontSize: 16),
            ),
            content: Form(
                key: _formKey[0],
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7.5),
                      child: SizedBox(
                          width: 320,
                          child: TextFormField(
                            controller: _nameCourse,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập tên khóa học';
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
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.pinkAccent,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.pinkAccent,
                                    ),
                                    borderRadius: BorderRadius.circular(30)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.pinkAccent),
                                    borderRadius: BorderRadius.circular(30)),
                                labelText: "Tên khóa học",
                                labelStyle: const TextStyle(
                                  color: Colors.pink,
                                )),
                          )),
                    )
                  ],
                ))),
        Step(
            isActive: _activeStepIndex >= 1,
            state:
                _activeStepIndex > 1 ? StepState.complete : StepState.indexed,
            title: Text(
              'Thời gian khóa học',
              style: TextStyle(fontSize: 16),
            ),
            content: Form(
                key: _formKey[1],
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7.5),
                      child: SizedBox(
                          width: 320,
                          child: TextFormField(
                            controller: _dateStart,
                            readOnly: true,
                            onTap: () {
                              showDatePicker(
                                  context: context,
                                  initialDate: _dateStart.text.isEmpty
                                      ? DateTime.now()
                                      : _dateStartTime,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(DateTime.now().year + 30),
                                  initialEntryMode:
                                      DatePickerEntryMode.calendarOnly,
                                  builder: (context, child) {
                                    return Theme(
                                      data: ThemeData(
                                          useMaterial3: true,
                                          colorSchemeSeed: Colors.pink),
                                      child: child!,
                                    );
                                  }).then((date) {
                                setState(() {
                                  _dateStartTime = date!;
                                  _dateStart.text = DateFormat('dd/MM/yyyy')
                                      .format(_dateStartTime);
                                });
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập ngày bắt đầu';
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
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.pinkAccent,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.pinkAccent,
                                    ),
                                    borderRadius: BorderRadius.circular(30)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.pinkAccent),
                                    borderRadius: BorderRadius.circular(30)),
                                labelText: "Ngày bắt đầu",
                                labelStyle: const TextStyle(
                                  color: Colors.pink,
                                )),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7.5),
                      child: SizedBox(
                          width: 320,
                          child: TextFormField(
                            controller: _dateEnd,
                            readOnly: true,
                            onTap: () {
                              showDatePicker(
                                  context: context,
                                  initialDate: _dateEnd.text.isEmpty
                                      ? DateTime.now()
                                      : _dateEndTime,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(DateTime.now().year + 30),
                                  initialEntryMode:
                                      DatePickerEntryMode.calendarOnly,
                                  builder: (context, child) {
                                    return Theme(
                                      data: ThemeData(
                                          useMaterial3: true,
                                          colorSchemeSeed: Colors.pink),
                                      child: child!,
                                    );
                                  }).then((date) {
                                setState(() {
                                  _dateEndTime = date!;
                                  _dateEnd.text = DateFormat('dd/MM/yyyy')
                                      .format(_dateEndTime);
                                });
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập ngày kết thúc';
                              }
                              if (_dateStartTime
                                      .isAtSameMomentAs(_dateEndTime) ||
                                  _dateStartTime.isAfter(_dateEndTime)) {
                                return 'Ngày kết thúc phải lớn hơn ngày bắt đầu';
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
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.pinkAccent,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.pinkAccent,
                                    ),
                                    borderRadius: BorderRadius.circular(30)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.pinkAccent),
                                    borderRadius: BorderRadius.circular(30)),
                                labelText: "Ngày kết thúc",
                                labelStyle: const TextStyle(
                                  color: Colors.pink,
                                )),
                          )),
                    ),
                  ],
                ))),
        Step(
            isActive: _activeStepIndex >= 2,
            state:
                _activeStepIndex > 2 ? StepState.complete : StepState.indexed,
            title: Text(
              'Bảo mật khóa học',
              style: TextStyle(fontSize: 16),
            ),
            content: Form(
                key: _formKey[2],
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7.5),
                      child: SizedBox(
                          width: 320,
                          child: TextFormField(
                            controller: _limit,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập sĩ số';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Vui lòng chỉ nhập chữ số';
                              }
                              if (int.tryParse(value)! <= -1) {
                                return 'Vui lòng nhập số nguyên dương hoặc số 0';
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
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.pinkAccent,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.pinkAccent,
                                    ),
                                    borderRadius: BorderRadius.circular(30)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.pinkAccent),
                                    borderRadius: BorderRadius.circular(30)),
                                labelText: "Sĩ số",
                                labelStyle: const TextStyle(
                                  color: Colors.pink,
                                )),
                          )),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7.5),
                        child: SizedBox(
                            width: 320,
                            child: Text(
                                'Nếu nhập số 0 thì lớp học sẽ không bị giới hạn số lượng'))),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7.5),
                      child: SizedBox(
                          width: 320,
                          child: TextFormField(
                            controller: _pass,
                            obscureText: _isSecurePass,
                            validator: (value) {
                              // if (value == null || value.isEmpty) {
                              //   return 'Vui lòng nhập sĩ số';
                              // }
                              return null;
                            },
                            cursorColor: Colors.pink,
                            decoration: InputDecoration(
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.pinkAccent,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.pinkAccent,
                                    ),
                                    borderRadius: BorderRadius.circular(30)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.pinkAccent),
                                    borderRadius: BorderRadius.circular(30)),
                                labelText: "Mật khẩu khóa học",
                                labelStyle: const TextStyle(
                                  color: Colors.pink,
                                ),
                                suffixIcon: IconButton(
                                    icon: _isSecurePass
                                        ? const Icon(Icons.visibility,
                                            color: Colors.grey)
                                        : const Icon(Icons.visibility_off,
                                            color: Colors.grey),
                                    onPressed: () => {
                                          setState(() {
                                            _isSecurePass = !_isSecurePass;
                                          })
                                        })),
                          )),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7.5),
                        child: SizedBox(
                          width: 320,
                          child: Text('Có thể bỏ trống mật khẩu'),
                        ))
                  ],
                ))),
      ];

  int _activeStepIndex = 0;

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Thêm khóa học",
              style: TextStyle(
                  color: Colors.pink,
                  fontFamily: "Google Sans",
                  fontWeight: FontWeight.bold)),
          //centerTitle: true,
          shadowColor: Colors.pink,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.pink,
          ),
        ),
        body: Theme(
            data: ThemeData(
                useMaterial3: true,
                //primarySwatch: Colors.pink,
                colorSchemeSeed: Colors.pink,
                fontFamily: "Google Sans"),
            child: Stepper(
              type: StepperType.vertical,
              steps: stepList(),

              currentStep: _activeStepIndex,
              //controlsBuilder: (),
              onStepContinue: () => {
                if (_formKey[_activeStepIndex].currentState!.validate())
                  {
                    if (_activeStepIndex < (stepList().length - 1))
                      {
                        _activeStepIndex += 1,
                      }
                    else
                      {
                        createCourse(),
                        CourseSerivce().teacherGetCourse(context: context),
                      },
                  },
                setState(() {}),
              },
              onStepCancel: () => {
                if (_activeStepIndex != 0)
                  {
                    _activeStepIndex -= 1,
                  },
                setState(() {}),
              },
            )));
  }
}
