part of 'medication_bloc.dart';

sealed class MedicationState extends Equatable {
  const MedicationState();

  @override
  List<Object> get props => [];
}

final class MedicationInitial extends MedicationState {}

final class MedicationViewLoading extends MedicationState {
  final String message;

  const MedicationViewLoading({required this.message});

  @override
  List<Object> get props => [message];
}

final class MedicationViewSuccess extends MedicationState {
  final List<MedicationModel> medications;

  const MedicationViewSuccess({required this.medications});

  @override
  List<Object> get props => [medications];
}

final class MedicationFailure extends MedicationState {
  final String message;

  const MedicationFailure({required this.message});

  @override
  List<Object> get props => [message];
}
