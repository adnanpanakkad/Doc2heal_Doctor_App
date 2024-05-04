import 'dart:io';
import 'package:doc2heal_doctor/model/doctor_model.dart';
import 'package:doc2heal_doctor/screens/bottombar_screens.dart';
import 'package:doc2heal_doctor/screens/doctor_detailes_screen.dart';
import 'package:doc2heal_doctor/services/firebase/firestore.dart';
import 'package:doc2heal_doctor/utils/app_color.dart';
import 'package:doc2heal_doctor/utils/text_style.dart';
import 'package:doc2heal_doctor/widgets/appbar/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class DocumentDetailes extends StatefulWidget {
  String? imagepath;
  String? expcerft;
  final String name;
  final String phone;
  final String gender;
  final String birthday;
  final String specialization;
  final String email;
  final String password;
  String? uid;

  DocumentDetailes({
    super.key,
    required this.imagepath,
    this.expcerft,
    required this.name,
    required this.phone,
    required this.gender,
    required this.birthday,
    required this.specialization,
    required this.email,
    required this.password,
    this.uid,
  });

  @override
  State<DocumentDetailes> createState() => _DocumentDetailesState();
}

final GlobalKey<FormState> formKey = GlobalKey<FormState>();
File? _image;
String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

class _DocumentDetailesState extends State<DocumentDetailes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.maxFinite, 70),
          child: DeatialAppbar(
            text: 'Document Details',
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const DoctorDetails())),
          )),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Experience certificate',
                style: CustomTextStyle.buttonTextStyle),
            const SizedBox(height: 20),
            Container(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: _image == null
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
                            _image!,
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
                        pickAndUploadImage(context);
                      },
                      icon: const Icon(Icons.add), // Corrected icon usage
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
          if (_image != null) {
            DoctorModel doctor = DoctorModel(
              imagepath: widget.imagepath,
              expcerft: _image!.path, // This line was causing the error
              name: widget.name,
              phone: widget.phone,
              gender: widget.gender,
              birthday: widget.birthday,
              specialization: widget.specialization,
              email: widget.email,
              password: widget.password,
              uid: widget.uid,
            );
            await DoctorRepository().saveDoctorData(doctor);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const BottombarScreens(),
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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

  Future<String?> pickAndUploadImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });

      // Upload the image to Firebase Storage
      final ref = FirebaseStorage.instance
          .ref()
          .child('images/${_image!.path.split('/').last}');
      await ref.putFile(_image!);

      // Retrieve the image URL
      final url = await ref.getDownloadURL();
      print('Image URL: $url');

      // Store the image URL in Firestore
      // final firestore = FirebaseFirestore.instance;
      // await firestore.doc('0').set(im

      // )

      // return url;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected.')),
      );
      print('No image selected.');
      return null;
    }
    return null;
  }
}
