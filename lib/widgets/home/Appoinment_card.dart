import 'package:doc2heal_doctor/services/firebase/appoinment.dart';
import 'package:doc2heal_doctor/widgets/home/popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppoinmentCard extends StatelessWidget {
  AppointmentController controller = Get.put(AppointmentController());
  final String? username;
  final String? userimgurl;
  final String? reason;
  final String? time;
  final String? date;
  final String? id;
  AppoinmentCard({
    super.key,
    this.username,
    this.userimgurl,
    this.reason,
    this.time,
    this.date,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      NetworkImage(userimgurl!), // Use actual image URL
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username!.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('reason:${reason!}'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16),
                    const SizedBox(width: 5),
                    Text(date!),
                    const SizedBox(width: 40),
                    const Icon(Icons.access_time, size: 16),
                    const SizedBox(width: 5),
                    Text(time!),
                  ],
                ),
                const Row(
                  children: [
                    Icon(Icons.circle, color: Colors.green, size: 12),
                    SizedBox(width: 5),
                    Text('Upcoming'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Popup(
                            message: 'Are you sure',
                            onTap: () async {
                              controller.updateAppointmentField(id!, true);
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.grey[300],
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
