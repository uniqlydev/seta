part of 'prescription_bloc.dart';

abstract class PrescriptionEvent extends Equatable {


  @override
  List<Object> get props => [];
}

class PrescriptionCreate extends PrescriptionEvent {
  final String doctorId;
  final String patientId;
  final String medication;
  final double dosage;
  final String drugClass;
  final String instructions;

  PrescriptionCreate({
    required this.doctorId,
    required this.patientId,
    required this.medication,
    required this.dosage,
    required this.drugClass,
    required this.instructions,
  });

  @override
  List<Object> get props => [patientId, doctorId];
}


