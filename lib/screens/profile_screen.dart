import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc2heal_doctor/model/doctor_model.dart';
import 'package:doc2heal_doctor/services/firebase/firestore.dart';
import 'package:doc2heal_doctor/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.maxFinite, 70),
        child: DeatialAppbar(text: 'Doctor profile'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: DoctorRepository().getDoctorDetails(
            'doctorId'), // Assuming 'doctorId' is the unique identifier
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.exists) {
            DocumentSnapshot doctorData = snapshot.data!;
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: <Widget>[
                      CircleAvatar(
                        radius: 65,
                        backgroundImage:
                            NetworkImage(doctorData.get('imagepath')),
                      ),
                      Card(
                        child: ListTile(
                          title: const Text('Name'),
                          subtitle: Text(doctorData.get('name') ?? 'N/A'),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: const Text('Birthday'),
                          subtitle: Text(doctorData.get('birthday') ?? 'N/A'),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: const Text('Specialization'),
                          subtitle:
                              Text(doctorData.get('specialization') ?? 'N/A'),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: const Text('Email'),
                          subtitle: Text(doctorData.get('email') ?? 'N/A'),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: const Text('Gender'),
                          subtitle: Text(doctorData.get('gender') ?? 'N/A'),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: const Text('Phone'),
                          subtitle: Text(doctorData.get('phone') ?? 'N/A'),
                        ),
                      ),
                      Container(
                        height: 150,
                        width: 200,
                        child: Image.network(doctorData.get('expcerft') ?? ''),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}
