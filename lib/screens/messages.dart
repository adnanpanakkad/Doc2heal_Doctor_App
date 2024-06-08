import 'package:doc2heal_doctor/screens/chat_screen.dart';
import 'package:doc2heal_doctor/widgets/common/custom_appbar.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define a list of usernames with custom values for specific indices
    List<String> usernames = [
      'adhil',
      'amal',
      'rahul',
      'gokul',

      // Add more usernames as needed
    ];
    List<String> category = ['cadiology', 'pediatric', 'dental', 'neaurology'];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppbar(text: 'Messages'),
              Expanded(
                child: ListView.builder(
                  itemCount: usernames
                      .length, // Adjust this to match the length of your usernames list
                  itemBuilder: (context, index) {
                    // Check if there's a custom username for this index; otherwise, use the default pattern
                    String userName = index < usernames.length
                        ? usernames[index]
                        : 'User ${index + 1}';

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/image.png'),
                      ),
                      title: Text(userName),
                      subtitle: Text(category[index]),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChatScreen()),
                        );
                      },
                    );
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
