import 'package:doc2heal_doctor/controller/login_controller.dart';
import 'package:doc2heal_doctor/screens/signup_screen.dart';
import 'package:doc2heal_doctor/utils/text_style.dart';
import 'package:doc2heal_doctor/widgets/common/custom_button.dart';
import 'package:doc2heal_doctor/widgets/common/rich_text.dart';
import 'package:doc2heal_doctor/widgets/text_feildes.dart/text_feild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginController controller = Get.put(LoginController());
  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 250,
                        height: 300,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/trendy-design-of-account-phishing-flat-illustration-vector.jpg',
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        child: Text(
                          "Login to your\nAccount",
                          style: CustomTextStyle.ultraBoldTextstyle,
                        ),
                      ),
                      CustomTextfield(
                        validation: (value) => controller.validateEmail(value),
                        hintText: "Enter Your Email",
                        controller: controller.emailController,
                      ),
                      CustomTextfield(
                        validation: (value) =>
                            controller.validatePassword(value),
                        hintText: "Enter Your Password",
                        controller: controller.passwordController,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      text: "Sign In",
                      onTap: () {
                        controller.loginDoctor();
                      },
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => SignupScreen());
                      },
                      child: richText(
                        context: context,
                        firstTxt: "Don't have an account? ",
                        secondTxt: "create your account",
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
