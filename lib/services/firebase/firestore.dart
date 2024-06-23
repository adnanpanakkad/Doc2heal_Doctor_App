import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc2heal_doctor/model/doctor_model.dart';
import 'package:doc2heal_doctor/services/firebase/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DoctorRepository extends GetxController {
  AuthenticationRepository authenticationRepository =
      Get.put(AuthenticationRepository());
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> getCurrentUser() async {
    User? doctor = FirebaseAuth.instance.currentUser;
    if (doctor == null) {
      throw FirebaseAuthException(
        code: 'user-not-authenticated',
        message: 'User not authenticated',
      );
    }
    return doctor.uid;
  }

  Future<DoctorModel?> saveDoctorData(DoctorModel doctor, String id) async {
    try {
      await _db.collection("doctor").doc(id).set(doctor.toJson());
    } catch (e) {
      throw 'not saved';
    }
    return null;
  }

   Stream<Map<String, dynamic>?> getDoctorDetails(String userId) {
    return _db.collection('doctor').doc(userId).snapshots().map((snapshot) {
      return snapshot.data() as Map<String, dynamic>?;
    });
  }
}
