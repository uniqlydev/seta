class PrescriptionModel {
  final String id;
  final String drugClass;
  final String medication;
  final double dosage;
  final String instructions;
  final String time1;
  final String time2;
  final String time3;
  final bool time1Taken;
  final bool time2Taken;
  final bool time3Taken;

  PrescriptionModel({
    required this.id,
    required this.drugClass,
    required this.medication,
    required this.dosage,
    required this.instructions,
    required this.time1,
    required this.time2,
    required this.time3,
    this.time1Taken = false,
    this.time2Taken = false,
    this.time3Taken = false,
  });
}