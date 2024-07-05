import 'package:doc2heal_doctor/screens/profile/editprofile.dart';
import 'package:doc2heal_doctor/services/firebase/firestore.dart';
import 'package:doc2heal_doctor/utils/app_color.dart';
import 'package:doc2heal_doctor/utils/text_style.dart';
import 'package:doc2heal_doctor/widgets/chat/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileScreen extends StatelessWidget {
  final User? currdoc = FirebaseAuth.instance.currentUser;

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Appcolor.lightbackground,
        appBar: DeatialAppbar(
          onTap: () {
            Navigator.pop(context);
          },
          text: 'Profile',
          centertitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<Map<String, dynamic>?>(
              stream: DoctorRepository().getDoctorDetails(currdoc!.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('No Data Available'));
                }

                var docdata = snapshot.data ?? {};
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: docdata['doctorimg'] != null
                          ? NetworkImage(docdata['doctorimg'])
                          : AssetImage('assets/default_profile_picture.png')
                              as ImageProvider,
                    ),
                    const SizedBox(height: 16),
                    Text('Dr.${docdata['name']}' ?? 'Unknown User',
                        style: CustomTextStyle.highboldTxtStyle),
                    const SizedBox(height: 8),
                    Text(
                      docdata['email'] ?? 'No Email Provided',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView(
                        children: [
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: Text('Phone'),
                            subtitle: Text(
                                docdata['phone'] ?? 'No Phone Number Provided'),
                          ),
                          ListTile(
                            leading: Icon(Icons.account_box),
                            title: Text('Gender'),
                            subtitle:
                                Text(docdata['gender'] ?? 'No Gender Provided'),
                          ),
                          ListTile(
                            leading: Icon(Icons.cake),
                            title: Text('Birthday'),
                            subtitle: Text(
                                docdata['birthday'] ?? 'No Birthday Provided'),
                          ),
                          ListTile(
                            leading: Icon(Icons.apartment_sharp),
                            title: Text('Specialization'),
                            subtitle: Text(docdata['specialization'] ??
                                'No Specialization Provided'),
                          ),
                          ListTile(
                            leading: Icon(Icons.monetization_on_outlined),
                            title: Text('Fees'),
                            subtitle:
                                Text(docdata['fees'] ?? 'No Fees Provided'),
                          ),
                          ListTile(
                            leading: Icon(Icons.monetization_on_outlined),
                            title: Text('Timing'),
                            subtitle: Text(
                                '${docdata['starttime']} to ${docdata['endtime']}' ??
                                    'No Fees Provided'),
                          ),
                          Text(
                            'Experience certificate',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily:
                                  'YourFontFamilyName', // Replace with your actual font family name
                            ),
                          ),
                          SizedBox(
                            height: 300,
                            width: double.infinity,
                            child: Image.network(docdata['expcerft']),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditProfileScreen(
                                      docData: docdata,
                                    )));
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text('Edit Profile'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Appcolor.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
