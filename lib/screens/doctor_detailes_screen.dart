import 'dart:io';

import 'package:doc2heal_doctor/screens/bottombar_screens.dart';
import 'package:doc2heal_doctor/screens/chat_screen.dart';
import 'package:doc2heal_doctor/utils/app_color.dart';
import 'package:doc2heal_doctor/widgets/appbar/appbar.dart';
import 'package:doc2heal_doctor/widgets/person_table/detail_tile.dart';
import 'package:doc2heal_doctor/widgets/validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({super.key});

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  String? selectedGender;
  File? seletedImage;
  final DateTime _selectedDate = DateTime.now();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _birthController = TextEditingController();
  TextEditingController _experienceController = TextEditingController();
  TextEditingController _hospitalController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void selectGender(String? newValue) {
    setState(() {
      selectedGender = newValue ?? 'None';
      _genderController.text = selectedGender!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: const PreferredSize(
          preferredSize: Size(double.maxFinite, 70),
          child: DeatialAppbar(text: 'Doctor Details')),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color.fromARGB(255, 254, 254, 254),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(44, 112, 112, 112),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(5, 10),
                    ),
                  ],
                ),
                width: double.maxFinite,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
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
                                radius: 55,
                                backgroundImage: seletedImage == null
                                    ? const AssetImage('assets/Ellipse 1.png')
                                    : FileImage(seletedImage!) as ImageProvider,
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
                                  onTap: imagepicker,
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
                    SizedBox(height: 20),
                    DetailTile(
                      validator: (value) =>
                          Validator().textFeildValidation(value),
                      keyboardType: TextInputType.emailAddress,
                      controllers: _nameController,
                      sub: 'full name',
                      hittext: 'Enter your full name',
                    ),
                    DetailTile(
                      validator: (value) =>
                          Validator().textFeildValidation(value),
                      keyboardType: TextInputType.number,
                      controllers: _phoneController,
                      sub: 'Phone number',
                      hittext: 'Enter your phone number',
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    DetailTile(
                      validator: (value) =>
                          Validator().textFeildValidation(value),
                      controllers: _genderController,
                      sub: 'Gender',
                      hittext: "select gender",
                      suffixicon: DropdownButton(
                          value: selectedGender,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconDisabledColor:
                              const Color.fromARGB(252, 103, 103, 103),
                          items: [
                            "Male",
                            "Female",
                            "Other"
                          ] // Update options here
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: selectGender),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    DetailTile(
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          Validator().textFeildValidation(value),
                      controllers: _birthController,
                      sub: 'Birthday',
                      hittext: "Enter your Birthday",
                      suffixicon: IconButton(
                          onPressed: () {
                            // controller.getTimeFromUser(context);
                          },
                          icon: const Icon(Icons.calendar_month)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    DetailTile(
                      validator: (value) =>
                          Validator().textFeildValidation(value),
                      keyboardType: TextInputType.number,
                      controllers: _experienceController,
                      sub: 'Experience',
                      hittext: 'Enter your Experience',
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    DetailTile(
                      validator: (value) =>
                          Validator().textFeildValidation(value),
                      keyboardType: TextInputType.emailAddress,
                      controllers: _hospitalController,
                      sub: 'Hospital',
                      hittext: 'Enter your Hospital',
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    DetailTile(
                      validator: (value) =>
                          Validator().textFeildValidation(value),
                      keyboardType: TextInputType.emailAddress,
                      controllers: _emailController,
                      sub: 'Email',
                      hittext: 'Enter your email address',
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    DetailTile(
                      validator: (value) =>
                          Validator().textFeildValidation(value),
                      keyboardType: TextInputType.emailAddress,
                      controllers: _passwordController,
                      sub: 'Password',
                      hittext: 'Enter your Password',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Appcolor.primaryColor,
        onPressed: () {
          if (formKey.currentState!.validate()) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => BottombarScreens()));
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
