import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codingbryant/models/medication_model.dart';
import 'package:codingbryant/repositories/medication_repository.dart';
import 'package:equatable/equatable.dart';

part 'medication_event.dart';
part 'medication_state.dart';

class MedicationBloc extends Bloc<MedicationEvent, MedicationState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final MedicationRepository _medicationRepository;

  MedicationBloc({required MedicationRepository medicationRepository})
      : _medicationRepository = medicationRepository,
        super(MedicationInitial());

  @override
  Stream<MedicationState> mapEventToState(MedicationEvent event) async* {
    if (event is MedicationView) {
      yield* _mapMedicationViewToState();
    }
  }

  Stream<MedicationState> _mapMedicationViewToState() async* {
    yield const MedicationViewLoading(message: 'Viewing Medications...');

    try {
      QuerySnapshot querySnapshot = await _firestore.collection('drugs').get();
      List<MedicationModel> medications = querySnapshot.docs.map((doc) {
        return MedicationModel(
          id: doc.id,
          dosage: doc['dosage'],
          drug: doc['drug'],
          drugClass: doc['drugClass'],
          sideEffect: doc['sideEffect'],
        );
      }).toList();

      yield MedicationViewSuccess(medications: medications);
    } catch (e) {
      print("Failed to view medications: $e");
      yield MedicationFailure(message: 'Failed to view medications');
    }
  }
}
