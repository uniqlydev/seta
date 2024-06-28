import 'package:codingbryant/blocs/prescription_bloc/prescription_bloc.dart';
import 'package:codingbryant/repositories/prescribe_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrescriptionScreen extends StatelessWidget {
  PrescriptionScreen({super.key});

  final TextEditingController _drugClass = TextEditingController();
  final TextEditingController _medicationClass = TextEditingController();
  final TextEditingController _dosage = TextEditingController();
  final TextEditingController _instructions = TextEditingController();
  final TextEditingController _doctorRemarksClass = TextEditingController();

  final String doctorUID = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PrescriptionBloc(prescriptionRepository: PrescribeRepository()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Prescription'),
        ),
        body: BlocListener<PrescriptionBloc, PrescriptionState>(
          listener: (context, state) {
            if (kDebugMode) {
              print('Current state: $state');
            }
            if (state is PrescriptionCreateLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is PrescriptionSuccess) {
              if (kDebugMode) {
                print("Navigation to /dashboard-doctor");
              }
              Navigator.of(context).pushNamedAndRemoveUntil('/dashboard-doctor', (Route<dynamic> route) => false);
            } else if (state is PrescriptionFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _drugClass,
                  decoration: const InputDecoration(
                    labelText: 'Drug Class',
                  ),
                ),
                TextField(
                  controller: _medicationClass,
                  decoration: const InputDecoration(
                    labelText: 'Medication',
                  ),
                ),
                TextField(
                  controller: _dosage,
                  decoration: const InputDecoration(
                    labelText: 'Dosage',
                  ),
                ),
                TextField(
                  controller: _instructions,
                  decoration: const InputDecoration(
                    labelText: 'Instructions',
                  ),
                ),
                TextField(
                  controller: _doctorRemarksClass,
                  decoration: const InputDecoration(
                    labelText: 'Doctor Remarks',
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (kDebugMode) {
                      print("Create Prescription Button Pressed");
                    }
                    BlocProvider.of<PrescriptionBloc>(context).add(
                      PrescriptionCreate(
                        doctorId: doctorUID,
                        patientId: '',
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
        ),
      ),
    );
  }
}
