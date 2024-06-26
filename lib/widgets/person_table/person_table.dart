import 'package:doc2heal_doctor/utils/app_color.dart';
import 'package:doc2heal_doctor/widgets/text_feildes.dart/detail_text_feilde.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonDetailTable extends StatelessWidget {
  const PersonDetailTable({super.key, required this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(44, 112, 112, 112),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 0),
            ),
          ],
        ),
        width: double.maxFinite,
        height: 250,
        child: Column(
          children: [
            SizedBox(
              // width: Get.height * .18,
              child: Column(
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
                  SizedBox(height: 20),
                  SizedBox(
                    child: Stack(
                      alignment: const Alignment(1, 1),
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/Ellipse 1.png'),
                          radius: 55,
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
                            onTap: onTap,
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
            ),
            const Expanded(
                child: SizedBox(
              child: Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Form(
                  key: null,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DetailTextfield(
                        text: "Full name",
                        //  controller: controller.nameController,
                        //  validator: (value) =>
                        // controller.textFeildValidation(value),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
