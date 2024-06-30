// import 'package:doc2heal_doctor/model/appoinment.dart';
// import 'package:doc2heal_doctor/model/user_model.dart';
// import 'package:doc2heal_doctor/screens/appoinment_detail_screen.dart';
// import 'package:doc2heal_doctor/services/firebase/appoinment.dart';
// import 'package:doc2heal_doctor/services/firebase/firestore.dart';
// import 'package:doc2heal_doctor/utils/app_color.dart';
// import 'package:doc2heal_doctor/utils/text_style.dart';
// import 'package:doc2heal_doctor/widgets/home/shimmer_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final AppoinmentServices _appointmentServices = Get.put(AppoinmentServices());
//   final DoctorRepository _userService = Get.put(DoctorRepository());
//   final currentdoc = FirebaseAuth.instance.currentUser;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           actions: [
//             IconButton(
//               onPressed: () {},
//               icon: const Icon(
//                 Icons.search,
//                 size: 30,
//               ),
//             ),
//           ],
//           backgroundColor: Appcolor.primaryColor,
//           title: const Text('Appointments'),
//         ),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Center(
//               child: Text(
//                 'Today',
//                 style: CustomTextStyle.buttonTextStyle,
//               ),
//             ),
//             Expanded(
//               child: FutureBuilder<List<AppointmentModel>>(
//                 future: _appointmentServices
//                     .getAppointmentsByDoctorId(currentdoc!.uid),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const ShimmerList();
//                   } else if (snapshot.hasError) {
//                     return Center(
//                       child: Text('Error: ${snapshot.error}'),
//                     );
//                   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return const Center(
//                       child: Text('No appointments found'),
//                     );
//                   } else {
//                     final _appointments = snapshot.data!;
//                     return ListView.builder(
//                       itemCount: _appointments.length,
//                       itemBuilder: (context, index) {
//                         final appointment = _appointments[index];
//                         return FutureBuilder<UserModel?>(
//                           future: _userService.getUserById(appointment.uid!),
//                           builder: (context, userSnapshot) {
//                             if (userSnapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return const Text('nodata');
//                             } else if (userSnapshot.hasError) {
//                               return ListTile(
//                                 title: Text('Error: ${userSnapshot.error}'),
//                               );
//                             } else if (!userSnapshot.hasData) {
//                               return const ListTile(
//                                 title: Text('User not found'),
//                               );
//                             } else {
//                               final user = userSnapshot.data!;
//                               return ListTile(
//                                 leading: CircleAvatar(
//                                   backgroundImage:
//                                       NetworkImage(user.coverimag ?? ''),
//                                 ),
//                                 title: Text(user.name ?? 'No Name'),
//                                 subtitle: Text(appointment.time ?? 'No Date'),
//                                 onTap: () {
//                                   Get.to(() => AppoinmentDetailScreen());
//                                 },
//                               );
//                             }
//                           },
//                         );
//                       },
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:doc2heal_doctor/model/appoinment.dart';
import 'package:doc2heal_doctor/model/user_model.dart';
import 'package:doc2heal_doctor/screens/appoinment_detail_screen.dart';
import 'package:doc2heal_doctor/services/firebase/appoinment.dart';
import 'package:doc2heal_doctor/services/firebase/firestore.dart';
import 'package:doc2heal_doctor/utils/app_color.dart';
import 'package:doc2heal_doctor/utils/text_style.dart';
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
  final currentdoc = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: 30,
              ),
            ),
          ],
          backgroundColor: Appcolor.primaryColor,
          title: const Text('Appointments'),
        ),
        body: Column(
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
                    .getAppointmentsByDoctorId(currentdoc!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ShimmerList();
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No appointments found'),
                    );
                  } else {
                    final _appointments = snapshot.data!;
                    return ListView.builder(
                      itemCount: _appointments.length,
                      itemBuilder: (context, index) {
                        final appointment = _appointments[index];
                        return FutureBuilder<UserModel?>(
                          future: _userService.getUserById(appointment.uid!),
                          builder: (context, userSnapshot) {
                            if (userSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (userSnapshot.hasError) {
                              return ListTile(
                                title: Text('Error: ${userSnapshot.error}'),
                              );
                            } else if (!userSnapshot.hasData) {
                              return const ListTile(
                                title: Text('User not found'),
                              );
                            } else {
                              final user = userSnapshot.data!;
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(user.coverimag ?? ''),
                                ),
                                title: Text(user.name ?? 'No Name'),
                                subtitle: Text(appointment.time ?? 'No Date'),
                                onTap: () {
                                  Get.to(() => AppoinmentDetailScreen());
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
        ),
      ),
    );
  }
}
