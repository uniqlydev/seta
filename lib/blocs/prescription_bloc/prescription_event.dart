part of 'prescription_bloc.dart';

abstract class PrescriptionEvent extends Equatable {
  const PrescriptionEvent();

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

  const PrescriptionCreate({
    required this.doctorId,
    required this.patientId,
    required this.medication,
    required this.dosage,
    required this.drugClass,
    required this.instructions, required String diagnosis, required String time1, required String time2, required String time3,
  });

  @override
  List<Object> get props => [doctorId, patientId, medication, dosage, drugClass, instructions];
}
