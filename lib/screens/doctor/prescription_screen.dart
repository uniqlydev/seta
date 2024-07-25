import 'package:codingbryant/blocs/prescription_bloc/prescription_bloc.dart';
import 'package:codingbryant/repositories/prescribe_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrescriptionScreen extends StatelessWidget {
  PrescriptionScreen({super.key});

  final TextEditingController _drugClass = TextEditingController();
  final TextEditingController _medicationClass = TextEditingController();
  final TextEditingController _dosage = TextEditingController();
  final TextEditingController _instructions = TextEditingController();
  final TextEditingController _doctorRemarksClass = TextEditingController();
  final TextEditingController _patientId = TextEditingController();

  final String doctorUID = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PrescriptionBloc, PrescriptionState>(
        listener: (context, state) {
          if (state is PrescriptionCreateLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is PrescriptionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            _drugClass.clear();
            _medicationClass.clear();
            _dosage.clear();
            _instructions.clear();
            _doctorRemarksClass.clear();
            // Navigate to dashboard
            Navigator.of(context).pushNamedAndRemoveUntil('/dashboard-doctor', (Route<dynamic> route) => false);
          } else if (state is PrescriptionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Prescription',
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 60,
                      fontWeight: FontWeight.w800,
                      color: Colors.blue,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            children: [
                              const Icon(Icons.medical_services),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: _drugClass,
                                  decoration: const InputDecoration(
                                    labelText: 'Drug Class',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            children: [
                              const Icon(Icons.medical_services_outlined),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: _medicationClass,
                                  decoration: const InputDecoration(
                                    labelText: 'Medication',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            children: [
                              const Icon(Icons.timer),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: _dosage,
                                  decoration: const InputDecoration(
                                    labelText: 'Recommended Dosage',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            children: [
                              const Icon(Icons.notes),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: _instructions,
                                  decoration: const InputDecoration(
                                    labelText: 'How to take the medicine?',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            children: [
                              const Icon(Icons.note),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: _doctorRemarksClass,
                                  decoration: const InputDecoration(
                                    labelText: 'Remarks (Optional)',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            children: [
                              const Icon(Icons.person),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: _patientId,
                                  decoration: const InputDecoration(
                                    labelText: 'For who?',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            context.read<PrescriptionBloc>().add(
                              PrescriptionCreate(
                                doctorId: doctorUID,
                                patientId: _patientId.text, // Make sure to use a valid patientId
                                medication: _medicationClass.text,
                                dosage: double.parse(_dosage.text),
                                drugClass: _drugClass.text,
                                instructions: _instructions.text,
                              ),
                            );
                          },
                          child: const Text('Create Prescription'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
