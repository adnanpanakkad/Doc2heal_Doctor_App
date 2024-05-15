import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc2heal_doctor/model/doctor_model.dart';
import 'package:doc2heal_doctor/screens/document_detailes.dart';
import 'package:doc2heal_doctor/services/firebase/authentication.dart';
import 'package:doc2heal_doctor/services/firebase/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class SignupController extends GetxController {
  //User data
  GlobalKey<FormState> signupformKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController specializController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
  ];
  selectSpecializ(specializValue) {
    specializ.value = specializValue;
    specializController.text = specializValue;
  }

  Future<DoctorModel?> signup() async {
    if (signupformKey.currentState!.validate()) {
      try {
        isLoading.value = true;
        final UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        final doctor = DoctorModel(
          profilepic: profilepic.value,
          name: nameController.text.trim(),
          phone: phoneController.text.trim(),
          gender: genderController.text.trim(),
          birthday: birthController.text.trim(),
          specialization: specializController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          uid: userCredential.user!.uid,
        );
        await DoctorRepository().saveDoctorData(doctor);
        Get.to(() => DocumentDetails(doctor: doctor));
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
  var isexpcerftpathSet = false.obs;
  RxString profilepicPath = ''.obs;
  RxString expcerftpath = ''.obs;
  var imageUrl = ''.obs;
  imagepicker() async {
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profilepicPath.value = pickedImage.path;
      isProfiepathSet.value = true;
      imageUrl.value = await getImageUrlfromFirebase(pickedImage.path);
      update();
    } else {
      Get.snackbar(
        'Somthing Error',
        'Add photo its required',
        colorText: const Color.fromARGB(255, 255, 67, 67),
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  getImageUrlfromFirebase(String image) async {
    String? url;
    String uniqueName = DateTime.now().millisecond.toString();
    Reference firebaseRootReference = FirebaseStorage.instance.ref();
    Reference toUploadImgReference =
        firebaseRootReference.child('myPic$uniqueName.png');
    try {
      await toUploadImgReference.putFile(File(image));
      url = await toUploadImgReference.getDownloadURL();
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }

    return url;
  }

}
