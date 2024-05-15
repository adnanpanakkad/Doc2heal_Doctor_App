import 'package:doc2heal_doctor/controller/doctor_controller.dart';
import 'package:doc2heal_doctor/controller/signup_controller.dart';
import 'package:doc2heal_doctor/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final DoctorController doctorController = Get.put(
        DoctorController()); // Retrieve the existing instance of DoctrController

    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.05),
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(
                    'assets/Ellipse 1.png'), // Ensure this asset exists
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(doctorController.doctor.value.name!,
                  style: TextStyle(color: Colors.black)),
              SizedBox(
                  height: screenHeight *
                      0.02), // Added spacing between name and phone
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      doctorController.doctor.value.phone!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
