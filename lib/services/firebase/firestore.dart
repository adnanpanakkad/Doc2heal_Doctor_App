import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc2heal_doctor/model/doctor_model.dart';

class DoctorRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// function to save user data to Firestore
  Future<void> saveDoctorData(DoctorModel doctor, String id) async {
    // Added String type for id parameter
    try {
      await _db.collection("doctor").doc(id).set(doctor.toJson());
    } catch (e) {
      throw 'not saved';
    }
  }

  /// Function to fetch user data from Firestore by user ID
  Future<DoctorModel> getDoctorById(String doctorId, String s) async {
    try {
      DocumentSnapshot userSnapshot =
          await _db.collection("doctor").doc(doctorId).get();

      if (userSnapshot.exists) {
        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;
        if (userData != null) {
          return DoctorModel.fromJson(userData);
        } else {
          throw Exception('Data is null');
        }
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
