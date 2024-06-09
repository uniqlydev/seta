import 'package:codingbryant/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:codingbryant/models/PatientModel.dart';
import 'patient_list.dart';
import 'nav_bar.dart';
import 'chat_screen.dart';
import 'profile_screen.dart';
class DashboardDoctorScreen extends StatefulWidget {
  const DashboardDoctorScreen({Key? key}) : super(key: key);

  @override
  _DashboardDoctorScreenState createState() => _DashboardDoctorScreenState();
}

class _DashboardDoctorScreenState extends State<DashboardDoctorScreen> {
  int _selectedIndex = 0;

  List<Patient> patients = [
    Patient(name: 'John Doe', diagnosis: 'Fever'),
    Patient(name: "Brendan Pecson", diagnosis: 'Love Sick'),
    Patient(name: 'Brendan Castillo', diagnosis: 'Alcoholic'),
    Patient(name: 'Brendan Nathaniel', diagnosis: 'Chain Smoker'),
    Patient(name: 'Bren Ren', diagnosis: 'Schizophrenia'),
    Patient(name: "Nathaniel Cast", diagnosis: 'Racist')
  ];

  static  List<Widget> _widgetOptions = <Widget>[
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                            'Hello, Dr. Bryant!',
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
                              "Let's see our agenda",
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
            const SizedBox(height: 25), // Adjusted height
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    // Handle onTap for "Medication"
                    // Navigate to the page for looking at reference for medication
                  },
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.redAccent, // Change the color as needed
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.medication_rounded,
                          size: 60,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Medication',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Handle onTap for "Prescribe"
                    // Navigate to the page for prescribing medication
                  },
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.blue, // Change the color as needed
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.medical_services_rounded,
                          size: 60,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Prescribe',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // Adjusted height
            Padding(
              padding: const EdgeInsets.fromLTRB(35.0, 0, 0.0, 0.0),
              child: Text(
                'Patients',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 10), // Adjusted height
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: PatientListView(patients: patients),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}




