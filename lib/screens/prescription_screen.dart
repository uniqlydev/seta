import 'package:flutter/material.dart';

class PrescriptionScreen extends StatelessWidget {
  const PrescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Prescription',
          style: TextStyle(color: Colors.white), // Set the color of the text to white
        ),
        backgroundColor: Colors.blue, // Set the color of the AppBar
      ),
      body: const Center(
        child: Text('Prescription Content Here'),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PrescriptionScreen(),
    );
  }
}
