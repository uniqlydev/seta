import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:codingbryant/blocs/prescription_bloc/prescription_bloc.dart';

class PrescriptionScreen extends StatelessWidget {
  PrescriptionScreen({super.key});

  final TextEditingController _diagnosis = TextEditingController();
  final TextEditingController _drugClass = TextEditingController();
  final TextEditingController _medicationClass = TextEditingController();
  final TextEditingController _dosage = TextEditingController();
  final TextEditingController _instructions = TextEditingController();
  final TextEditingController _doctorRemarksClass = TextEditingController();
  final TextEditingController _patientId = TextEditingController();

  final String doctorUID = FirebaseAuth.instance.currentUser!.uid;

  final List<String> drugClasses = [
    'Antihistamine',
    'Antidepressant',
    'Antibiotic',
    'Antiviral',
    'Antifungal',
    'Analgesic',
    'Anti-inflammatory',
    'Antihypertensive',
    'Antidiabetic',
    'Other',
  ];

  final List<String> timeChoices = ['OD', 'BID', 'TID'];

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
            _diagnosis.clear();
            _drugClass.clear();
            _medicationClass.clear();
            _dosage.clear();
            _instructions.clear();
            _doctorRemarksClass.clear();
            _patientId.clear();
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        children: [
                          const Icon(Icons.assignment),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: _diagnosis,
                              decoration: const InputDecoration(
                                labelText: 'Diagnosis',
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
                          const Icon(Icons.medical_services),
                          const SizedBox(width: 10),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: null,
                              items: drugClasses.map((className) {
                                return DropdownMenuItem<String>(
                                  value: className,
                                  child: Text(className),
                                );
                              }).toList(),
                              onChanged: (value) {
                                // Handle drug class change
                              },
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
                          const Icon(Icons.numbers),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: _dosage,
                              decoration: const InputDecoration(
                                labelText: 'Dosage',
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
                            child: DropdownButtonFormField<String>(
                              items: timeChoices.map((choice) {
                                return DropdownMenuItem<String>(
                                  value: choice,
                                  child: Text(choice),
                                );
                              }).toList(),
                              onChanged: (value) {
                                // Handle dosage regimen change
                              },
                              decoration: const InputDecoration(
                                labelText: 'Dosage Regimen',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Go back
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            minimumSize: Size(150, 50),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<PrescriptionBloc>().add(
                              PrescriptionCreate(
                                doctorId: doctorUID,
                                patientId: _patientId.text,
                                medication: _medicationClass.text,
                                dosage: double.parse(_dosage.text),
                                drugClass: _drugClass.text,
                                instructions: _instructions.text,
                                // diagnosis: _diagnosis.text,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            minimumSize: Size(150, 50),
                          ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
