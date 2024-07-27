import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codingbryant/repositories/prescribe_repository.dart';
import 'package:equatable/equatable.dart';

part 'prescription_event.dart';
part 'prescription_state.dart';

class PrescriptionBloc extends Bloc<PrescriptionEvent, PrescriptionState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final PrescribeRepository _prescriptionRepository;

  PrescriptionBloc({required PrescribeRepository prescriptionRepository})
      : _prescriptionRepository = prescriptionRepository,
        super(PrescriptionInitial()) {
    on<PrescriptionCreate>(_onPrescriptionCreateRequest);
  }

Future<void> _onPrescriptionCreateRequest(PrescriptionCreate event, Emitter<PrescriptionState> emit) async {
  emit(const PrescriptionCreateLoading(message: 'Creating Prescription...'));

  try {
    // Retrieve the UID of the patient using the patient username
    QuerySnapshot patientSnapshot = await _firestore.collection('patients')
        .where('username', isEqualTo: event.patientId)
        .limit(1)
        .get();

    if (patientSnapshot.docs.isEmpty) {
      throw Exception('Patient not found');
    }



    QuerySnapshot querySnapshot = await _firestore.collection('patients')
                                  .where('username', isEqualTo: event.patientId)
                                  .get();

    int count = querySnapshot.size;



    String uidOfPatient = patientSnapshot.docs.first.id;


    // Create sub-collection then insert
    await _firestore.collection('patients')
        .doc(uidOfPatient)
        .collection('prescriptions')
        .doc()
        .set({
          'doctorId': event.doctorId,
          'medication': event.medication,
          'dosage': event.dosage,
          'drugClass': event.drugClass,
          'instructions': event.instructions,
        });

    await _firestore.collection('doctors')
          .doc(event.doctorId)
          .collection('patients')
          .doc(uidOfPatient)
          .collection('prescriptions')
          .doc()
          .set({
            'doctorId': event.doctorId,
            'medication': event.medication,
            'dosage': event.dosage,
            'drugClass': event.drugClass,
            'instructions': event.instructions,
          });

      await _firestore.collection('doctors')
          .doc(event.doctorId)
          .collection('patients')
          .doc(uidOfPatient)
          .set({
            'doctorId': event.doctorId,
            'patientId': uidOfPatient,
          });

    emit(const PrescriptionSuccess(message: 'Prescription Created Successfully'));
  } catch (e) {
    emit(const PrescriptionFailure(message: 'Failed to create prescription'));
  }
}

}
