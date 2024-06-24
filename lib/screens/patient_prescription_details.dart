import 'package:flutter/material.dart';

class PatientPrescriptionDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescription Details'),
      ),
      body: Center(
        child: Text(
          'Patient Prescription Details',
          style: TextStyle(fontSize: 24),

        ),
      ),
    );
  }
}
