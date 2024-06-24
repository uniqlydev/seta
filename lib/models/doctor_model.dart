import 'package:codingbryant/models/patient_model.dart';

class DoctorModel {
  final String id; 
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String userType = 'D';
  final List<PatientModel> patients = List<PatientModel>.empty(growable: true);

  DoctorModel({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
  });
}