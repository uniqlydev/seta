import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codingbryant/screens/patient/patient_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:codingbryant/blocs/user_bloc/auth_bloc.dart'; // Ensure this import matches your project structure

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({super.key});

  @override
  _PatientProfileScreenState createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  int _selectedIndex = 2;
  bool _isEditing = false;

  String _selectedWeightUnit = 'KG';
  String _selectedHeightUnit = 'CM';
  String _selectedBloodType = 'A+';

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _bloodTypeController = TextEditingController();

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
    final phoneNumber = _phoneController.text;
    final email = _emailController.text;
    final birthday = _birthdayController.text;
    final weight = _weightController.text;
    final height = _heightController.text;
    final bloodType = _selectedBloodType;

    // Convert birthday String to DateTime
    final birthdayDate = DateTime.parse(birthday);

    // Convert birthdayDate to Timestamp
    final birthdayTimestamp = Timestamp.fromDate(birthdayDate);

    try {
      // Reference to the user's document in Firestore
      final userDocRef =
          FirebaseFirestore.instance.collection('patients').doc(userId);

      // Update the user's document with new data
      await userDocRef.update({
        'phone_number': phoneNumber,
        'email': email,
        'birthday': birthdayTimestamp,
        'weight': weight,
        'height': height,
        'blood_type': bloodType,
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

  void _logout() {
    // Placeholder for logout functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logout button pressed')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Profile',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            onPressed: _logout,
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticatedPatient) {
            // Initialize controllers with current data
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
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _phoneController,
                            enabled: _isEditing,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.phone, color: Colors.blue),
                              labelText: 'Phone Number',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _emailController,
                            enabled: _isEditing,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.email, color: Colors.blue),
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _birthdayController,
                            enabled: _isEditing,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.cake, color: Colors.blue),
                              labelText: 'Birthday',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _weightController,
                                  enabled: _isEditing,
                                  decoration: InputDecoration(
                                    icon: const Icon(Icons.line_weight,
                                        color: Colors.blue),
                                    labelText: 'Weight',
                                    border: const OutlineInputBorder(),
                                    suffixIcon: DropdownButton<String>(
                                      value: _selectedWeightUnit,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      onChanged: _isEditing
                                          ? (String? newValue) {
                                              setState(() {
                                                _selectedWeightUnit = newValue!;
                                              });
                                            }
                                          : null,
                                      items: <String>['KG', 'LBS']
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: _heightController,
                                  enabled: _isEditing,
                                  decoration: InputDecoration(
                                    icon: const Icon(Icons.height,
                                        color: Colors.blue),
                                    labelText: 'Height',
                                    border: const OutlineInputBorder(),
                                    suffixIcon: DropdownButton<String>(
                                      value: _selectedHeightUnit,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      onChanged: _isEditing
                                          ? (String? newValue) {
                                              setState(() {
                                                _selectedHeightUnit = newValue!;
                                              });
                                            }
                                          : null,
                                      items: <String>['CM', 'FT']
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            enabled: _isEditing,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.bloodtype,
                                  color: Colors.blue),
                              labelText: 'Blood Type',
                              border: const OutlineInputBorder(),
                              suffixIcon: DropdownButton<String>(
                                value: _selectedBloodType,
                                icon: const Icon(Icons.arrow_drop_down),
                                onChanged: _isEditing
                                    ? (String? newValue) {
                                        setState(() {
                                          _selectedBloodType = newValue!;
                                        });
                                      }
                                    : null,
                                items: <String>[
                                  'A+',
                                  'A-',
                                  'B+',
                                  'B-',
                                  'AB+',
                                  'AB-',
                                  'O+',
                                  'O-'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_isEditing) {
                                  final userId = (context.read<AuthBloc>().state
                                          as AuthAuthenticatedPatient)
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
      bottomNavigationBar: PatientNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
