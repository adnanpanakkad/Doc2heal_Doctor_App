import 'dart:developer';
import 'dart:io';
import 'package:doc2heal_doctor/model/doctor_model.dart';
import 'package:doc2heal_doctor/screens/document_detailes.dart';
import 'package:doc2heal_doctor/services/firebase/authentication.dart';
import 'package:doc2heal_doctor/services/firebase/firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class SignupController extends GetxController {
  //User data
  DoctorRepository doctorRepository = Get.put(DoctorRepository());
  AuthenticationRepository authenticationRepository =
      Get.put(AuthenticationRepository());
  GlobalKey<FormState> signupformKey = GlobalKey<FormState>();
  
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController specializController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController feesController = TextEditingController();

  final RxString profilepic = ''.obs;
  final RxString expcerft = ''.obs;
  final RxString name = ''.obs;
  final RxString phone = ''.obs;
  final RxString gender = ''.obs;
  final RxString birthday = ''.obs;
  final RxString specialization = ''.obs;
  final RxString email = ''.obs;
  final RxString password = ''.obs;

  final RxBool isLoading = false.obs;
//Authentication
  //gender handling
  RxString selectRepeat = 'None'.obs;
  final List<String> selectRepeatList = ['None', 'Male', 'Female'];
  selectGender(newvalue) {
    selectRepeat.value = newvalue;
    genderController.text = newvalue;
  }

//category
  RxString specializ = 'cardiology'.obs;
  final List<String> specializlist = [
    'Cardiology',
    'Neurology',
    'Gynecology',
    'Pediatrics',
    'Dental',
    'Ophthalmology',
  ];
  selectSpecializ(specializValue) {
    specializ.value = specializValue;
    specializController.text = specializValue;
  }

  Future<DoctorModel?> signup() async {
    if (signupformKey.currentState!.validate()) {
      try {
        isLoading.value = true;
        final userCredential = await authenticationRepository.doctorSignup(
            emailController.text, passwordController.text);

        final doctor = DoctorModel(
          doctorimg: profilepic.value,
          name: nameController.text.trim(),
          phone: phoneController.text.trim(),
          gender: genderController.text.trim(),
          birthday: birthController.text.trim(),
          specialization: specializController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          fees: feesController.text.trim(),
          id: userCredential,
        );

        await Get.to(() => DocumentDetails(doctor: doctor));

        return doctor;
      } catch (e) {
        // Handle error
        print("Error signing up: $e");
        return null;
      } finally {
        isLoading.value = false;
      }
    }
    return null;
  }

//validation
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

//Date time access
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  getTimeFromUser(BuildContext context) async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2030));

    if (pickerDate != null) {
      selectedDate.value = pickerDate;
      String date = DateFormat.yMd().format(selectedDate.value).toString();
      birthController.text = date;
    } else {}
  }

//image selector
  final ImagePicker imagePicker = ImagePicker();
  var isProfiepathSet = false.obs;
  RxString profilepicPath = ''.obs;
  var doctorimg = ''.obs;

  imagepickerfun() async {
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profilepicPath.value = pickedImage.path;
      isProfiepathSet.value = true;
      doctorimg.value = await getImageUrlfromFirebase(pickedImage.path) ?? '';
      if (doctorimg.value.isEmpty) {
        Get.snackbar(
          'Error',
          'Failed to retrieve image URL from Firebase',
          colorText: const Color.fromARGB(255, 255, 67, 67),
          snackPosition: SnackPosition.TOP,
        );
      } else {
        update();
      }
    } else {
      Get.snackbar(
        'Error',
        'Add photo is required',
        colorText: const Color.fromARGB(255, 255, 67, 67),
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  getImageUrlfromFirebase(String imagePath) async {
    String? imgurl;
    String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference firebaseRootReference = FirebaseStorage.instance.ref();
    Reference toUploadImgReference =
        firebaseRootReference.child('myPictures/$uniqueName.png');
    try {
      File file = File(imagePath);
      TaskSnapshot taskSnapshot = await toUploadImgReference.putFile(file);
      imgurl = await taskSnapshot.ref.getDownloadURL();
      log(imgurl);
      print("Download URL: $imgurl"); // Debug print to check URL
    } catch (e) {
      print("Error uploading image: $e"); // Debug print to check errors
    }
    return imgurl;
  }

  reset() {
    nameController.clear();
    phoneController.clear();
    genderController.clear();
    birthController.clear();
    specializController.clear();
    emailController.clear();
    passwordController.clear();
    feesController.clear();
    profilepicPath.value = '';
    isProfiepathSet.value = false;
  }
}
