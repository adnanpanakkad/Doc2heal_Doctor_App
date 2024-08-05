import 'package:doc2heal_doctor/screens/bottombar_screens.dart';
import 'package:doc2heal_doctor/services/firebase/authentication.dart';
import 'package:doc2heal_doctor/widgets/common/custom_snacbar.dart';
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
      try {
        String? loginSuccess = await authenticationRepository.doctorLogin(
            emailController.text, passwordController.text);
        if (loginSuccess != null) {
          Get.offAll(() => const BottombarScreens());
          emailController.clear();
          passwordController.clear();
        } else {
          CustomSnackbar.show(
              title: 'error',
              description: 'Something went wrong. Please try again later.',
              backgroundColor: Colors.red.shade600,
              icon: Icon(
                Icons.cancel_outlined,
                color: Colors.white,
              ));
        }
      } catch (e) {
        CustomSnackbar.show(
            title: 'Login Failed',
            description: 'The email or password you entered is incorrect',
            backgroundColor: Colors.red.shade600,
            icon: Icon(
              Icons.error,
              color: Colors.white,
            ));
      }
    } else {
      CustomSnackbar.show(
          title: 'error',
          description: 'Please enter valid credentials',
          backgroundColor: Colors.red.shade600,
          icon: Icon(
            Icons.cancel_outlined,
            color: Colors.white,
          ));
    }
  }
}
