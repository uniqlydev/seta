import 'package:cloud_firestore/cloud_firestore.dart';

class MedicationModel {
  final String id;
  final String dosage;
  final String drug;
  final String drugClass;
  final String sideEffect;

  MedicationModel({
    required this.id,
    required this.dosage,
    required this.drug,
    required this.drugClass,
    required this.sideEffect,
  });

  factory MedicationModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return MedicationModel(
      id: doc.id,
      dosage: data['dosage'],
      drug: data['drug'],
      drugClass: data['drugClass'],
      sideEffect: data['sideEffect'],
    );
  }
}
