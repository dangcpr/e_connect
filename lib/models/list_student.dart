import 'dart:convert';

class List_Student {
  final String id;
  final String student;
  final String courseID;
  final String dateJoin;
  final String teacher;
  final String nameCourse;
  final String dateStart;
  final String dateEnd;
  final int limit;
  final int registered;

  List_Student({
    required this.id, 
    required this.student, 
    required this.courseID,
    required this.dateJoin, 
    required this.teacher,
    required this.nameCourse,
    required this.dateStart,
    required this.dateEnd,
    required this.limit,
    required this.registered,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'student': student,
      'courseID': courseID,
      'dateJoin': dateJoin,
      "teacher": teacher,
      "nameCourse": nameCourse,
      "dateStart": dateStart,
      "dateEnd": dateEnd,
      "limit": limit,
      "registered": registered,
    };
  }

  factory List_Student.fromMap(Map<String, dynamic> map) {
    return List_Student(
      id: map['_id'] ?? '',
      student: map['student'] ?? '',
      courseID: map['courseID'] ?? '',
      dateJoin: map['dateJoin'] ?? '',
      teacher: map['teacher'] ?? '',
      nameCourse: map['nameCourse'] ?? '',
      dateStart: map['dateStart'] ?? '',
      dateEnd: map['dateEnd'] ?? '',
      limit: map['limit'] ?? 0,
      registered: map['registered'] ?? 0
    );
  }

  String toJson() => json.encode(toMap());

  factory List_Student.fromJson(String source) => List_Student.fromMap(json.decode(source));
}