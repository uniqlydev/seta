import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting

class DashboardDoctorScreen extends StatelessWidget {
  const DashboardDoctorScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    // Get the current date
    DateTime now = DateTime.now();
    
    // Format the date
    String formattedDate = DateFormat('MMM d yyyy').format(now);

    return Scaffold(
      body: Column(
        children: [
          // Container for the header
          Container(
            height: MediaQuery.of(context).size.height * 2 / 9, // Adjusted height to 2/10
            width: double.infinity,
            color: Colors.blue,
            child: const Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // controller to change the name to the user logged in
                        SizedBox(width: 10),
                        Text(
                          'Hello, Dr. Bryant!',
                          style: TextStyle(
                            fontFamily: 'RobotoMono',
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0), // Adjusted height to bring down the text
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 5), // Adjust as needed
                        Padding(
                          padding: EdgeInsets.only(top: 0, left: 7, right: 10), // Adjusted padding
                          child: Text(
                            "Let's see our agenda",
                            style: TextStyle(
                              fontFamily: 'RobotoMono',
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Container for the date
          const SizedBox(height: 35), // Adjusted height to 20 (from 10)
          
          // Row for the boxed icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  // Handle onTap for "Medication"
                  // Navigate to the page for looking at reference for medication
                },
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.redAccent, // Change the color as needed
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
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.medication_rounded,
                        size: 60,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Medication',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // Handle onTap for "Prescribe"
                  // Navigate to the page for prescribing medication
                },
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.blue, // Change the color as needed
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
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.medical_services_rounded,
                        size: 60,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Prescribe',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Placeholder for additional content
          const SizedBox(height: 20), // Adjusted height to 20 (from 10)
          const Padding(
            padding: EdgeInsets.fromLTRB(35.0, 12, 0.0, 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Patients',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
       
    //list of   patients
       Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    InkWell(
      onTap: () {
        // Handle onTap for "Patient Info"
        // Navigate to the page for viewing patient info
      },
      child: Container(
        width: 370,
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
        child: const Row(
          children: [
            SizedBox(width: 20),
            Icon(
              Icons.personal_injury_rounded,
              size: 50,
              color: Colors.redAccent,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Brendan Pecson',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Diagnosis: Love Sick',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    const SizedBox(height: 20),
    InkWell(
      onTap: () {
        // Handle onTap for "Patient Info"
        // Navigate to the page for viewing patient info
      },
      child: Container(
        width: 370,
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
        child: const Row(
          children: [
            SizedBox(width: 20),
            Icon(
              Icons.personal_injury_rounded,
              size: 50,
              color: Colors.redAccent,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Brendan Pecson',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Diagnosis: Love Sick',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  ],
),
        ],
      ),
    );
  }
}