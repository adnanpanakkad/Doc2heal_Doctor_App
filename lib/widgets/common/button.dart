// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:doc2heal_doctor/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AutButton extends StatelessWidget {
  const AutButton({super.key, required this.text});
  final text;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          color: Appcolor.primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(50))),
      width: 270,
      height: 50,
      child: Text(text,
          style: GoogleFonts.urbanist(
              color: const Color.fromARGB(255, 76, 76, 76),
              fontSize: 16,
              fontWeight: FontWeight.w700)),
    );
  }
}
