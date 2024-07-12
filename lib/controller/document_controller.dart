import 'dart:developer';
import 'dart:io';
import 'package:doc2heal_doctor/model/doctor_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DocumentController extends GetxController {
  GlobalKey<FormState> timeKey = GlobalKey<FormState>();

  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController starttimeController = TextEditingController();
  final TextEditingController endtimeController = TextEditingController();

  final ImagePicker imagePicker = ImagePicker();

  RxString starttime = ''.obs;
  RxString endtime = ''.obs;
  var isexpcerftpathSet = false.obs;
  RxString expcerftpath = ''.obs;
  var expcerftUrl = ''.obs;

  documentPicker() async {
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      expcerftpath.value = pickedImage.path;
      isexpcerftpathSet.value = true;
      expcerftUrl.value = await getImageUrlfromFirebase(pickedImage.path);
      update();
    } else {
      Get.snackbar(
        'Something Error',
        'Add photo its required',
        colorText: const Color.fromARGB(255, 255, 67, 67),
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  textFieldValidation(String value) {
    if (value.isEmpty) {
      return "Fill the field";
    } else {
      return null;
    }
  }

  var selectedStartTime = TimeOfDay.now().obs;
  var selectedEndTime = TimeOfDay.now().obs;

  void pickStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime.value,
    );
    if (picked != null && picked != selectedStartTime.value) {
      selectedStartTime.value = picked;
      starttimeController.text = picked.format(context);
    }
  }

  void pickEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedEndTime.value,
    );
    if (picked != null && picked != selectedEndTime.value) {
      selectedEndTime.value = picked;
      endtimeController.text = picked.format(context);
    }
  }


  getImageUrlfromFirebase(String image) async {
    String? expcerftUrl;
    String uniqueName = DateTime.now().millisecond.toString();
    Reference firebaseRootReference = FirebaseStorage.instance.ref();
    Reference toUploadImgReference =
        firebaseRootReference.child('myCertf$uniqueName.png');
    try {
      await toUploadImgReference.putFile(File(image));
      expcerftUrl = await toUploadImgReference.getDownloadURL();
      log(expcerftUrl);
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
    return expcerftUrl;
  }

  validateTimefieldes() async {
    if (timeKey.currentState!.validate()) {}
  }

  void showCustomSnackbar() {
    Get.snackbar(
      'Profile updated', 
      'Your profile has been successfully updated.', 
      snackPosition: SnackPosition.TOP, 
      backgroundColor:
          Colors.green.withOpacity(0.8), 
      colorText: Colors.white, 
      borderRadius: 8, 
      margin: const EdgeInsets.all(10), 
      icon: const Icon(
        Icons.check_circle,
        color: Colors.white,
        size: 28,
      ), 
      shouldIconPulse: false, 
      boxShadows: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ], 
      duration: const Duration(seconds: 3), 
      isDismissible: true, 
      snackStyle: SnackStyle.FLOATING, 
    );
  }
}
