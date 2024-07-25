import 'package:cloud_firestore/cloud_firestore.dart';

class PrescribeRepository {
  final FirebaseFirestore _firestore;

  PrescribeRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> createPrescription({
    required String doctorId,
    required String patientId,
    required String prescription,
    required String id,
    required String medication,
    required double dosage,
    required String drugClass,
    required String instructions,
  }) async {
    try {
      await _firestore.collection('prescriptions').doc(id).set({
        'doctorId': doctorId,
        'patientId': patientId,
        'prescription': prescription,
        'id': id,
        'medication': medication,
        'dosage': dosage,
        'drugClass': drugClass,
        'instructions': instructions,
      });
    } catch (e) {
      rethrow;
    }
  }
}