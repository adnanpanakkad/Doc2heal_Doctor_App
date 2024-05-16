import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc2heal_doctor/model/doctor_model.dart';
import 'package:doc2heal_doctor/services/firebase/authentication.dart';
import 'package:get/get.dart';

class DoctorRepository extends GetxController {
  AuthenticationRepository authenticationRepository =
      Get.put(AuthenticationRepository());
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<DoctorModel?> saveDoctorData(DoctorModel doctor, String id) async {
    try {
      await _db.collection("doctor").doc(id).set(doctor.toJson());
    } catch (e) {
      throw 'not saved';
    }
    return null;
  }

  Future<DocumentSnapshot> getDoctorDetails(String id) async {
    try {
      DocumentSnapshot snapshot = await _db.collection("doctor").doc(id).get();
      // final snapshot = await _db
      //     .collection("doctor")
      //     .doc(authenticationRepository.authUser!.uid)
      //     .get();
      return snapshot;
    } catch (e) {
      throw Exception(e);
    }
  }
}
