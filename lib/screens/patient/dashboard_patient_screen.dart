<<<<<<< HEAD
import 'package:codingbryant/blocs/user_bloc/auth_bloc.dart';
import 'package:codingbryant/screens/chat_screen.dart';
import 'package:codingbryant/screens/nav_bar.dart';
=======
import 'package:codingbryant/screens/patient/patient_nav_bar.dart';
>>>>>>> development
import 'package:codingbryant/screens/patient/patient_prescription_details.dart';
import 'package:codingbryant/screens/patient/widgets/medication_card.dart';
import 'package:codingbryant/screens/profile_screen.dart';
<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
=======
import '../doctor/doctor_nav_bar.dart';
>>>>>>> development

class DashboardPatientScreen extends StatefulWidget {
  @override
  _DashboardPatientScreenState createState() => _DashboardPatientScreenState();
}

class _DashboardPatientScreenState extends State<DashboardPatientScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    _DashboardPatientScreenContent(),
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
      bottomNavigationBar: PatientNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class _DashboardPatientScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticatedPatient) {
            final medications = state.prescriptions;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 2 / 9,
                    width: double.infinity,
                    color: Colors.blue,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 10),
                                Text(
                                  'Hello, ${state.firstName}!',
                                  style: const TextStyle(
                                    fontFamily: 'RobotoMono',
                                    fontSize: 32,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 0),
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 5),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 0, left: 7, right: 10),
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
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 0.0, 0.0),
                          child: Text(
                            DateFormat('MMMM d').format(DateTime.now()),
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: medications.length,
                            itemBuilder: (context, index) {
                              final medication = medications[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const PatientPrescriptionDetails()),
                                  );
                                },
                                child: MedicationCard(
                                  medicationName: medication.medication,
                                  time: '${medication.instructions} | ${medication.dosage} CAPSULES',
                                  isTaken: false,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
<<<<<<< HEAD
            );
          } else if (state is AuthFailure) {
            Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
=======
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
                      MaterialPageRoute(
                          builder: (context) => PatientPrescriptionDetails()),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PatientPrescriptionDetails()),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PatientPrescriptionDetails()),
                    );
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PatientPrescriptionDetails()),
                    );
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
                Text(widget.time,
                    style: TextStyle(
                      color: Colors.white,
                    )),
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
>>>>>>> development
      ),
    );
  }
}
