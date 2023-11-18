import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/presentations/modules/main/screens/history/history_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/main/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/presentations/modules/main/screens/home/home_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0; //New

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    HistoryScreen(),
    SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex), //New
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: onPrimaryColor,
        selectedItemColor: onPrimaryColor,
        backgroundColor: primaryColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
                Icons.home,
                color: onPrimaryColor,
            ),
            label: TextStrings.homeBottomNavItem,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.book,
              color: onPrimaryColor,
            ),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.settings,
                color: onPrimaryColor
            ),
            label: TextStrings.settingsBottomNavItem,
          ),
        ],
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,         //New
      ),
    );
  }
}