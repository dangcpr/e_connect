import 'dart:convert';

class Course {
  final String id;
  final String teacher;
  final String courseID;
  final String nameCourse;
  final String dateStart;
  final String dateEnd;
  final String pass;
  final int limit;
  final int registered;

  Course({
    required this.id, 
    required this.teacher, 
    required this.courseID, 
    required this.nameCourse, 
    required this.dateStart, 
    required this.dateEnd,
    required this.pass,
    required this.limit,
    required this.registered
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'teacher': teacher,
      'courseID': courseID,
      'nameCourse': nameCourse,
      'dateStart': dateStart,
      'dateEnd': dateEnd,
      'pass': pass,
      'limit': limit,
      'registered': registered
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['_id'] ?? '',
      teacher: map['teacher'] ?? '',
      courseID: map['courseID'] ?? '',
      nameCourse: map['nameCourse'] ?? '',
      dateStart: map['dateStart'] ?? '',
      dateEnd: map['dateEnd'] ?? '',
      pass: map['pass'] ?? '',
      limit: map['limit'] ?? '',
      registered: map['registered'] ?? ''
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) => Course.fromMap(json.decode(source));
}