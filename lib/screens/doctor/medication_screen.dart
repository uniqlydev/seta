import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codingbryant/blocs/user_bloc/auth_bloc.dart';
import 'package:codingbryant/models/medication_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicationScreen extends StatefulWidget {
  const MedicationScreen({super.key});

  @override
  _MedicationScreenState createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  late List<MedicationModel> medications = [];

  @override
  void initState() {
    super.initState();
    _fetchMedications();
  }

  void _fetchMedications() async {
    try {
      // Replace 'drugs' with your Firestore collection name
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('drugs').get();

      List<MedicationModel> fetchedMedications = snapshot.docs
          .map((doc) => MedicationModel.fromFirestore(doc))
          .toList();

      setState(() {
        medications = fetchedMedications;
      });
    } catch (e) {
      print('Error fetching medications: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    snap: false,
                    backgroundColor: Colors.blue,
                    expandedHeight: MediaQuery.of(context).size.height * 2 / 9,
                    flexibleSpace: const FlexibleSpaceBar(
                      title: Text(
                        'Medications',
                        style: TextStyle(
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
              body: ListView.builder(
                itemCount: medications.length,
                itemBuilder: (context, index) {
                  MedicationModel medication = medications[index];
                  return ListTile(
                    title: Text(medication.drug),
                    subtitle: Text(medication.dosage),
                    onTap: () {
                      // Pop up to show the remaining details of the medication
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(medication.drug),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Frequency: ${medication.drugClass}'),
                                Text('Dosage: ${medication.sideEffect}'),
                              ],
                            ),
                            contentPadding:
                                const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0),
                            contentTextStyle: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    // Add more details or actions as needed
                  );
                },
              ),
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
