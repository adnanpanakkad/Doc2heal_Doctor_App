import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  String? id;
  String? date;
  String? time;
  String? reason;
  String? uid;
  String? docid;

  AppointmentModel({
    this.id,
    this.date,
    this.time,
    this.reason,
    this.uid,
    this.docid,
  });

  factory AppointmentModel.fromJson(String id, Map<String, dynamic> json) {
    return AppointmentModel(
      date: json['date'],
      time: json['time'],
      reason: json['reason'],
      id: id,
      uid: json['uid'],
      docid: json['docid'],
    );
  }
  factory AppointmentModel.fromSnapshot(DocumentSnapshot<Object?> snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return AppointmentModel(
      date: data['date'],
      time: data['time'],
      reason: data['reason'],
      uid: data['uid'],
      docid: data['docid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'time': time,
      'reason': reason,
      'id': id,
      'uid': uid,
      'docid': docid,
    };
  }
}
