import 'package:flutter/material.dart';
import 'package:codingbryant/screens/doctor/patient_details_screen.dart';

class PatientListView extends StatelessWidget {
  final List<String>? patients;

  const PatientListView({Key? key, this.patients}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if the patients list is null or empty
    final isEmpty = patients == null || patients!.isEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0), // Add padding to ensure the SizedBox doesn't touch screen edges
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9, // Set the width of the SizedBox to 90% of screen width
        child: isEmpty
            ? Center(
                child: Text(
                  'No patients yet : )',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.zero, // Remove default padding
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: patients!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PatientDetailsScreen(patientName: patients![index]),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      width: MediaQuery.of(context).size.width * 0.85, // Set the width of the container to 85% of screen width
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
                                patients![index],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'Diagnosis: Placeholder text',
                                style: TextStyle(
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
              ),
      ),
    );
  }
}
