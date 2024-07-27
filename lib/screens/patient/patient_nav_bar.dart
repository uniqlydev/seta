import 'package:flutter/material.dart';

class PatientNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const PatientNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

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
          Navigator.pushReplacementNamed(context, '/inbox-patient');
          Colors.blue;
        } else if (index == 0) {
          Navigator.pushReplacementNamed(context, '/dashboard-patient');
          Colors.blue;
        } else if (index == 2) {
          Navigator.pushReplacementNamed(context, '/patient-profile-screen');
          Colors.blue;
        } else {
          onTap(index);
        }
      },
    );
  }
}
