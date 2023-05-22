import 'dart:convert';

class User {
  final String id;
  final String email;
  final String password;
  final String role;
  final String token;
  final bool verified;
  final String avatar;

  User({
    required this.id, 
    required this.email, 
    required this.password, 
    required this.role, 
    required this.token, 
    required this.verified,
    required this.avatar
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'role': role,
      'token': token,
      'verified': verified,
      'avatar': avatar
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      role: map['role'] ?? '',
      token: map['token'] ?? '',
      verified: map['verified']  ?? '',
      avatar: map['avatar'] ?? ''
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}