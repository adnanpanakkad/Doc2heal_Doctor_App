// ignore_for_file: use_build_context_synchronously
import 'package:doc2heal_doctor/utils/text_style.dart';
import 'package:doc2heal_doctor/widgets/custom_button.dart';
import 'package:doc2heal_doctor/widgets/rich_text.dart';
import 'package:doc2heal_doctor/widgets/text_feild.dart';
import 'package:doc2heal_doctor/widgets/validator.dart';

import 'package:flutter/material.dart';

class SingupScreen extends StatelessWidget {
  SingupScreen({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 250,
                        height: 300,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/image.png'))),
                      ),
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: Text(
                              "Create your\nAccount",
                              style: CustomTextStyle.ultraBoldTextstyle,
                            ),
                          ),
                        ],
                      ),
                      CustomTextfield(
                          validation: (value) => Validator.validateEmail(value),
                          controller: emailController,
                          hintText: "Enter Your Email"),
                      CustomTextfield(
                          validation: (value) =>
                              Validator.validatePassword(value),
                          controller: passwordController,
                          hintText: "Enter Your Password"),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 150,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                        text: "Sign up",
                        onTap: () async {
                          // if (formKey.currentState!.validate()) {
                          //   await Sharedpref.instence.setAuthDetaials(
                          //       emailController.text.trim(),
                          //       passwordController.text.trim());

                          //   Navigator.of(context)
                          //       .pushReplacement(MaterialPageRoute(
                          //     builder: (context) => UserDetailsScreen(),
                          //   ));
                          // }
                        }),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: richText(
                          context: context,
                          firstTxt: "Already have an Account?  ",
                          secondTxt: "Login"),
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
