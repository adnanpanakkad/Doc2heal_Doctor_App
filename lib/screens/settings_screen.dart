import 'package:doc2heal_doctor/screens/profile/help_support_screen.dart';
import 'package:doc2heal_doctor/screens/login_screen.dart';
import 'package:doc2heal_doctor/screens/profile/privecy_policy_screen.dart';
import 'package:doc2heal_doctor/screens/profile/profile_screen.dart';
import 'package:doc2heal_doctor/screens/profile/terms_conditions_screen.dart';
import 'package:doc2heal_doctor/utils/text_style.dart';
import 'package:doc2heal_doctor/widgets/common/custom_popup.dart';
import 'package:doc2heal_doctor/widgets/profile/detail_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  final String uid;
  final Map<String, dynamic> userData;
  const SettingsScreen({
    super.key,
    required this.uid,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Settings',
                  style: CustomTextStyle.highboldTxtStyle,
                ),
                const SizedBox(height: 10),
                StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasData && snapshot.data != null) {
                      return const DetailContainer();
                    } else {
                      return const Text('User not logged in');
                    }
                  },
                ),
                const SizedBox(height: 30),
                const Text('General', style: CustomTextStyle.buttonTextStyle),
                ListTile(
                  leading: const Icon(Icons.admin_panel_settings_outlined,
                      color: Colors.black),
                  title: const Text('Privacy & Policy',
                      style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyScreen()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.assignment_outlined,
                      color: Colors.black),
                  title: const Text('Terms & conditions',
                      style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const TermsAndConditionsScreen()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.help_outline, color: Colors.black),
                  title: const Text('Help & Support',
                      style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HelpandSupport()));
                  },
                ),
                const SizedBox(height: 30),
                const Text('Account', style: CustomTextStyle.buttonTextStyle),
                ListTile(
                  leading:
                      const Icon(Icons.person_outline, color: Colors.black),
                  title: const Text('Profile',
                      style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfileScreen()));
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
                            Get.offAll(() => LoginScreen());
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
