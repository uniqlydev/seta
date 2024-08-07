import 'package:cloud_firestore/cloud_firestore.dart';
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
  final TextEditingController _diagnosis = TextEditingController();
  final TextEditingController _time1 = TextEditingController();
  final TextEditingController _time2 = TextEditingController();
  final TextEditingController _time3 = TextEditingController();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

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
  String? selectedPatient;

  List<String> patientUsernames = [];

  @override
  void initState() {
    super.initState();
    _getPatientUsernames();
  }

  Future<void> _getPatientUsernames() async {
    final snapshot = await _firebaseFirestore.collection('patients').get();
    setState(() {
      patientUsernames = snapshot.docs.map((doc) => doc['username'] as String).toList();
    });
  }

  @override
  void dispose() {
    _medicationClass.dispose();
    _dosage.dispose();
    _doctorRemarksClass.dispose();
    _diagnosis.dispose();
    _time1.dispose();
    _time2.dispose();
    _time3.dispose();
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
            const Icon(Icons.timer, color: Colors.blue),
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
          if (state is PrescriptionSuccess) {
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
          // Set the text of the time fields based on selected times
          _time1.text = _selectedTimes[0]?.format(context) ?? '';
          _time2.text = _selectedTimes[1]?.format(context) ?? '';
          _time3.text = _selectedTimes[2]?.format(context) ?? '';

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: true,
                snap: false,
                backgroundColor: Colors.blue,
                expandedHeight: MediaQuery.of(context).size.height * 1 / 12,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text(
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
                                const Icon(Icons.local_hospital, color: Colors.blue),
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
                                const Icon(Icons.medical_services, color: Colors.blue),
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
                                const Icon(Icons.medical_services_outlined, color: Colors.blue),
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
                                const Icon(Icons.numbers, color: Colors.blue),
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
                                const Icon(Icons.schedule, color: Colors.blue),
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
                                const Icon(Icons.note, color: Colors.blue),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                    controller: _doctorRemarksClass,
                                    decoration: const InputDecoration(
                                      labelText: 'Until when?',
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
                                const Icon(Icons.person, color: Colors.blue),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: selectedPatient,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedPatient = value!;
                                      });
                                    },
                                    items: patientUsernames.map((String patient) {
                                      return DropdownMenuItem<String>(
                                        value: patient,
                                        child: Text(patient),
                                      );
                                    }).toList(),
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
                                    minimumSize: const Size(130, 45),
                                  ),
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    context.read<PrescriptionBloc>().add(
                                          PrescriptionCreate(
                                            doctorId: doctorUID,
                                            patientId: selectedPatient ?? '',
                                            medication: _medicationClass.text,
                                            dosage: double.parse(_dosage.text),
                                            drugClass: selectedDrugClass,
                                            instructions: '$selectedRegimen at ${_selectedTimes.where((time) => time != null).map((time) => time!.format(context)).join(', ')}',
                                            diagnosis: _diagnosis.text,
                                            time1: _time1.text, 
                                            time2: _time2.text, 
                                            time3: _time3.text,
                                          ),
                                        );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.blue,
                                    minimumSize: const Size(130, 45),
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