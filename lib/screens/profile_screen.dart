import 'package:doc2heal_doctor/controller/doctor_controller.dart';
import 'package:doc2heal_doctor/screens/login_screen.dart';
import 'package:doc2heal_doctor/utils/text_style.dart';
import 'package:doc2heal_doctor/widgets/profile/detail_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:doc2heal_doctor/utils/app_color.dart'; // Assuming this is where your primary color is defined

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final DoctorController doctorController = Get.put(DoctorController());

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Settings',
                  style: CustomTextStyle.highboldTxtStyle,
                ),
                const SizedBox(height: 20),
                DetailContainer(),
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.black),
                  title: const Text('General Settings',
                      style: TextStyle(color: Colors.black)),
                  onTap: () {
                    // Handle tap on General Settings
                  },
                ),
                ListTile(
                  leading:
                      const Icon(Icons.person_outline, color: Colors.black),
                  title: const Text('Account Details',
                      style: TextStyle(color: Colors.black)),
                  onTap: () {
                    // Handle tap on Account Details
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.help_outline, color: Colors.black),
                  title: const Text('Help & Support',
                      style: TextStyle(color: Colors.black)),
                  onTap: () {
                    // Handle tap on Help & Support
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Get.offAll(
                        LoginScreen()); // Navigate back to login screen after signing out
                  },
                  child: const Text('Logout',
                      style: TextStyle(color: Appcolor.primaryColor)),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
