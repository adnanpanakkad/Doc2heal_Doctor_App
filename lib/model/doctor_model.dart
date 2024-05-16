import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  final String? profilepic;
  String? expcerft;
  final String? name;
  final String? phone;
  final String? gender;
  final String? birthday;
  final String? specialization;
  final String? email;
  final String? password;
  late final String? id;

  DoctorModel({
    required this.profilepic,
    this.expcerft,
    required this.name,
    required this.phone,
    required this.gender,
    required this.birthday,
    required this.specialization,
    required this.email,
    required this.password,
    required this.id,
  });

  // Factory constructor to create UserModel from JSON data

  factory DoctorModel.fromSnapshot(DocumentSnapshot<Object?> snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    return DoctorModel(
      profilepic: data?['profilepic'] ?? '',
      expcerft: data?['expcerft'] ?? '',
      name: data?['name'] ?? '',
      phone: data?['phone'] ?? '',
      gender: data?['gender'] ?? '',
      birthday: data?['birthday'] ?? '',
      specialization: data?['specialization'] ?? '',
      email: data?['email'] ?? '',
      password: data?['password'] ?? '',
      id: data?['id'] ?? '',
    );
  }

  factory DoctorModel.emptyDoctorModel() {
    return DoctorModel(
        profilepic: '',
        name: '',
        phone: '',
        gender: '',
        birthday: '',
        specialization: '',
        email: '',
        password: '',
        id: '');
  }
  Map<String, dynamic> toJson() {
    return {
      'profilepic': profilepic,
      'expcerft': expcerft,
      'name': name,
      'phone': phone,
      'gender': gender,
      'birthday': birthday,
      'specialization': specialization,
      'email': email,
      'password': password,
      'uid': id,
    };
  }
}
