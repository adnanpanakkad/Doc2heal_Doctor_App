import 'dart:io';
import 'package:doc2heal_doctor/controller/document_controller.dart';
import 'package:doc2heal_doctor/model/doctor_model.dart';
import 'package:doc2heal_doctor/screens/bottombar_screens.dart';
import 'package:doc2heal_doctor/services/firebase/firestore.dart';
import 'package:doc2heal_doctor/utils/app_color.dart';
import 'package:doc2heal_doctor/utils/text_style.dart';
import 'package:doc2heal_doctor/widgets/appbar/appbar.dart';
import 'package:doc2heal_doctor/widgets/common/time_piker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DocumentDetails extends StatelessWidget {
  final DocumentController controller = Get.put(DocumentController());
  final DoctorRepository doctorRepository = Get.find();
  final DoctorModel doctor;
  DocumentDetails({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, 70),
        child: DeatialAppbar(
          text: 'Document Details',
          onTap: () => Get.back(),
        ),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Upload your Experience certificate',
                  style: CustomTextStyle.buttonTextStyle,
                ),
                const SizedBox(height: 20),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: controller.isexpcerftpathSet.value == false
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
                              File(controller.expcerftpath.value),
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.35,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 150, top: 110),
                      child: IconButton(
                        color: Colors.black,
                        onPressed: () => controller.documentPicker(),
                        icon: const Icon(
                          Icons.cloud_upload,
                          color: Colors.grey,
                          size: 50,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Choose your available times',
                  style: CustomTextStyle.buttonTextStyle,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TimeSlotPiker(
                        hintText: 'start time',
                        controller: controller.starttimeController,
                        validation: (value) =>
                            controller.textFieldValidation(value),
                        onTap: () => controller.pickStartTime(context),
                      ),
                    ),
                    SizedBox(width: 10), // Space between the two fields
                    Expanded(
                      child: TimeSlotPiker(
                        hintText: 'End time',
                        controller: controller.endtimeController,
                        validation: (value) =>
                            controller.textFieldValidation(value),
                        onTap: () => controller.pickEndTime(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Appcolor.primaryColor,
        onPressed: () async {
          if (controller.expcerftpath.value.isNotEmpty) {
            
            await doctorRepository.saveDoctorData(doctor, doctor.id!);
            Get.offAll(() => const BottombarScreens());
          } else {
            Get.snackbar(
              'Warning',
              'Please select an image',
              colorText: Colors.red,
            );
          }
        },
        label: const Row(
          children: [
            Text('Continue'),
            Icon(Icons.keyboard_arrow_right_outlined),
          ],
        ),
      ),
    );
  }
}
