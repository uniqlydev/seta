import 'package:codingbryant/models/prescription_model.dart';

class PatientModel {
  final String id; 
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String userType = 'P';
  final String gender;
  final List<PrescriptionModel> prescriptions = List<PrescriptionModel>.empty(growable: true);

  PatientModel({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.gender
  });

  void addPrescription(PrescriptionModel prescription) {
    prescriptions.add(prescription);
  }
}