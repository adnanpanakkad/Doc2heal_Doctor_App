import 'dart:developer';
import 'package:doc2heal_doctor/controller/signup_controller.dart';
import 'package:doc2heal_doctor/model/doctor_model.dart';
import 'package:doc2heal_doctor/services/firebase/authentication.dart';
import 'package:doc2heal_doctor/services/firebase/firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorController extends GetxController {
  // static UserController get instance => Get.find();
  Rx<DoctorModel> doctor = DoctorModel.emptyDoctorModel().obs;
  SignupController signupController = Get.put(SignupController());

  @override
  void onReady() async {
    await getDoctorRecord();
    signupController.nameController.text = doctor.value.name!;
    signupController.phoneController.text = doctor.value.phone!;
    super.onReady();
  }

  Future<void> getDoctorRecord() async {
    try {
      var authenticationRepository = Get.put(AuthenticationRepository());

      final authUser = authenticationRepository.authUser;
      var userRepository = Get.put(DoctorRepository());

      if (authUser != null) {
        final doctorId = await userRepository
            .getDoctorDetails(authenticationRepository.authUser!.uid);
      }
    } catch (e) {
      // doctor(DoctorModel.emptyDoctorModel);
      log("getUserRecord failed");
      log(e.toString());
    }
  }

  // Future<void> updateUser() async {
  //   try {
  //     var userModel = UserModel(
  //         name: name.text,
  //         number: number.text,
  //         email: user.value.email,
  //         profile: user.value.profile,
  //         isUser: user.value.isUser);
  //     await UserRepository().updateUserField(userMdel: userModel);
  //     user.value = userModel;
  //   } catch (e) {
  //     log('updateUser:$e');
  //     CustomSnackbar.showError(e.toString());
  //   }
  // }
}
