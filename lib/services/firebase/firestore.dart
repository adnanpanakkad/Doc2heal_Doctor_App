import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc2heal_doctor/model/doctor_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DoctorRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveDoctorData(DoctorModel doctor) async {
    try {
      DocumentReference docRef =
          await _db.collection("doctor").add(doctor.toJson());
      print("Document added with ID: ${docRef.id}");
    } catch (e) {
      throw 'not saved';
    }
  }

  Future<DocumentSnapshot?> getUserData(String name) {
    return _db.collection('doctor').doc(name).get();

    // final QuerySnapshot result =
    //     await _db.collection('doctor').where('name', isEqualTo: name).get();

    // final List<DocumentSnapshot> documents = result.docs;

    // if (documents.length == 0) {
    //   print('No doctor found with this email');
    // } else {
    //   // Assuming you want to get the details of the first doctor found
    //   final Map<String, dynamic> doctorData =
    //       documents[0].data() as Map<String, dynamic>;
    //   print('Doctor Name: ${doctorData['name']}');
    //   print('Doctor Specialization: ${doctorData['specialization']}');
    //   // Add more fields as needed
    // }
    // return null;
  }

  getDoctorDetails(String s) {}


}
