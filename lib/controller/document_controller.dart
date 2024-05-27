import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DocumentController extends GetxController {
  
  final ImagePicker imagePicker = ImagePicker();
  var isexpcerftpathSet = false.obs;
  RxString expcerftpath = ''.obs;
  var imageUrl = ''.obs;
  documentPicker() async {
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      expcerftpath.value = pickedImage.path;
      isexpcerftpathSet.value = true;
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
    String? imageUrl;
    String uniqueName = DateTime.now().millisecond.toString();
    Reference firebaseRootReference = FirebaseStorage.instance.ref();
    Reference toUploadImgReference =
        firebaseRootReference.child('myCertf$uniqueName.png');
    try {
      await toUploadImgReference.putFile(File(image));
      imageUrl = await toUploadImgReference.getDownloadURL();
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }

    return imageUrl;
  }
}
