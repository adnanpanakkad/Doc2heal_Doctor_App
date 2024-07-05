import 'package:flutter/material.dart';
import 'package:doc2heal_doctor/services/firebase/firestore.dart';
import 'package:doc2heal_doctor/utils/app_color.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> docData;

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

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.docData['name']);
    _emailController = TextEditingController(text: widget.docData['email']);
    _phoneController = TextEditingController(text: widget.docData['phone']);
    _genderController = TextEditingController(text: widget.docData['gender']);
    _birthdayController =
        TextEditingController(text: widget.docData['birthday']);
    _specializationController =
        TextEditingController(text: widget.docData['specialization']);
    _feesController = TextEditingController(text: widget.docData['fees']);
    _startTimeController =
        TextEditingController(text: widget.docData['starttime']);
    _endTimeController = TextEditingController(text: widget.docData['endtime']);
  }

  void _updateProfile() async {
    Map<String, dynamic> updatedData = {
      'name': _nameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'gender': _genderController.text,
      'birthday': _birthdayController.text,
      'specialization': _specializationController.text,
      'fees': _feesController.text,
      'starttime': _startTimeController.text,
      'endtime': _endTimeController.text,
    };

    // await DoctorRepository().updateDoctorDetails(widget.docData['uid'], updatedData);
    // Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _genderController.dispose();
    _birthdayController.dispose();
    _specializationController.dispose();
    _feesController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Appcolor.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
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
              decoration: InputDecoration(labelText: 'Specialization'),
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
    );
  }
}
