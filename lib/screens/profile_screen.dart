import 'package:doc2heal_doctor/controller/doctor_controller.dart';
import 'package:doc2heal_doctor/screens/login_screen.dart';
import 'package:doc2heal_doctor/utils/text_style.dart';
import 'package:doc2heal_doctor/widgets/common/custom_popup.dart';
import 'package:doc2heal_doctor/widgets/profile/detail_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doc2heal_doctor/utils/app_color.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
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
                const SizedBox(height: 30),

                Text('General', style: CustomTextStyle.buttonTextStyle),
                ListTile(
                  leading: const Icon(Icons.assignment_outlined,
                      color: Colors.black),
                  title: const Text('Terms & conditions',
                      style: TextStyle(color: Colors.black)),
                  onTap: () {
                    // Handle tap on General Settings
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.admin_panel_settings_outlined,
                      color: Colors.black),
                  title: const Text('Privecy & Policy',
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
                const SizedBox(height: 30),

                Text('Account', style: CustomTextStyle.buttonTextStyle),
                ListTile(
                  leading:
                      const Icon(Icons.person_outline, color: Colors.black),
                  title: const Text('profile',
                      style: TextStyle(color: Colors.black)),
                  onTap: () {
                    // Handle tap on Help & Support
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text('Logout',
                      style: TextStyle(color: Colors.black)),
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomPopup(
                          onTap: () async {
                            await FirebaseAuth.instance.signOut();
                            Get.offAll(LoginScreen());
                          },
                        );
                      },
                    );
                  },
                ),
                // ElevatedButton(
                //   onPressed: () async {
                //     showDialog(
                //       context: context,
                //       builder: (BuildContext context) {
                //         return CustomPopup(
                //           onTap: () async {
                //             await FirebaseAuth.instance.signOut();
                //             Get.offAll(LoginScreen());
                //           },
                //         );
                //       },
                //     );
                //   },
                //   style:
                //       ElevatedButton.styleFrom(backgroundColor: Colors.white),
                //   child: const Text('Logout',
                //       style: TextStyle(color: Appcolor.primaryColor)),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
