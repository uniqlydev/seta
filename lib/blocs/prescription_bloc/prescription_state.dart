part of 'prescription_bloc.dart';

abstract class PrescriptionState extends Equatable {
  const PrescriptionState();
  
  @override
  List<Object> get props => [];
}

class PrescriptionInitial extends PrescriptionState {}

class PrescriptionCreateLoading extends PrescriptionState {}

class PrescriptionSuccess extends PrescriptionState {
  final String message;

  const PrescriptionSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class PrescriptionFailure extends PrescriptionState {
  final String message;

  const PrescriptionFailure({required this.message});

  @override
  List<Object> get props => [message];
}
