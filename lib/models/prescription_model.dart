import 'dart:ffi';

class PrescriptionModel {
  final String id; 
  final String drugClass;
  final String medication;
  final Double dosage;
  final String instructions;

  PrescriptionModel({
    required this.id,
    required this.drugClass,
    required this.medication,
    required this.dosage,
    required this.instructions,
  });

}