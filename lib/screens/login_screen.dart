// ignore_for_file: use_build_context_synchronously

import 'package:doc2heal_doctor/screens/signup_screen.dart';
import 'package:doc2heal_doctor/utils/text_style.dart';
import 'package:doc2heal_doctor/widgets/rich_text.dart';
import 'package:doc2heal_doctor/widgets/text_feild.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 250,
                      height: 300,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/trendy-design-of-account-phishing-flat-illustration-vector.jpg'))),
                    ),
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Text(
                            "Login to your\nAccount",
                            style: CustomTextStyle.ultraBoldTextstyle,
                          ),
                        ),
                      ],
                    ),
                    CustomTextfield(
                        hintText: "Enter Your Email",
                        controller: emailController),
                    CustomTextfield(
                      hintText: "Enter Your Password",
                      controller: passwordController,
                    ),
                  ],
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
                        text: "Sign In",
                        onTap: () async {
                          // if (emailController.text.isNotEmpty &&
                          //     passwordController.text.isNotEmpty) {
                          //   User? user = await Repo.userSignin(
                          //       emailController.text.trim(),
                          //       passwordController.text.trim());
                          //   if (user != null) {
                          //     await Sharedpref.instence.addUserId(user.id!);
                          //     await Sharedpref.instence.setAuthDetaials(
                          //         emailController.text.trim(),
                          //         passwordController.text.trim());
                          //     FirebaseHelper.getFirebaseMessagingToken();
                          //     Navigator.of(context).push(MaterialPageRoute(
                          //       builder: (context) =>
                          //           CustomBottamSheet(user: user),
                          //     ));
                          //   } else {
                          //     Snacbar.authSnack(
                          //         "Failed to find user, Check your password and username",
                          //         context);
                          //   }
                          // } else {
                          //   Snacbar.authSnack("Fill all fields", context);
                          //const CoustomSnackbar(message: 'fill all colums');
                          //}
                        }),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SingupScreen(),
                        ));
                      },
                      child: richText(
                          context: context,
                          firstTxt: "Dont have an Account?  ",
                          secondTxt: "Sign-up"),
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
