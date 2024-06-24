import 'package:flutter/material.dart';

class DashboardPatientScreen extends StatefulWidget {
  const DashboardPatientScreen({Key? key}) : super(key: key);

  @override
  _DashboardPatientScreenState createState() => _DashboardPatientScreenState();
}

class _DashboardPatientScreenState extends State<DashboardPatientScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Patient Dashboard'),
      ),
    );
  }
}
