import 'package:codingbryant/blocs/prescription_bloc/prescription_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrescriptionScreen extends StatefulWidget {
  const PrescriptionScreen({super.key});

  @override
  _PrescriptionScreenState createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  final TextEditingController _medicationClass = TextEditingController();
  final TextEditingController _dosage = TextEditingController();
  final TextEditingController _doctorRemarksClass = TextEditingController();
  final TextEditingController _patientId = TextEditingController();
  final TextEditingController _diagnosis = TextEditingController();

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
    _diagnosis.dispose();
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Row(
          children: [
            Icon(Icons.timer, color: Colors.blue), // Changed to red
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
            _diagnosis.clear();
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
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: true,
                snap: false,
                backgroundColor: Colors.blue,
                expandedHeight: MediaQuery.of(context).size.height * 1 / 12,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text(
                    'Prescription',
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  centerTitle: true,
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              children: [
                                Icon(Icons.local_hospital, color: Colors.blue), // Changed to red
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
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              children: [
                                Icon(Icons.medical_services, color: Colors.blue), // Changed to red
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
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              children: [
                                Icon(Icons.medical_services_outlined, color: Colors.blue), // Changed to red
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
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              children: [
                                Icon(Icons.numbers, color: Colors.blue), // Changed to red
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
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              children: [
                                Icon(Icons.schedule, color: Colors.blue), // Changed to red
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
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              children: [
                                Icon(Icons.note, color: Colors.blue), // Changed to red
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
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              children: [
                                Icon(Icons.person, color: Colors.blue), // Changed to red
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
                          const SizedBox(height: 40),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.red,
                                    minimumSize: Size(150, 45),
                                  ),
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    context.read<PrescriptionBloc>().add(
                                          PrescriptionCreate(
                                            doctorId: doctorUID,
                                            patientId: _patientId.text,
                                            medication: _medicationClass.text,
                                            dosage: double.parse(_dosage.text),
                                            drugClass: selectedDrugClass,
                                            instructions:
                                                '$selectedRegimen at ${_selectedTimes.where((time) => time != null).map((time) => time!.format(context)).join(', ')}',
                                            diagnosis: _diagnosis.text,
                                            time1: '', time2: '', time3: '',
                                          ),
                                        );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.blue,
                                    minimumSize: Size(150, 45),
                                  ),
                                  child: const Text('Create'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
