import 'package:doc2heal_doctor/utils/app_color.dart';
import 'package:doc2heal_doctor/utils/text_style.dart';
import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> usernames = [
      'adhil',
      'amal',
      'rahul',
      'gokul',

      // Add more usernames as needed
    ];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    size: 30,
                  )),
            ],
            backgroundColor: Appcolor.primaryColor,
            title: const Text('Appoinments')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
                child: Text(
              'Today',
              style: CustomTextStyle.buttonTextStyle,
            )),
            Expanded(
              child: ListView.builder(
                itemCount: usernames.length,
                itemBuilder: (context, index) {
                  String userName = index < usernames.length
                      ? usernames[index]
                      : 'User ${index + 1}';

                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage('assets/Ellipse 1.png'),
                    ),
                    title: Text(userName),
                    subtitle: const Text('20 years | 10.10AM'),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => ChatScreen()),
                      // );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
