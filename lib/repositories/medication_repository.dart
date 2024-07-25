import 'package:cloud_firestore/cloud_firestore.dart';

class MedicationRepository {
  final FirebaseFirestore _firestore;

  MedicationRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> createMedication({
    required String dosage,
    required String drug,
    required String drugClass,
    required double sideEffect,
  }) async {
    try {
      await _firestore.collection('medications').add({
        'dosage': dosage,
        'drug': drug,
        'drugClass': drugClass,
        'sideEffect': sideEffect,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> viewMedications() async {
    try {
      await _firestore.collection('medications').get();
    } catch (e) {
      rethrow;
    }
  }
}
