import 'package:codingbryant/blocs/prescription_bloc/prescription_bloc.dart';
import 'package:codingbryant/blocs/user_bloc/auth_bloc.dart';
import 'package:codingbryant/repositories/auth_repository.dart';
import 'package:codingbryant/repositories/prescribe_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrescriptionScreen extends StatelessWidget {
  PrescriptionScreen({super.key});

  final TextEditingController _drugClass = TextEditingController();
  final TextEditingController _medicationClass = TextEditingController();
  final TextEditingController _dosage = TextEditingController();
  final TextEditingController _instructions = TextEditingController();
  final TextEditingController _doctorRemarksClass = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PrescriptionBloc(prescriptionRepository: PrescribeRepository()),
          ),
          BlocProvider(
            create: (context) => AuthBloc(authRepository: AuthRepository()),
          )
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Prescription'),
          ),
          body: Padding(
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
                    BlocProvider.of<PrescriptionBloc>(context).add(
                      PrescriptionCreate(
                        doctorId: '1',
                        patientId: '1',
                        prescription: '1',
                        id: '1',
                        medication: _medicationClass.text,
                        dosage: double.parse(_dosage.text),
                        drugClass: _drugClass.text,
                        instructions: _instructions.text,
                      ),
                    );
                  },
                  child: const Text('Create Prescription'),
                )
              ]
            )
          )
        ),
      ),
    );
  }

}