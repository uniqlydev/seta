import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codingbryant/screens/doctor/doctor_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:codingbryant/blocs/user_bloc/auth_bloc.dart'; // Ensure this import matches your project structure

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  _DoctorProfileScreenState createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  int _selectedIndex = 2;
  bool _isEditing = false;

  final TextEditingController _clinicNameController = TextEditingController();
  final TextEditingController _clinicHoursController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveProfile(String userId) async {
    // Collect data from text controllers
    final clinicName = _clinicNameController.text;
    final clinicHours = _clinicHoursController.text;

    try {
      // Reference to the user's document in Firestore
      final doctorDocRef =
          FirebaseFirestore.instance.collection('doctors').doc(userId);

      // Update the user's document with new data
      await doctorDocRef.update({
        'clinic_name': clinicName,
        'clinic_hours': clinicHours,
      });

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    } catch (e) {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $e')),
      );
    }

    // Toggle editing mode after saving
    _toggleEditing();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Doctor Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
<<<<<<< HEAD
          if (state is AuthAuthenticatedDoctor) {
=======
          if (state is AuthAuthenticated) {
            // Initialize controllers with current data
            _clinicNameController.text = state.clinicName ?? '';
            _clinicHoursController.text = state.clinicHours ?? '';

>>>>>>> development
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1 / 9,
                  width: double.infinity,
                  child: const Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Circular icon in the middle
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.red,
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 15,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    '${state.firstName} ${state.lastName}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 15,
                            ),
                            margin: const EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.email,
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    state.email,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _clinicNameController,
                            enabled: _isEditing,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.local_hospital,
                                  color: Colors.blue),
                              labelText: 'Clinic Name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _clinicHoursController,
                            enabled: _isEditing,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.access_time, color: Colors.blue),
                              labelText: 'Clinic Hours',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_isEditing) {
                                  final userId = (context.read<AuthBloc>().state
                                          as AuthAuthenticated)
                                      .user
                                      .uid;
                                  _saveProfile(userId);
                                } else {
                                  _toggleEditing();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blue, // Text color
                                shadowColor: Colors.black,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                              ),
                              child: Text(
                                  _isEditing ? 'Save Profile' : 'Edit Profile'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
