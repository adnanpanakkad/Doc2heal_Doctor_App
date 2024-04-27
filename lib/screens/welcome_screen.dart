import 'package:doc2heal_doctor/screens/doctor_detailes_screen.dart';
import 'package:doc2heal_doctor/screens/login_screen.dart';
import 'package:doc2heal_doctor/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: double.maxFinite,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/beautiful-young-female-doctor-looking-camera-office_1301-7807.avif'),
                      fit: BoxFit.cover)),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(0, 255, 255, 255),
                    Color.fromARGB(125, 255, 255, 255),
                    Color.fromARGB(255, 255, 255, 255)
                  ],
                ),
              ),
              width: double.infinity,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.topLeft,
                    child: Text("Welcome to the\n driver app",
                        style: GoogleFonts.urbanist(
                            color: Color.fromARGB(255, 10, 2, 2),
                            fontSize: 36,
                            fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (ctx) => LoginScreen()));
                      },
                      child: const AutButton(text: 'Continue')),
                  const SizedBox(
                    height: 30,
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 109, 109, 109),
                    thickness: 0.5,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      // Get.to(SignUp());
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (ctx) => DoctorDetails()));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      alignment: Alignment.topLeft,
                      child: Text("Join doctors community",
                          style: GoogleFonts.urbanist(
                              color: const Color.fromARGB(255, 80, 80, 80),
                              fontSize: 20,
                              fontWeight: FontWeight.w700)),
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
