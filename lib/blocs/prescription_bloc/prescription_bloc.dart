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
      await _firestore.collection('prescriptions').doc(event.id).set({
        'doctorId': event.doctorId,
        'patientId': event.patientId,
        'prescription': event.prescription,
        'id': event.id,
        'medication': event.medication,
        'dosage': event.dosage,
        'drugClass': event.drugClass,
        'instructions': event.instructions,
      });

      emit(const PrescriptionSuccess(message: 'Prescription Created Successfully'));
    } catch (e) {
      emit(const PrescriptionFailure(message: 'Failed to create prescription'));
    }
  }

  Stream<PrescriptionState> mapEventToState(PrescriptionEvent event, Emitter<PrescriptionState> emit) async* {
    if (event is PrescriptionCreate) {
      try {
        await _prescriptionRepository.createPrescription(
          doctorId: event.doctorId,
          patientId: event.patientId,
          prescription: event.prescription,
          id: event.id,
          medication: event.medication,
          dosage: event.dosage,
          drugClass: event.drugClass,
          instructions: event.instructions,
        );
        emit(const PrescriptionSuccess(message: 'Prescription Created Successfully'));
      } on Exception {
        emit(const PrescriptionFailure(message: 'Failed to create prescription'));
      }
    }
  }
}
