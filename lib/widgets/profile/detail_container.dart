import 'package:doc2heal_doctor/controller/doctor_controller.dart';
import 'package:doc2heal_doctor/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailContainer extends StatelessWidget {
  DetailContainer({super.key});
  final DoctorController doctorController = Get.put(DoctorController());

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: Appcolor
              .primaryColor, // Use your primary color from app_color.dart
          borderRadius: BorderRadius.circular(20),
        ),
        height: screenHeight * 0.17,
        width: screenWidth * 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: CircleAvatar(
                radius: 50,
                // backgroundImage: NetworkImage(doctorController.doctor.value
                //     .profilepic!), // Assuming imageUrl is available in your Doctor model
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctorController.doctor.value.name!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    doctorController.doctor.value.email!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Assuming you have a phone field in your Doctor model
                  Text(
                    doctorController.doctor.value.phone!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
