import 'package:flutter/material.dart';

class DoctorNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

<<<<<<< HEAD:lib/screens/nav_bar.dart
  const NavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);
=======
  const DoctorNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });
>>>>>>> 29f26f744c8776cc12b15aa683ac2f546970027a:lib/screens/doctor/doctor_nav_bar.dart

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
<<<<<<< HEAD:lib/screens/nav_bar.dart
          Navigator.pushNamed(context, '/inbox-doctor');
          Colors.blue;
        } 
        else if (index == 0){
          Navigator.pushNamed(context, '/dashboard-doctor');
=======
          Navigator.pushReplacementNamed(context, '/inbox-doctor');
          Colors.blue;
        } else if (index == 0) {
          Navigator.pushReplacementNamed(context, '/dashboard-doctor');
          Colors.blue;
        } else if (index == 2) {
          Navigator.pushReplacementNamed(context, '/doctor-profile-screen');
>>>>>>> 29f26f744c8776cc12b15aa683ac2f546970027a:lib/screens/doctor/doctor_nav_bar.dart
          Colors.blue;
        } else {
          onTap(index);
        }
      },
    );
  }
}
