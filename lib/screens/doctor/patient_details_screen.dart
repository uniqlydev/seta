import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codingbryant/blocs/user_bloc/auth_bloc.dart'; // Adjust import as per your project structure

class PatientDetailsScreen extends StatelessWidget {
  final String patientName;

  const PatientDetailsScreen({Key? key, required this.patientName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticatedDoctor) {
            // Fetch patient details
            return FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('patients')
                  .where('first_name', isEqualTo: patientName)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                      child: Text('Error: ${snapshot.error.toString()}'));
                }

                if (snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('Patient not found'));
                }

                // Patient found, assume there's only one matching document
                var patientData =
                    snapshot.data!.docs.first.data() as Map<String, dynamic>;
                String phoneNumber =
                    patientData['phone_number'] ?? 'Phone number not available';
                String email = patientData['email'] ?? 'Email not available';
                String age = patientData['bday']; // Placeholder
                String diagnosis = 'Diagnosis here'; // Placeholder
                String dateOfLastCheckUp = 'Last Check-Up'; // Placeholder
                String height = patientData['height']; // Placeholder
                String weight = patientData['weight']; // Placeholder

                // Fetch prescriptions for the patient
                return FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('prescriptions')
                      .where('patientId', isEqualTo: patientName)
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> prescriptionsSnapshot) {
                    if (prescriptionsSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (prescriptionsSnapshot.hasError) {
                      return Center(
                          child: Text(
                              'Error: ${prescriptionsSnapshot.error.toString()}'));
                    }

                    // Prepare prescriptions data
                    List<QueryDocumentSnapshot> prescriptions =
                        prescriptionsSnapshot.data!.docs;

                    // Build UI with retrieved data
                    return NestedScrollView(
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          SliverAppBar(
                            pinned: true,
                            floating: true,
                            snap: false,
                            backgroundColor: Colors.blue,
                            expandedHeight:
                                MediaQuery.of(context).size.height * 1 / 9, // Decreased height
                            flexibleSpace: const FlexibleSpaceBar(
                              title: Text(
                                'Patient Details',
                                style: TextStyle(
                                  fontFamily: 'RobotoMono',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                              centerTitle: true,
                            ),
                          ),
                        ];
                      },
                      body: SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0), // Padding around the entire content
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20), // Added spacing
                            // Patient name
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                ' $patientName',
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10), // Spacing between name and diagnosis
                            // Diagnosis
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'Diagnosis: $diagnosis',
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20), // Spacing between diagnosis and details
                            // Display patient details in two columns
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.calendar_today, color: Colors.red),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                dateOfLastCheckUp,
                                                style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Icon(Icons.height, color: Colors.red),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                height,
                                                style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Icon(Icons.monitor_weight, color: Colors.red),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                weight,
                                                style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20), // Spacing between columns
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.phone, color: Colors.red),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                phoneNumber,
                                                style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Icon(Icons.email, color: Colors.red),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                email,
                                                style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Icon(Icons.cake, color: Colors.red),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                age,
                                                style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20), // Spacing between patient details and prescriptions
                            // Display prescriptions
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'Prescriptions',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54
                                ),
                              ),
                            ),
                            const SizedBox(height: 5), // Increased spacing above prescriptions
                            // Display each prescription in a centered container
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: prescriptions.length,
                              itemBuilder: (context, index) {
                                var prescription = prescriptions[index].data()
                                    as Map<String, dynamic>;
                                double prescriptionDosage =
                                    prescription['dosage'] ??
                                        'Dosage not available';
                                String prescriptionDosageString =
                                    prescriptionDosage.toStringAsFixed(
                                        2); // Format dosage to 2 decimal places
                                String prescriptionDiagnosis =
                                    prescription['diagnosis'] ?? 'Diagnosis not available';
                                return Center(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 8),
                                    padding: const EdgeInsets.all(16),
                                    width: MediaQuery.of(context).size.width * 0.9, // Adjust width as needed
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Medication: ${prescription['medication']}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Dosage: $prescriptionDosageString mg',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Diagnosis: $prescriptionDiagnosis',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is AuthFailure) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            // Handle unauthenticated or other states
            return Padding(
              padding: const EdgeInsets.all(16.0), // Padding for the entire screen
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'You need to be logged in to view patient details.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to login screen or authentication page
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
