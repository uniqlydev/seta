import 'package:codingbryant/blocs/user_bloc/auth_bloc.dart';
import 'package:codingbryant/screens/doctor/patient_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'doctor_nav_bar.dart';

class DashboardDoctorScreen extends StatefulWidget {
  const DashboardDoctorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DashboardDoctorScreenState createState() => _DashboardDoctorScreenState();
}

class _DashboardDoctorScreenState extends State<DashboardDoctorScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late final List<String> patients;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  'Hello, Dr. ${state.firstName}!',
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
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/medication-screen');
                        },
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
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
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.medication_rounded,
                                size: 60,
                                color: Colors.white,
                              ),
                              SizedBox(height: 10),
                              Text(
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
                          Navigator.pushNamed(context, '/prescription-form');
                        },
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            color: Colors.blue,
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
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.medical_services_rounded,
                                size: 60,
                                color: Colors.white,
                              ),
                              SizedBox(height: 10),
                              Text(
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
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(35.0, 0, 0.0, 0.0),
                    child: Text(
                      'Patients',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: PatientListView(patients: state.patients),
                  ),
                ],
              ),
            );
          } else if (state is AuthFailure) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: DoctorNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
