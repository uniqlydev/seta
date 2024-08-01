import 'package:codingbryant/screens/explicit_animation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50), // Add space between animation and SETA text
            SizedBox(
              height: 200, // Adjust the height as needed
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Positioned(
                    top: 0,
                    child: ExplicitAnimations(),
                  ),
                  Positioned(
                    bottom: 30,
                    child: Container(
                      // Set the width to match the text's width
                      child: const Text(
                        'SETA',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.w900,
                          color: Colors.blue, // Set text color to blue
                          shadows: [
                            Shadow(blurRadius: 5, color: Colors.blueGrey)
                          ], // Add drop shadow
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register-patient');
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5, // Add elevation
                    shadowColor: Colors.black, // Add shadow color
                    backgroundColor: Colors.greenAccent, // Set background color for patient
                  ),
                  child: const Text(
                    'Register as Patient',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register-doctor');
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5, // Add elevation
                    shadowColor: Colors.black, // Add shadow color
                    backgroundColor: Colors.redAccent, // Set background color for doctor
                  ),
                  child: const Text(
                    'Register as Physician',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                elevation: 5, // Add elevation
                shadowColor: Colors.black, // Add shadow color
                backgroundColor: Colors.blue, // Set background color to blue
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set text color to white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

