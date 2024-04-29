class DoctorModel {
  String? imagepath;
  String? expcerft;
  final String name;
  final String phone;
  final String gender;
  final String birthday;
  final String email;
  final String password;

  DoctorModel({
    required this.imagepath,
    this.expcerft,
    required this.name,
    required this.phone,
    required this.gender,
    required this.birthday,
    required this.email,
    required this.password,
  });

  // Factory constructor to create UserModel from JSON data
  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      imagepath: json['imagepath'],
      expcerft: json['expcerft'],
      name: json['name'],
      phone: json['phone'],
      gender: json['gender'],
      birthday: json['birthday'],
      email: json['email'],
      password: json['password'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'imagepath': imagepath,
      'expcerft': expcerft,
      'name': name,
      'phone': phone,
      'gender': gender,
      'birthday': birthday,
      'email': email,
      'password': password,
    };
  }
}
