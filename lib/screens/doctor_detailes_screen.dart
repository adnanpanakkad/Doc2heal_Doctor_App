import 'dart:io';
import 'package:doc2heal_doctor/model/doctor_model.dart';
import 'package:doc2heal_doctor/screens/document_detailes.dart';
import 'package:doc2heal_doctor/screens/welcome_screen.dart';
import 'package:doc2heal_doctor/services/firebase/authentication.dart';
import 'package:doc2heal_doctor/services/firebase/firestore.dart';
import 'package:doc2heal_doctor/utils/app_color.dart';
import 'package:doc2heal_doctor/widgets/appbar/appbar.dart';
import 'package:doc2heal_doctor/widgets/person_table/detail_tile.dart';
import 'package:doc2heal_doctor/widgets/validator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({super.key});

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  String? selectedGender;
  File? seletedImage;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final TextEditingController _specializationController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
      appBar: PreferredSize(
          preferredSize: const Size(double.maxFinite, 70),
          child: DeatialAppbar(
            text: 'Doctor Details',
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const WelcomeScreen())),
          )),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            const SizedBox(height: 10),
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
                        const SizedBox(height: 20),
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
                    const SizedBox(height: 20),
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
                      sub: 'Birthday',
                      hittext: _birthController.text.isEmpty
                          ? 'Select your birthday'
                          : _birthController.text,
                    ),
                    GestureDetector(
                      onTap: () async => _getTimeFromUser(context),
                      child: const Icon(Icons.calendar_month),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    DetailTile(
                      validator: (value) =>
                          Validator().textFeildValidation(value),
                      keyboardType: TextInputType.emailAddress,
                      controllers: _specializationController,
                      sub: 'specialization',
                      hittext: 'Enter your specialization',
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
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            DoctorModel doctor = DoctorModel(
                imagepath: seletedImage!.path,
                name: _nameController.text.trim(),
                phone: _phoneController.text.trim(),
                gender: _genderController.text.trim(),
                birthday: _birthController.text.trim(),
                specialization: _specializationController.text.trim(),
                email: _emailController.text.trim(),
                password: _passwordController.text.trim());
            await DoctorRepository().saveDoctorData(doctor, '0');
            await AuthenticationRepository.userEmailSignup(
                _emailController.text, _passwordController.text);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DocumentDetailes(
                imagepath: seletedImage!.path,
                name: _nameController.text.trim(),
                phone: _phoneController.text.trim(),
                gender: _genderController.text.trim(),
                birthday: _birthController.text.trim(),
                specialization: _specializationController.text.trim(),
                email: _emailController.text.trim(),
                password: _passwordController.text.trim(),
              ),
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
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    setState(() {
      seletedImage = File(pickedImage.path);
    });

    // Generate a unique filename for the image
    String uniqueFilename = DateTime.now().microsecondsSinceEpoch.toString();

    // Create a reference to the location you want to upload to in Firebase Storage
    Reference reference =
        FirebaseStorage.instance.ref().child('images/$uniqueFilename');

    // Upload the file to Firebase Storage
    UploadTask uploadTask = reference.putFile(seletedImage!);

    // Wait for the upload to complete and then get the download URL
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    // You can now use the downloadUrl for further processing, such as saving it to Firestore
    print("Download URL: $downloadUrl");
  }

  Future<void> _getTimeFromUser(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _birthController.text = DateFormat.yMd().format(pickedDate);
      });
    }
  }
}
