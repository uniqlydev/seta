import 'package:codingbryant/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'doctor/dashboard_doctor_screen.dart';
import 'doctor/doctor_nav_bar.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    DashboardDoctorScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _widgetOptions[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            // Add back button action here
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            'Inbox',
            style: TextStyle(fontFamily: 'RobotoMono', color: Colors.white),
          ),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.create, color: Colors.white),
            onPressed: () {
              // Add create action here
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: null,
                suffixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          PatientTile(
            name: 'Patient Castillo, Brendan',
            diagnosis: 'Tuberculosis',
            time: '0:00pm',
          ),
          PatientTile(
            name: 'Patient Wassmer, Matthew',
            diagnosis: 'Migraine',
            time: 'Yesterday',
          ),
          PatientTile(
            name: 'Patient Tesalona, Will',
            diagnosis: 'Acute Bronchitis',
            time: 'Yesterday',
          ),
        ],
      ),
      bottomNavigationBar: DoctorNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class PatientTile extends StatelessWidget {
  final String name;
  final String diagnosis;
  final String time;

  const PatientTile({
    Key? key,
    required this.name,
    required this.diagnosis,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        child: Icon(Icons.person, color: Colors.white),
      ),
      title: Text(name),
      subtitle: Text('Diagnosis: $diagnosis'),
      trailing: Text(time),
      onTap: () {
        // Handle tile tap
      },
    );
  }
}
