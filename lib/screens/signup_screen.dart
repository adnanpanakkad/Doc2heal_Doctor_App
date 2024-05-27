import 'dart:io';
import 'package:doc2heal_doctor/controller/signup_controller.dart';
import 'package:doc2heal_doctor/screens/document_detailes.dart';
import 'package:doc2heal_doctor/screens/login_screen.dart';
import 'package:doc2heal_doctor/screens/welcome_screen.dart';
import 'package:doc2heal_doctor/utils/app_color.dart';
import 'package:doc2heal_doctor/widgets/appbar/appbar.dart';
import 'package:doc2heal_doctor/widgets/person_table/detail_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final DateTime _selectedDate = DateTime.now();
  final SignupController controller =
      Get.put<SignupController>(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: PreferredSize(
          preferredSize: const Size(double.maxFinite, 70),
          child: DeatialAppbar(
            text: 'Doctor Details',
            onTap: () => Get.to(() => LoginScreen()),
          )),
      body: Obx(
        () => ListView(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Form(
                key: controller.signupformKey,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Color.fromARGB(255, 254, 254, 254),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(44, 112, 112, 112),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(5, 10),
                      ),
                    ],
                  ),
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              'Add your profile',
                              style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            child: Stack(
                              alignment: const Alignment(1, 1),
                              children: [
                                CircleAvatar(
                                  radius: 55,
                                  backgroundImage: controller
                                              .isProfiepathSet.value ==
                                          false
                                      ? const AssetImage('assets/Ellipse 1.png')
                                      : FileImage(File(
                                              controller.profilepicPath.value))
                                          as ImageProvider,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 5,
                                        blurRadius: 10,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      controller.imagepickerfun();
                                    },
                                    child: const CircleAvatar(
                                      radius: 20,
                                      backgroundColor:
                                          Color.fromARGB(255, 229, 229, 229),
                                      child: Icon(
                                        Icons.add,
                                        color: Appcolor.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      DetailTile(
                        validator: (value) =>
                            controller.textFeildValidation(value),
                        keyboardType: TextInputType.emailAddress,
                        controllers: controller.nameController,
                        sub: 'full name',
                        hittext: 'Enter your full name',
                      ),
                      DetailTile(
                        validator: (value) =>
                            controller.textFeildValidation(value),
                        keyboardType: TextInputType.number,
                        controllers: controller.phoneController,
                        sub: 'Phone number',
                        hittext: 'Enter your phone number',
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      DetailTile(
                        validator: (value) =>
                            controller.textFeildValidation(value),
                        controllers: controller.genderController,
                        sub: 'Gender',
                        hittext: controller.selectRepeat.value,
                        suffixicon: DropdownButton(
                          icon: const Icon(Icons.arrow_drop_down),
                          iconDisabledColor:
                              const Color.fromARGB(252, 103, 103, 103),
                          items: controller.selectRepeatList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value.toString(),
                              child: Text(value.toString()),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            controller.selectGender(newValue!);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      DetailTile(
                        validator: (value) =>
                            controller.textFeildValidation(value),
                        controllers: controller.birthController,
                        sub: 'Birthday',
                        hittext:
                            DateFormat.yMd().format(_selectedDate).toString(),
                        suffixicon: IconButton(
                            onPressed: () {
                              controller.getTimeFromUser(context);
                            },
                            icon: const Icon(Icons.calendar_month)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      DetailTile(
                        validator: (value) =>
                            controller.textFeildValidation(value),
                        controllers: controller.specializController,
                        sub: 'specialization',
                        hittext: controller.specializ.value,
                        suffixicon: DropdownButton<String>(
                          icon: const Icon(Icons.arrow_drop_down),
                          iconDisabledColor:
                              const Color.fromARGB(252, 103, 103, 103),
                          items: controller.specializlist
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? specializValue) {
                            controller.selectSpecializ(specializValue);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      DetailTile(
                        validator: (value) => controller.validateEmail(value),
                        keyboardType: TextInputType.emailAddress,
                        controllers: controller.emailController,
                        sub: 'Email',
                        hittext: 'Enter your email address',
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      DetailTile(
                        validator: (value) =>
                            controller.validatePassword(value),
                        keyboardType: TextInputType.emailAddress,
                        controllers: controller.passwordController,
                        sub: 'Password',
                        hittext: 'Enter your Password',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Appcolor.primaryColor,
        onPressed: () async {
          controller.signup();
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
