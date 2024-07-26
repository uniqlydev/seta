import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const NavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.blue,
      onTap: (index) {
        if (index == 1) {
          Navigator.pushNamed(context, '/inbox-doctor');
          Colors.blue;
        } else if (index == 0) {
          Navigator.pushNamed(context, '/dashboard-doctor');
          Colors.blue;
        } else if (index == 2) {
          Navigator.pushNamed(context, '/doctor-profile-screen');
          Colors.blue;
        } else {
          onTap(index);
        }
      },
    );
  }
}
