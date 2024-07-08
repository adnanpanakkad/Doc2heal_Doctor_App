import 'package:doc2heal_doctor/model/appoinment.dart';
import 'package:doc2heal_doctor/model/user_model.dart';
import 'package:doc2heal_doctor/screens/chat_screen.dart';
import 'package:doc2heal_doctor/services/firebase/appoinment.dart';
import 'package:doc2heal_doctor/services/firebase/firestore.dart';
import 'package:doc2heal_doctor/widgets/chat/message_shimmer.dart';
import 'package:doc2heal_doctor/widgets/common/custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final AppointmentController appointmentController =
      Get.put(AppointmentController());
  final DoctorRepository _userService = Get.put(DoctorRepository());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppbar(
                text: 'Messages',
              ),
              Expanded(
                child: StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, authSnapshot) {
                    if (authSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: MessageShimmer());
                    } else if (authSnapshot.hasError) {
                      return Center(
                        child: Text('Error: ${authSnapshot.error}'),
                      );
                    } else if (!authSnapshot.hasData) {
                      return const Center(
                        child: Text('User not logged in'),
                      );
                    } else {
                      final currentUser = authSnapshot.data;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: FutureBuilder<List<AppointmentModel>>(
                              future: appointmentController
                                  .getUpcomingAppointments(currentUser!.uid),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const MessageShimmer();
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Error: ${snapshot.error}'),
                                  );
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const Center(
                                    child: Text('No user booked'),
                                  );
                                } else {
                                  final appointments = snapshot.data!;
                                  return ListView.builder(
                                    itemCount: appointments.length,
                                    itemBuilder: (context, index) {
                                      final appointment = appointments[index];
                                      return FutureBuilder<UserModel?>(
                                        future: _userService
                                            .getUserById(appointment.uid!),
                                        builder: (context, userSnapshot) {
                                          if (userSnapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const MessageShimmer();
                                          } else if (userSnapshot.hasError) {
                                            return Center(
                                              child: Text(
                                                  'Error: ${userSnapshot.error}'),
                                            );
                                          } else if (!userSnapshot.hasData) {
                                            return const Center(
                                              child: Text('User not found'),
                                            );
                                          } else {
                                            final user = userSnapshot.data!;
                                            return ListTile(
                                              leading: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    user.coverimag ?? ''),
                                              ),
                                              title:
                                                  Text(user.name ?? 'No Name'),
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChatScreen(
                                                              reciverEmail:
                                                                  user.name!,
                                                              reciverID:
                                                                  user.id!,
                                                            )));
                                              },
                                            );
                                          }
                                        },
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
