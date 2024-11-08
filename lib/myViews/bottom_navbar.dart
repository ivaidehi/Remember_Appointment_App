import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/set_appt_screen.dart';
import '../screens/wrapped_appt_screen.dart';
import '../styles/app_styles.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key});

  static _MyBottomNavBarState? of(BuildContext context) {
    return context.findAncestorStateOfType<_MyBottomNavBarState>();
  }

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int _currentIndex = 0;
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  final List<Widget> _screens = const [
    HomeScreen(),
    SetApptScreen(),
    ProfileScreen(),
  ];

  void onTabTapped(int index) {
    if (_currentIndex == index) {
      // Pop to the root of the current tab if the same tab is tapped again
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
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
        return CupertinoTabView(
          navigatorKey: _navigatorKeys[index],
          builder: (context) {
            return CupertinoPageScaffold(child: _screens[index]);
          },
          routes: {
            "home_screen": (context) => const HomeScreen(),
            "wrapped_appt_screen": (context) => const WrappedApptScreen(),
          },
        );
      },
    );
  }
}
