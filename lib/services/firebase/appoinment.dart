import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc2heal_doctor/model/appoinment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AppointmentController extends GetxController {
  final String appointments = "appointment";
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late CollectionReference<AppointmentModel> appointment;
  var allAppointmentList = <AppointmentModel>[].obs;
  var upcomingAppointmentList = <AppointmentModel>[].obs;
  List<AppointmentModel> allAppoinmentList = <AppointmentModel>[].obs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  AppointmentController() {
    appointment = firebaseFirestore
        .collection(appointments)
        .withConverter<AppointmentModel>(fromFirestore: (snapshot, options) {
      return AppointmentModel.fromJson(snapshot.id, snapshot.data()!);
    }, toFirestore: (value, options) {
      return value.toJson();
    });
  }

  Future<List<AppointmentModel>> getUserAppointments(String userId) async {
    final querySnapshot = await appointment
        .where('docid', isEqualTo: userId)
        .where('status', isEqualTo: false)
        .get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<void> deleteAppointment(String id) async {
    try {
      await appointment.doc(id).delete();
    } catch (error) {
      log('Error during deleting appointment: $error');
    }
  }

  Future<void> updateAppointmentField(
      String appointmentId, bool? newValue) async {
    try {
      await appointment.doc(appointmentId).update({'status': newValue!});
      print("Appointment field updated successfully");
    } catch (e) {
      print("Error updating appointment field: $e");
    }
  }

  Future<void> fetchAllAppointments() async {
    allAppointmentList.value = await getAllAppointments();
    if (allAppointmentList.isEmpty) {
      log('empty');
    } else {
      log('not empty');
    }
  }

  Future<List<AppointmentModel>> getAllAppointments() async {
    final snapshot = await appointment.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<void> updateAppointment(String id, AppointmentModel data) async {
    try {
      await appointment.doc(id).update(
            data.toJson(),
          );
    } catch (e) {
      log("Error in updating appointment: $e");
    }
  }

  Future<List<AppointmentModel>> getAppointmentsByDoctorId(
      String doctorId) async {
    final querySnapshot =
        await appointment.where('docid', isEqualTo: doctorId).get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<List<AppointmentModel>> getUpcomingAppointments(String userId) async {
    try {
      final querySnapshot = await appointment
          .where('docid', isEqualTo: userId)
          .where('status', isEqualTo: false)
          .get();
      List<AppointmentModel> upcomingAppointments = [];
      upcomingAppointmentList.value = upcomingAppointments;
      for (var doc in querySnapshot.docs) {
        AppointmentModel appointment = doc.data();
        if (isAppointmentOngoing(appointment.date!, appointment.time!)) {
          upcomingAppointments.add(appointment);
        }
      }

      return upcomingAppointments;
    } catch (e) {
      log('Error fetching expired appointments: $e');
      rethrow;
    }
  }

  bool isAppointmentOngoing(String appointmentDate, String appointmentTime) {
    // Split the time string into its components
    List<String> timeParts = appointmentTime.split(RegExp(r'[:\s]'));
    int appointmentHour = int.parse(timeParts[0]);
    int appointmentMinute = int.parse(timeParts[1]);
    bool isPM = timeParts[2].toUpperCase() == 'PM';

    // Adjust the hour for AM/PM
    if (isPM && appointmentHour != 12) {
      appointmentHour += 12;
    } else if (!isPM && appointmentHour == 12) {
      appointmentHour = 0;
    }
    // Split the date string into its components (MM/DD/YYYY)
    List<String> dateParts = appointmentDate.split('/');
    int month = int.parse(dateParts[0]);
    int day = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);

    // Create a DateTime object for the appointment date and time
    DateTime appointmentDateTime =
        DateTime(year, month, day, appointmentHour, appointmentMinute);

    // Compare the appointment date and time with the current date and time
    DateTime now = DateTime.now();
    return appointmentDateTime.isAfter(now);
  }
}
