import 'package:brillzconnect/features/profile/profile_screen.dart';
import 'package:brillzconnect/features/settings_and_privacy/settings_screen.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ProfileScreen(),
    const Center(child: Text('Buddies')),
    const Center(child: Text('Discover')),
    SettingsPrivacyPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey, selectedItemColor: Colors.black,
        currentIndex:
            _currentIndex, // Set the current index to reflect the selected tab
        onTap: (index) {
          setState(() {
            _currentIndex =
                index; // Update the current index when a tab is selected
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Buddies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
