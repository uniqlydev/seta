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
  final String diagnosis;
  final String time1;
  final String time2;
  final String time3;


  const PrescriptionCreate({
    required this.doctorId,
    required this.patientId,
    required this.medication,
    required this.dosage,
    required this.drugClass,
    required this.instructions, 
    required this.diagnosis,
    required this.time1,
    required this.time2,
    required this.time3,
  });

  @override
  List<Object> get props => [doctorId, patientId, medication, dosage, drugClass, instructions];
}
