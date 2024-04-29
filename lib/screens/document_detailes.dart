import 'dart:io';

import 'package:doc2heal_doctor/model/doctor_model.dart';
import 'package:doc2heal_doctor/screens/bottombar_screens.dart';
import 'package:doc2heal_doctor/screens/doctor_detailes_screen.dart';
import 'package:doc2heal_doctor/services/firebase/authentication.dart';
import 'package:doc2heal_doctor/services/firebase/firestore.dart';
import 'package:doc2heal_doctor/utils/app_color.dart';
import 'package:doc2heal_doctor/utils/text_style.dart';
import 'package:doc2heal_doctor/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class DocumentDetailes extends StatefulWidget {
  String? imagepath;
  String? expcerft;
  final String name;
  final String phone;
  final String gender;
  final String birthday;
  final String email;
  final String password;

  DocumentDetailes({
    required this.imagepath,
    this.expcerft,
    required this.name,
    required this.phone,
    required this.gender,
    required this.birthday,
    required this.email,
    required this.password,
  });

  @override
  State<DocumentDetailes> createState() => _DocumentDetailesState();
}

final GlobalKey<FormState> formKey = GlobalKey<FormState>();
File? seletedImage;

class _DocumentDetailesState extends State<DocumentDetailes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.maxFinite, 70),
          child: DeatialAppbar(
            text: 'Document Details',
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => DoctorDetails())),
          )),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Experience certificate',
                style: CustomTextStyle.buttonTextStyle),
            SizedBox(height: 20),
            Container(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: seletedImage == null
                        ? Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                          )
                        : Image.file(
                            seletedImage!,
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.35,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 150, top: 110),
                    child: IconButton(
                      color: Colors.black,
                      onPressed: () {
                        imagepicker();
                      },
                      icon: Icon(Icons.add), // Corrected icon usage
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Appcolor.primaryColor,
        onPressed: () async {
          DoctorModel doctor = DoctorModel(
            imagepath: widget.imagepath,
            expcerft: seletedImage!.path,
            name: widget.name,
            phone: widget.phone,
            gender: widget.gender,
            birthday: widget.birthday,
            email: widget.email,
            password: widget.password,
          );
         
          await DoctorRepository().saveDoctorData(doctor, '0');
          if (seletedImage != null) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const BottombarScreens(),
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text('Certificate not added'),
            ));
          }
        },
        label: const SizedBox(
          child: Row(
            children: [
              Text('Continue'),
              Icon(Icons.keyboard_arrow_right_outlined)
            ],
          ),
        ),
      ),
    );
  }

  Future imagepicker() async {
    final pikedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pikedImage == null) return;
    setState(() {
      seletedImage = File(pikedImage.path);
    });
  }
}
