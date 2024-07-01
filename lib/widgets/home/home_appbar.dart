import 'package:doc2heal_doctor/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        text,
        style: GoogleFonts.urbanist(color: Colors.black),
      ),
      toolbarHeight: 70,
      elevation: 0,
      backgroundColor: Appcolor.primaryColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
