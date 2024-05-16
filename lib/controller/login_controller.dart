import 'package:doc2heal_doctor/screens/bottombar_screens.dart';
import 'package:doc2heal_doctor/services/firebase/authentication.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  GlobalKey<FormState> loginformKey = GlobalKey<FormState>();
  AuthenticationRepository authenticationRepository =
      Get.put(AuthenticationRepository());
  validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    } else if (!RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
        .hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  textFeildValidation(String value) {
    if (value.isEmpty) {
      return "Fill the field";
    } else {
      return null;
    }
  }

  loginDoctor() async {
    if (loginformKey.currentState!.validate()) {
      authenticationRepository.doctorLogin(
          emailController.text.toString(), passwordController.text.toString());
      Get.offAll(() => const BottombarScreens());
    } else {
      Get.snackbar('error', 'invalid password or email');
    }
  }
}
