import 'package:flutter/material.dart';

class PrescriptionScreen extends StatelessWidget {
  PrescriptionScreen({super.key});

  final TextEditingController _drugClassController = TextEditingController();
  final TextEditingController _medicationController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  final TextEditingController _instructionController = TextEditingController();
  final TextEditingController _doctorRemarksController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Prescription',
          style: TextStyle(color: Colors.white), // Set the color of the text to white
        ),
        backgroundColor: Colors.blue, // Set the color of the AppBar
      ),body: Scaffold(
        body: Center(
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
                Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:30.0),
                        child: Row(
                          children: [
                            Icon(Icons.person),
                            Expanded(
                              child: TextFormField(
                                controller: _drugClassController,
                                decoration: const InputDecoration(
                                  labelText: 'Drug Class',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:30.0),
                        child: Row(
                          children: [
                            Icon(Icons.person),
                            Expanded(
                              child: TextFormField(
                                controller: _medicationController,
                                decoration: const InputDecoration(
                                  labelText: 'Medication',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:30.0),
                        child: Row(
                          children: [
                            Icon(Icons.person),
                            Expanded(
                              child: TextFormField(
                                controller: _dosageController,
                                decoration: const InputDecoration(
                                  labelText: 'Dosage',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:30.0),
                        child: Row(
                          children: [
                            Icon(Icons.person),
                            Expanded(
                              child: TextFormField(
                                controller: _instructionController,
                                decoration: const InputDecoration(
                                  labelText: 'Instruction',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:30.0),
                        child: Row(
                          children: [
                            Icon(Icons.person),
                            Expanded(
                              child: TextFormField(
                                controller: _doctorRemarksController,
                                decoration: const InputDecoration(
                                  labelText: 'Doctor Remarks',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:30.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Add code to save the prescription
                            Navigator.pushNamed(context, '/prescription-confirm');
                          },
                          child: const Text('Save Prescription'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}