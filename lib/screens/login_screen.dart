import 'package:doc2heal_doctor/screens/bottombar_screens.dart';
import 'package:doc2heal_doctor/screens/doctor_detailes_screen.dart';
import 'package:doc2heal_doctor/services/firebase/authentication.dart';
import 'package:doc2heal_doctor/services/netwok.dart';
import 'package:doc2heal_doctor/utils/text_style.dart';
import 'package:doc2heal_doctor/widgets/common/custom_button.dart';
import 'package:doc2heal_doctor/widgets/common/rich_text.dart';
import 'package:doc2heal_doctor/widgets/text_feildes.dart/text_feild.dart';
import 'package:doc2heal_doctor/utils/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 

  @override
  void initState() {
    super.initState();
    ConnectivityUtils.checkInternetConnectivity(context);
  }

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
                          validation: (value) => Validator.validateEmail(value),
                          hintText: "Enter Your Email",
                          controller: emailController),
                      CustomTextfield(
                        validation: (value) =>
                            Validator.validatePassword(value),
                        hintText: "Enter Your Password",
                        controller: passwordController,
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
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            String? uid =
                                await AuthenticationRepository().userEmailLogin(
                                    emailController.text.trim(),
                                    passwordController.text.trim());

                            // Login successful, handle navigation or any other actions
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => BottombarScreens()));
                          }
                        }),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DoctorDetails(),
                        ));
                      },
                      child: richText(
                          context: context,
                          firstTxt: "Don't have an account? ",
                          secondTxt:
                              "Uplod\n the information yours,and join\n the doctor Community"),
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
