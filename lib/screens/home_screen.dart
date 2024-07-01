import 'package:doc2heal_doctor/model/appoinment.dart';
import 'package:doc2heal_doctor/model/user_model.dart';
import 'package:doc2heal_doctor/services/firebase/appoinment.dart';
import 'package:doc2heal_doctor/services/firebase/firestore.dart';
import 'package:doc2heal_doctor/utils/text_style.dart';
import 'package:doc2heal_doctor/widgets/home/Appoinment_card.dart';
import 'package:doc2heal_doctor/widgets/home/home_appbar.dart';
import 'package:doc2heal_doctor/widgets/home/shimmer_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AppoinmentServices _appointmentServices = Get.put(AppoinmentServices());
  final DoctorRepository _userService = Get.put(DoctorRepository());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const HomeAppbar(
          text: 'Appoinments',
        ),
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, authSnapshot) {
            if (authSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: ShimmerList());
            } else if (authSnapshot.hasError) {
              return Center(
                child: Text('Error: ${authSnapshot.error}'),
              );
            } else if (!authSnapshot.hasData) {
              return const Center(
                child: Text('User not logged in'),
              );
            } else {
              final currentdoc = authSnapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Today',
                      style: CustomTextStyle.buttonTextStyle,
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<AppointmentModel>>(
                      future: _appointmentServices
                          .getUserAppointments(currentdoc!.uid),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const ShimmerList();
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text('No appointments'),
                          );
                        } else {
                          final _appointments = snapshot.data!;
                          return ListView.builder(
                            itemCount: _appointments.length,
                            itemBuilder: (context, index) {
                              final appointment = _appointments[index];
                              return FutureBuilder<UserModel?>(
                                future:
                                    _userService.getUserById(appointment.uid!),
                                builder: (context, userSnapshot) {
                                  if (userSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const ShimmerList();
                                  } else if (userSnapshot.hasError) {
                                    return Center(
                                      child:
                                          Text('Error: ${userSnapshot.error}'),
                                    );
                                  } else if (!userSnapshot.hasData) {
                                    return const Center(
                                      child: Text('User not found'),
                                    );
                                  } else {
                                    final user = userSnapshot.data!;
                                    return AppoinmentCard(
                                        username: user.name,
                                        userimgurl: user.coverimag,
                                        reason: appointment.reason,
                                        time: appointment.time,
                                        date: appointment.date);
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
    );
  }
}
