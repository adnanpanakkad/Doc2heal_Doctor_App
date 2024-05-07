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
  final String? uid;

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
    required this.uid,
  });

  // Factory constructor to create UserModel from JSON data
  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      profilepic: json['profilepic'],
      expcerft: json['expcerft'],
      name: json['name'],
      phone: json['phone'],
      gender: json['gender'],
      birthday: json['birthday'],
      specialization: json['specialization'],
      email: json['email'],
      password: json['password'],
      uid: json['uid'],
    );
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
      'uid': uid,
    };
  }
}
