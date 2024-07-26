import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PatientPrescriptionDetails extends StatelessWidget {
  const PatientPrescriptionDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prescription Details'),
      ),
      body: Center(
        child: QrImageView(
          data: '1231321',
          size: 200.0,
          padding: const EdgeInsets.all(20.0),
        ),
      ),
    );
  }
}
