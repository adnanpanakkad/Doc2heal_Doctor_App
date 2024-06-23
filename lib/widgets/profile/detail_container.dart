import 'package:doc2heal_doctor/services/firebase/firestore.dart';
import 'package:doc2heal_doctor/utils/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DetailContainer extends StatelessWidget {
  const DetailContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? doctor = FirebaseAuth.instance.currentUser;

    if (doctor == null) {
      // Handle case when user is not authenticated
      return const Center(child: Text('User not authenticated'));
    }

    return StreamBuilder<Map<String, dynamic>?>(
      stream: DoctorRepository().getDoctorDetails(doctor.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('No Data Available'));
        }

        var doctorData = snapshot.data!;

        return Container(
          decoration: BoxDecoration(
            color: Appcolor.primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          height: MediaQuery.of(context).size.height * 0.17,
          width: MediaQuery.of(context).size.width * 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: doctorData['doctorimg'] != null
                      ? NetworkImage(doctorData['doctorimg'])
                      : null,
                ),
              ),
              const SizedBox(width: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctorData['name'] ?? 'No Name',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    doctorData['email'] ?? 'No Email',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    doctorData['phone'] ?? 'No Phone',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
