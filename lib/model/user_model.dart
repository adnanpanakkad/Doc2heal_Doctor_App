import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? coverimag;
  final String? name;
  final String? phone;
  final String? gender;
  final String? age;
  final String? email;
  final String? password;
  final String? id;

  UserModel({
    this.coverimag,
    required this.name,
    required this.phone,
    required this.gender,
    required this.age,
    required this.email,
    required this.password,
    this.id,
  });

  // Factory constructor to create UserModel from JSON data
  // factory UserModel.fromJson(Map<String, dynamic> json) {
  //   return UserModel(
  //     coverimag: json['coverimag'],
  //     name: json['name'],
  //     phone: json['phone'],
  //     gender: json['gender'],
  //     age: json['age'],
  //     email: json['email'],
  //     password: json['password'],
  //     id: json['id'],
  //   );
  // }
  factory UserModel.fromSnapshot(DocumentSnapshot<Object?> snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    return UserModel(
      coverimag: data?['coverimag'] ?? '',
      name: data?['name'] ?? '',
      phone: data?['phone'] ?? '',
      gender: data?['gender'] ?? '',
      age: data?['age'] ?? '',
      email: data?['email'] ?? '',
      password: data?['password'] ?? '',
      id: data?['id'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'coverimag': coverimag,
      'name': name,
      'phone': phone,
      'gender': gender,
      'age': age,
      'email': email,
      'password': password,
      'id': id,
    };
  }
}
