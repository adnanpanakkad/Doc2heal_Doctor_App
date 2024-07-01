import 'package:doc2heal_doctor/screens/messages.dart';
import 'package:doc2heal_doctor/screens/settings_screen.dart';
import 'package:doc2heal_doctor/screens/home_screen.dart';
import 'package:doc2heal_doctor/utils/app_color.dart';
import 'package:flutter/material.dart';

class BottombarScreens extends StatefulWidget {
  const BottombarScreens({super.key});

  @override
  __BottombarScreensState createState() => __BottombarScreensState();
}

class __BottombarScreensState extends State<BottombarScreens> {
  int _currentPageIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const MessageScreen(),
    const SettingsScreen(
      uid: '',
      userData: {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        indicatorColor: Appcolor.primaryColor,
        backgroundColor: Colors.white60,
        onDestinationSelected: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        selectedIndex: _currentPageIndex,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.calendar_today),
            label: 'Appoinments',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat),
            label: 'Messages',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      body: _pages[_currentPageIndex],
    );
  }
}
