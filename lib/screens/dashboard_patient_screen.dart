import 'package:codingbryant/screens/patient_prescription_details.dart';
import 'package:flutter/material.dart';
import 'package:codingbryant/screens/patient_chat_screen.dart';
import 'package:codingbryant/screens/profile_screen.dart';
import 'nav_bar.dart';

class DashboardPatientScreen extends StatefulWidget {
  @override
  _DashboardPatientScreenState createState() => _DashboardPatientScreenState();
}

class _DashboardPatientScreenState extends State<DashboardPatientScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    DashboardPatientScreenContent(),
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
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: NavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class DashboardPatientScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 2 / 9,
          width: double.infinity,
          color: Colors.blue,
          child: const Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text(
                        'Hello, John Doe!',
                        style: TextStyle(
                          fontFamily: 'RobotoMono',
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 5),
                      Padding(
                        padding: EdgeInsets.only(top: 0, left: 7, right: 10),
                        child: Text(
                          "Don't forget to take today's medications.",
                          style: TextStyle(
                            fontFamily: 'RobotoMono',
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 0.0, 0.0),
                  child: Text(
                    'Today, June 19',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PatientPrescriptionDetails()),
                    );
                  },
                  child: MedicationCard(
                    medicationName: 'MEDICATION NAME',
                    time: '8:00AM | 2 CAPSULES',
                    isTaken: false,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => MedicationDetailsScreen()),
                    // );
                  },
                  child: MedicationCard(
                    medicationName: 'MEDICATION NAME',
                    time: '8:00AM | 2 CAPSULES',
                    isTaken: false,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => MedicationDetailsScreen()),
                    // );
                  },
                  child: MedicationCard(
                    medicationName: 'MEDICATION NAME',
                    time: '8:00AM | 2 CAPSULES',
                    isTaken: false,
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 0.0, 0.0),
                  child: Text(
                    'Tomorrow',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => MedicationDetailsScreen()),
                    // );
                  },
                  child: MedicationCard(
                    medicationName: 'MEDICATION NAME',
                    time: '8:00AM | 2 CAPSULES',
                    isTaken: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MedicationCard extends StatefulWidget {
  final String medicationName;
  final String time;
  final bool isTaken;

  const MedicationCard({
    Key? key,
    required this.medicationName,
    required this.time,
    required this.isTaken,
  }) : super(key: key);

  @override
  _MedicationCardState createState() => _MedicationCardState();
}

class _MedicationCardState extends State<MedicationCard> {
  bool _isTaken = false;

  @override
  void initState() {
    _isTaken = widget.isTaken;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 5,
              height: 60,
              color: _isTaken ? Color(0xFFBEE3BA) : Colors.red,
            ),
            SizedBox(width: 10),
            Icon(
              Icons.medication,
              size: 40,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.medicationName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.time,
                  style: TextStyle(
                    color: Colors.white,
                  )
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isTaken = !_isTaken;
                });
              },
              child: Icon(
                _isTaken ? Icons.check_circle : Icons.check_circle_outline,
                color: _isTaken ? Color(0xFFBEE3BA) : Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

