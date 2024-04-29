import 'package:doc2heal_doctor/model/doctor_model.dart';
import 'package:doc2heal_doctor/services/firebase/firestore.dart';
import 'package:doc2heal_doctor/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String
      doctorId; // Assuming you have the doctor's ID to fetch the details

  const ProfileScreen({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size(double.maxFinite, 70),
          child: DeatialAppbar(text: 'Doctor profile')),
      body: FutureBuilder<DoctorModel>(
        future: DoctorRepository()
            .getDoctorById(doctorId, '0'), // Fetch the doctor's data
        builder: (BuildContext context, AsyncSnapshot<DoctorModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Show loading indicator while waiting
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
                    'Error: ${snapshot.error}')); // Show error message if there's an error
          } else {
            // Display the doctor's details
            DoctorModel doctorData = snapshot.data!;
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50,
                        child: Image.network(doctorData.imagepath!),
                      ),
                      Card(
                        child: ListTile(
                          title: const Text('Name'),
                          subtitle: Text(doctorData.name),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: const Text('Birthday'),
                          subtitle: Text(doctorData.birthday),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: const Text('Email'),
                          subtitle: Text(doctorData.email),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: const Text('Gender'),
                          subtitle: Text(doctorData.gender),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: const Text('Phone'),
                          subtitle: Text(doctorData.phone),
                        ),
                      ),
                      Container(
                          height: 150,
                          width: 200,
                          child: Image.network(doctorData.expcerft!)),
                      // Add more cards as needed for additional details
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
