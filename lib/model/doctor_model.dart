import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  final String? doctorimg;
  final String? expcerft;
  final String? name;
  final String? phone;
  final String? gender;
  final String? birthday;
  final String? specialization;
  final String? email;
  final String? password;
  final String? fees;
  final String? starttime;
  final String? endtime;
  late final String? id;

  DoctorModel({
    required this.doctorimg,
    this.expcerft,
    required this.name,
    required this.phone,
    required this.gender,
    required this.birthday,
    required this.specialization,
    required this.email,
    required this.password,
    required this.fees,
    this.starttime,
    this.endtime,
    required this.id,
  });

  // Factory constructor to create UserModel from JSON data

  factory DoctorModel.fromSnapshot(DocumentSnapshot<Object?> snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    return DoctorModel(
      doctorimg: data?['doctorimg'] ?? '',
      expcerft: data?['expcerft'] ?? '',
      name: data?['name'] ?? '',
      phone: data?['phone'] ?? '',
      gender: data?['gender'] ?? '',
      birthday: data?['birthday'] ?? '',
      specialization: data?['specialization'] ?? '',
      email: data?['email'] ?? '',
      password: data?['password'] ?? '',
      fees: data?['fees'] ?? '',
      starttime: data?['starttime'] ?? '',
      endtime: data?['endtime'] ?? '',
      id: data?['id'] ?? '',
    );
  }

  factory DoctorModel.emptyDoctorModel() {
    return DoctorModel(
        doctorimg: '',
        name: '',
        phone: '',
        gender: '',
        birthday: '',
        specialization: '',
        email: '',
        password: '',
        fees: '',
        starttime: '',
        endtime: '',
        id: '');
  }
  Map<String, dynamic> toJson() {
    return {
      'doctorimg': doctorimg,
      'expcerft': expcerft,
      'name': name,
      'phone': phone,
      'gender': gender,
      'birthday': birthday,
      'specialization': specialization,
      'email': email,
      'password': password,
      'fees': fees,
      'starttime': starttime,
      'endtime': endtime,
      'uid': id,
    };
  }
}
