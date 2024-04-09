import 'package:doc2heal_doctor/screens/signup_screen.dart';
import 'package:doc2heal_doctor/screens/welcome_screen.dart';
import 'package:doc2heal_doctor/utils/text_style.dart';
import 'package:doc2heal_doctor/widgets/custom_button.dart';
import 'package:doc2heal_doctor/widgets/rich_text.dart';
import 'package:doc2heal_doctor/widgets/text_feild.dart';
import 'package:doc2heal_doctor/widgets/validator.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    checkInternetConnectivity();
  }

  void checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("No Internet Connection"),
            content:
                Text("Please check your internet connection and try again."),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
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
                        onTap: () {
                          if (formKey.currentState!.validate()) {
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
                            // const CoustomSnackbar(message: 'fill all colums');
                          }
                        }),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => WelcomeScreen(),
                        ));
                      },
                      child: richText(
                          context: context,
                          firstTxt: "Don't have an account? ",
                          secondTxt:
                              "Uplod\n the information yours,and join\n the driver Community"),
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
