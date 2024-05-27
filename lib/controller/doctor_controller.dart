import 'dart:developer';
import 'package:doc2heal_doctor/controller/signup_controller.dart';
import 'package:doc2heal_doctor/model/doctor_model.dart';
import 'package:doc2heal_doctor/services/firebase/authentication.dart';
import 'package:doc2heal_doctor/services/firebase/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DoctorController extends GetxController {
  Rx<DoctorModel> doctor = DoctorModel.emptyDoctorModel().obs;
  final name = TextEditingController();
  final email = TextEditingController();
  Image? image;

  SignupController signupController = Get.put(SignupController());
  DoctorRepository doctorRepository = Get.put(DoctorRepository());
  AuthenticationRepository authenticationRepository =
      Get.put(AuthenticationRepository());

  @override
  void onReady() async {
    await getDoctorRecord();
    name.text = doctor.value.name!;
    email.text = doctor.value.email!;
    image = doctor.value.doctorimg as Image;
    super.onReady();
  }

  Future<void> getDoctorRecord() async {
    try {
      final authUser = authenticationRepository.authUser;

      if (authUser != null) {
        final doctordata =
            await doctorRepository.getDoctorDetails(authUser.uid);
        final doctorModel = DoctorModel.fromSnapshot(
            doctordata); // Convert DocumentSnapshot to DoctorModel
        doctor(doctorModel);
      }
    } catch (e) {
      doctor(DoctorModel.emptyDoctorModel());
      log("getUserRecord failed");
      log(e.toString());
    }
  }
}
