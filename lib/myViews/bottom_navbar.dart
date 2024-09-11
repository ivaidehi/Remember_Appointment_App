import 'package:appointment_app/screens/home_screen.dart';
import 'package:appointment_app/screens/profile_screen.dart';
import 'package:appointment_app/screens/set_appt_screen.dart';
import 'package:appointment_app/screens/wrapped_appt_screen.dart';
import 'package:appointment_app/styles/app_styles.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key});

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: AppStyles.secondary,
        backgroundColor: CupertinoColors.white,
        iconSize: 36,
        height: 80,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_home_regular),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_page_regular),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_page_filled),
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_person_regular),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_person_filled),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(child: HomeScreen());
              },
              routes: {
                "wrapped_appt_screen": (context) => const WrappedApptScreen(),
              },
            );
          case 1:
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(child: SetApptScreen());
              },
              routes: {
                "home_screen": (context) => const HomeScreen(),
              },
            );
          case 2:
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(child: ProfileScreen());
              },
              // routes: {
              //   "login_screen": (context) => const LoginScreen(),
              // },
            );
        }
        return Container();
      },
    );
  }
}
