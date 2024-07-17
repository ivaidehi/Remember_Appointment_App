import 'package:appointment_app/styles/app_styles.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/set_appt_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final appScreens = [
    const HomeScreen(),
    const SetApptScreen(),
    const Center(child: Text("Profile Page")),
  ];

  int _selectedIndex = 0;

  void onIconClicked(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: appScreens[_selectedIndex],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: BottomNavigationBar(
            elevation: 0,
            onTap: onIconClicked,
            currentIndex: _selectedIndex,
            // backgroundColor: Colors.blueGrey,
            selectedItemColor: AppStyles.secondary,
            unselectedItemColor: Colors.blueGrey,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(FluentSystemIcons.ic_fluent_home_regular),
                  activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(FluentSystemIcons.ic_fluent_page_regular),
                  activeIcon: Icon(FluentSystemIcons.ic_fluent_page_filled),
                  label: "Appointment"),
              BottomNavigationBarItem(
                  icon: Icon(FluentSystemIcons.ic_fluent_person_regular),
                  activeIcon: Icon(FluentSystemIcons.ic_fluent_person_filled),
                  label: "Profile"),
            ],
          ),
        ));
  }
}
