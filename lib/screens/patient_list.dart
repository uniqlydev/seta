import 'package:flutter/material.dart';
import 'package:codingbryant/models/PatientModel.dart';

class PatientListView extends StatelessWidget {
  final List<Patient> patients;

  const PatientListView({Key? key, required this.patients}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: patients.length,
      itemBuilder: (context, index) {
        final patient = patients[index];
        return InkWell(
          onTap: () {
            // Handle onTap for "Patient Info"
            // Navigate to the page for viewing patient info
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            width: double.infinity,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 13),
                  child: Icon(
                    Icons.personal_injury_rounded,
                    size: 50,
                    color: Colors.redAccent,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      patient.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Diagnosis: ${patient.diagnosis}',
                      style: const TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
