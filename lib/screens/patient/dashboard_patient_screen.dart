import 'package:codingbryant/blocs/user_bloc/auth_bloc.dart';
import 'package:codingbryant/screens/chat_screen.dart';
import 'package:codingbryant/screens/patient/patient_nav_bar.dart';
import 'package:codingbryant/screens/patient/patient_prescription_details.dart';
import 'package:codingbryant/screens/patient/widgets/medication_card.dart';
import 'package:codingbryant/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
            List<Map<String, String>> medicationTimes = [];

            // Collect all medication times into a single list
            medications.forEach((medication) {
              if (medication.time1 != null && medication.time1.isNotEmpty) {
                medicationTimes.add({
                  'medication': medication.medication ?? 'Unknown Medication',
                  'time': medication.time1 ?? '',
                  'dosage': medication.dosage.toString()
                });
              }
              if (medication.time2 != null && medication.time2.isNotEmpty) {
                medicationTimes.add({
                  'medication': medication.medication ?? 'Unknown Medication',
                  'time': medication.time2 ?? '',
                  'dosage': medication.dosage.toString()
                });
              }
              if (medication.time3 != null && medication.time3.isNotEmpty) {
                medicationTimes.add({
                  'medication': medication.medication ?? 'Unknown Medication',
                  'time': medication.time3 ?? '',
                  'dosage': medication.dosage.toString()
                });
              }
            });

            // Sort the list of medications by time
            medicationTimes.sort((a, b) {
              final timeA = a['time'];
              final timeB = b['time'];
              if (timeA == null) return -1;
              if (timeB == null) return 1;
              return timeA.compareTo(timeB);
            });

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
                        medicationTimes.isEmpty
                            ? const Center(
                                child: Text(
                                  "No Medication To Take",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black54,
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: MediaQuery.of(context).size.height * 0.5,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: medicationTimes.length,
                                  itemBuilder: (context, index) {
                                    final medication = medicationTimes[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const PatientPrescriptionDetails(),
                                          ),
                                        );
                                      },
                                      child: MedicationCard(
                                        medicationName: medication['medication'] ?? 'Unknown Medication',
                                        time: '${medication['time']} | ${medication['dosage']} CAPSULES',
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
            );
          } else if (state is AuthFailure) {
            Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
