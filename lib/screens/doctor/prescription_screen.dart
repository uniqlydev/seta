import 'package:codingbryant/blocs/prescription_bloc/prescription_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrescriptionScreen extends StatefulWidget {
  PrescriptionScreen({super.key});

  @override
  _PrescriptionScreenState createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  final TextEditingController _medicationClass = TextEditingController();
  final TextEditingController _dosage = TextEditingController();
  final TextEditingController _doctorRemarksClass = TextEditingController();
  final TextEditingController _patientId = TextEditingController();

  final String doctorUID = FirebaseAuth.instance.currentUser!.uid;

  final List<String> drugClasses = [
    'Antihistamine',
    'Antidepressant',
    'Antibiotic',
    'Analgesic',
    'Antipyretic',
    'Antiseptic',
    'Antiviral',
    'Anti-inflammatory',
    'Bronchodilator',
    'Diuretic'
  ];

  final List<String> timeChoices = ['OD', 'BID', 'TID'];
  String selectedDrugClass = 'Antihistamine';
  String selectedRegimen = 'OD';

  final List<TimeOfDay?> _selectedTimes = [null, null, null];

  @override
  void dispose() {
    _medicationClass.dispose();
    _dosage.dispose();
    _doctorRemarksClass.dispose();
    _patientId.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context, int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTimes[index]) {
      setState(() {
        _selectedTimes[index] = picked;
      });
    }
  }

  List<Widget> _buildTimeFields() {
    int numberOfFields = 0;
    switch (selectedRegimen) {
      case 'OD':
        numberOfFields = 1;
        break;
      case 'BID':
        numberOfFields = 2;
        break;
      case 'TID':
        numberOfFields = 3;
        break;
    }

    return List.generate(numberOfFields, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: Row(
          children: [
            const Icon(Icons.timer),
            const SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                onTap: () => _selectTime(context, index),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: _selectedTimes[index] == null
                          ? 'Select Time'
                          : _selectedTimes[index]!.format(context),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

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
            _medicationClass.clear();
            _dosage.clear();
            _doctorRemarksClass.clear();
            _selectedTimes.fillRange(0, _selectedTimes.length, null);
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/dashboard-doctor', (Route<dynamic> route) => false);
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
                                child: DropdownButtonFormField<String>(
                                  value: selectedDrugClass,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedDrugClass = value!;
                                    });
                                  },
                                  items: drugClasses.map((String choice) {
                                    return DropdownMenuItem<String>(
                                      value: choice,
                                      child: Text(choice),
                                    );
                                  }).toList(),
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
                                  keyboardType: TextInputType.number,
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
                              const Icon(Icons.schedule),
                              const SizedBox(width: 10),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: selectedRegimen,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedRegimen = value!;
                                    });
                                  },
                                  items: timeChoices.map((String choice) {
                                    return DropdownMenuItem<String>(
                                      value: choice,
                                      child: Text(choice),
                                    );
                                  }).toList(),
                                  decoration: const InputDecoration(
                                    labelText: 'Dosage Regimen',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        ..._buildTimeFields(),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red, // Set the background color to red
                              ),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () {
                                final times = _selectedTimes
                                    .take(timeChoices.indexOf(selectedRegimen) + 1)
                                    .where((time) => time != null)
                                    .map((time) => time!.format(context))
                                    .toList();
                                context.read<PrescriptionBloc>().add(
                                      PrescriptionCreate(
                                        doctorId: doctorUID,
                                        patientId: _patientId.text,
                                        medication: _medicationClass.text,
                                        dosage: double.parse(_dosage.text),
                                        drugClass: selectedDrugClass,
                                        instructions:
                                            '$selectedRegimen at ${times.join(', ')}',
                                      ),
                                    );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue, // Set the background color to blue
                              ),
                              child: const Text(
                                'Create Prescription',
                                style: TextStyle(color: Colors.white),
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
          );
        },
      ),
    );
  }
}
