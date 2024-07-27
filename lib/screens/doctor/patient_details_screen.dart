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
                  .where('username', isEqualTo: patientName)
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
                                MediaQuery.of(context).size.height * 2 / 9,
                            flexibleSpace: FlexibleSpaceBar(
                              title: Text(
                                patientName,
                                style: const TextStyle(
                                  fontFamily: 'RobotoMono',
                                  fontSize: 32,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                'Patient Details Section',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              padding: const EdgeInsets.all(16),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Patient Name: $patientName',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Phone Number: $phoneNumber',
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Email: $email',
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Display prescriptions
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'Prescriptions',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
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
                                // Customize how you display prescription details
                                return ListTile(
                                    title: Text(
                                        'Medicine Name: ${prescription['medication']}'),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Dosage: $prescriptionDosageString mg'),
                                        Text(
                                            'Instructions: ${prescription['instructions']}'),
                                      ],
                                    ));
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
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
