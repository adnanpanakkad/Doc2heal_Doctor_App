import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc2heal_doctor/model/doctor_model.dart';
import 'package:doc2heal_doctor/services/firebase/authentication.dart';

class DoctorRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<DoctorModel?> saveDoctorData(DoctorModel doctor) async {
    try {
      DocumentReference docRef =
          await _db.collection("doctor").add(doctor.toJson());
      print("Document added with ID: ${docRef.id}");
    } catch (e) {
      throw 'not saved';
    }
    return null;
  }

  Future<DocumentSnapshot> getDoctorDetails(String uid) async {
    try {
      final snapshot = await _db
          .collection("doctor")
          .doc(AuthenticationRepository().authUser!.uid)
          .get();
      return snapshot;
    } catch (e) {
      throw Exception(e);
    }
  }
}
