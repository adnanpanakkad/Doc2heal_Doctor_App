import 'package:doc2heal_doctor/model/doctor_model.dart';
import 'package:doc2heal_doctor/services/firebase/firestore.dart';
import 'package:doc2heal_doctor/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String doctorId;

  const ProfileScreen({Key? key, required this.doctorId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.maxFinite, 70),
        child: DeatialAppbar(text: 'Doctor profile'),
      ),
      body: FutureBuilder<DoctorModel>(
        future: DoctorRepository().getDoctorById(doctorId, '0'),
        builder: (BuildContext context, AsyncSnapshot<DoctorModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            DoctorModel doctorData = snapshot.data!;
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: <Widget>[
                      CircleAvatar(
                        radius: 65,
                        backgroundImage: doctorData.imagepath != null
                            ? NetworkImage(doctorData.imagepath!)
                            : const AssetImage("assets/Ellipse 1.png")
                                as ImageProvider, // Cast AssetImage to ImageProvider
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
                          title: const Text('specialization'),
                          subtitle: Text(doctorData.specialization),
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
                      // Display the certificate image
                      Container(
                          height: 150,
                          width: 200,
                          child: Image.network(doctorData.expcerft!)),
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
