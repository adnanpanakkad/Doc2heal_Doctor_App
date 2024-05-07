import 'dart:io';
import 'package:doc2heal_doctor/controller/signup_controller.dart';
import 'package:doc2heal_doctor/screens/bottombar_screens.dart';
import 'package:doc2heal_doctor/screens/signup_screen.dart';
import 'package:doc2heal_doctor/utils/app_color.dart';
import 'package:doc2heal_doctor/utils/text_style.dart';
import 'package:doc2heal_doctor/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DocumentDetails extends StatelessWidget {
  final SignupController controller = Get.find<SignupController>();

  DocumentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, 70),
        child: DeatialAppbar(
          text: 'Document Details',
          onTap: () => Get.off(() => SignupScreen()),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Experience certificate',
                style: CustomTextStyle.buttonTextStyle),
            const SizedBox(height: 20),
            Obx(
              () => Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: controller.profilepicPath.value.isEmpty
                        ? Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                          )
                        : Image.file(
                            File(controller.expcerft.value),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.35,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 150, top: 110),
                    child: IconButton(
                      color: Colors.black,
                      onPressed: () => controller.imagepicker(),
                      icon: const Icon(Icons.add),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Appcolor.primaryColor,
        onPressed: () async {
          if (controller.profilepicPath.value.isNotEmpty) {
            Get.offAll(() => BottombarScreens());
          } else {
            Get.snackbar('Warning', 'Please select an image');
          }
        },
        label: const SizedBox(
          child: Row(
            children: [
              Text('Continue'),
              Icon(Icons.keyboard_arrow_right_outlined)
            ],
          ),
        ),
      ),
    );
  }
}
