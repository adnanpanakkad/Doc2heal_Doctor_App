import 'dart:io';
import 'package:doc2heal_doctor/controller/document_controller.dart';
import 'package:doc2heal_doctor/controller/signup_controller.dart';
import 'package:doc2heal_doctor/services/firebase/firestore.dart';
import 'package:doc2heal_doctor/widgets/common/custom_snacbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:doc2heal_doctor/utils/app_color.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic>? docData;

  EditProfileScreen({required this.docData});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _genderController;
  late TextEditingController _birthdayController;
  late TextEditingController _specializationController;
  late TextEditingController _feesController;
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;
  SignupController controller = Get.put(SignupController());
  DocumentController documentcontroller = Get.put(DocumentController());
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.docData!['name'] ?? '');
    _emailController =
        TextEditingController(text: widget.docData!['email'] ?? '');
    _phoneController =
        TextEditingController(text: widget.docData!['phone'] ?? '');
    _genderController =
        TextEditingController(text: widget.docData!['gender'] ?? '');
    _birthdayController =
        TextEditingController(text: widget.docData!['birthday'] ?? '');
    _specializationController =
        TextEditingController(text: widget.docData!['specialization'] ?? '');
    _feesController =
        TextEditingController(text: widget.docData!['fees'] ?? '');
    _startTimeController =
        TextEditingController(text: widget.docData!['starttime'] ?? '');
    _endTimeController =
        TextEditingController(text: widget.docData!['endtime'] ?? '');
  }

  void _updateProfile() async {
    Map<String, dynamic> updatedData = {
      'doctorimg': controller.profilepicPath.value.isNotEmpty
          ? controller.profileimgurl.toString()
          : widget.docData!['doctorimg'],
      'name': _nameController.text.isNotEmpty ? _nameController.text : '',
      'email': _emailController.text.isNotEmpty ? _emailController.text : '',
      'phone': _phoneController.text.isNotEmpty ? _phoneController.text : '',
      'gender': _genderController.text.isNotEmpty ? _genderController.text : '',
      'birthday':
          _birthdayController.text.isNotEmpty ? _birthdayController.text : '',
      'specialization': _specializationController.text.isNotEmpty
          ? _specializationController.text
          : '',
      'fees': _feesController.text.isNotEmpty ? _feesController.text : '',
      'starttime':
          _startTimeController.text.isNotEmpty ? _startTimeController.text : '',
      'endtime':
          _endTimeController.text.isNotEmpty ? _endTimeController.text : '',
      'expcerft': documentcontroller.expcerftpath.value.isNotEmpty
          ? documentcontroller.expcerftUrl.toString()
          : widget.docData!['expcerft'],
    };

    await DoctorRepository().updateUserProfile(user!.uid, updatedData);
    Navigator.of(context).pop();
    CustomSnackbar.show(
        snackPosition: SnackPosition.TOP,
        title: 'Profile Updated',
        description: 'Your profile successfully updated.',
        backgroundColor: Colors.greenAccent.shade400,
        icon: Icon(
          Icons.check_circle,
          color: Colors.white,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Appcolor.lightbackground,
        appBar: AppBar(
          title: Text('Edit Profile'),
          backgroundColor: Appcolor.primaryColor,
        ),
        body: Obx(
          () => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  child: Stack(
                    alignment: Alignment(1, 1),
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundImage: controller.isProfiepathSet.value ==
                                false
                            ? NetworkImage(widget.docData!['doctorimg'])
                            : FileImage(File(controller.profilepicPath.value))
                                as ImageProvider,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () async {
                            controller.imagepickerfun();
                          },
                          child: const CircleAvatar(
                            radius: 20,
                            backgroundColor: Color.fromARGB(255, 229, 229, 229),
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
                Expanded(
                  child: ListView(
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(labelText: 'Name'),
                      ),
                      TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(labelText: 'Phone'),
                      ),
                      TextField(
                        controller: _genderController,
                        decoration: InputDecoration(labelText: 'Gender'),
                      ),
                      TextField(
                        controller: _birthdayController,
                        decoration: InputDecoration(labelText: 'Birthday'),
                      ),
                      TextField(
                        controller: _specializationController,
                        decoration:
                            InputDecoration(labelText: 'Specialization'),
                      ),
                      TextField(
                        controller: _feesController,
                        decoration: InputDecoration(labelText: 'Fees'),
                      ),
                      TextField(
                        controller: _startTimeController,
                        decoration: InputDecoration(labelText: 'Start Time'),
                      ),
                      TextField(
                        controller: _endTimeController,
                        decoration: InputDecoration(labelText: 'End Time'),
                      ),
                      const SizedBox(height: 20),
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: documentcontroller.isexpcerftpathSet.value ==
                                    false
                                ? Image.network(
                                    (widget.docData!['expcerft']),
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height *
                                        0.35,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    File(documentcontroller.expcerftpath.value),
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height *
                                        0.35,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 150, top: 110),
                            child: IconButton(
                              color: Colors.black,
                              onPressed: () =>
                                  documentcontroller.documentPicker(),
                              icon: const Icon(
                                Icons.cloud_upload,
                                color: Colors.grey,
                                size: 50,
                              ),
                            ),
                          )
                        ],
                      ),
                      ElevatedButton(
                        onPressed: _updateProfile,
                        child: Text('Update'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Appcolor.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
