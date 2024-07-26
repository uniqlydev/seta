import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        title: const Text('Coding Bryant'),
        backgroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Welcome to Coding Bryant', style: TextStyle(color: Colors.white, fontSize: 24)),
      ),
    );
  }
}