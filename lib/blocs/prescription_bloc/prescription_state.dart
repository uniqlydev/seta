part of 'prescription_bloc.dart';

sealed class PrescriptionState extends Equatable {
  const PrescriptionState();
  
  @override
  List<Object> get props => [];
}

final class PrescriptionInitial extends PrescriptionState {}

final class PrescriptionLoading extends PrescriptionState {}

final class PrescriptionSuccess extends PrescriptionState {
  final String message;

  const PrescriptionSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
