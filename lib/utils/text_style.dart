import 'package:doc2heal_doctor/utils/app_color.dart';
import 'package:flutter/material.dart';

class CustomTextStyle {
  static const TextStyle buttonTextStyle = TextStyle(
      fontSize: 17, fontWeight: FontWeight.w600, fontFamily: "Urbanist");

  static const TextStyle highboldTxtStyle = TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w600,
      fontFamily: 'Urbanist',
      color: Color.fromARGB(255, 53, 53, 53));

  static const TextStyle swipeTextStyle = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      fontFamily: "Urbanist",
      color: Appcolor.primaryColor);

  static const TextStyle ultraBoldTextstyle = TextStyle(
      fontSize: 35, fontFamily: 'Urbanist', fontWeight: FontWeight.bold);

  static const TextStyle textFieldstyle = TextStyle(
      color: Color.fromARGB(255, 157, 157, 157),
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: "Urbanist");
}
