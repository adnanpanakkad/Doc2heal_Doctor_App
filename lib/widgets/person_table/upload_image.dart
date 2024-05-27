// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable
import 'dart:io';
import 'package:doc2heal_doctor/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadImage extends StatelessWidget {
  UploadImage({super.key, required this.text, required this.controller});

  final text;
  SignupController controller;
  SignupController signinController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          controller.imagepickerfun();
        },
        child: Obx(() => Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                  width: 350,
                  height: 350,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 195, 195, 195),
                      borderRadius: BorderRadius.circular(20)),
                  child: controller.isProfiepathSet.value == false
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Icon(
                                Icons.cloud_upload,
                                size: 50,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ])
                      : Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: FileImage(
                                      File(controller.expcerft.value)),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(20)),
                        )),
            )),
      ),
    );
  }
}
