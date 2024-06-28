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
      // Get the count of documents in the prescriptions collection
      QuerySnapshot querySnapshot = await _firestore.collection('prescriptions').get();
      int count = querySnapshot.size;

      // Generate the next id based on the count
      String nextId = (count + 1).toString();

      await _firestore.collection('prescriptions').doc(nextId).set({
        'doctorId': event.doctorId,
        'patientId': event.patientId,
        'id': nextId,
        'medication': event.medication,
        'dosage': event.dosage,
        'drugClass': event.drugClass,
        'instructions': event.instructions,
      });

      print("Prescription Created Successfully");
      emit(const PrescriptionSuccess(message: 'Prescription Created Successfully'));
    } catch (e) {
      print("Failed to create prescription: $e");
      emit(const PrescriptionFailure(message: 'Failed to create prescription'));
    }
  }
}
