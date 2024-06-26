part of 'prescription_bloc.dart';

sealed class PrescriptionState extends Equatable {
  const PrescriptionState();
  
  @override
  List<Object> get props => [];
}

final class PrescriptionInitial extends PrescriptionState {}

final class PrescriptionLoading extends PrescriptionState {}

final class PrescriptionCreateLoading extends PrescriptionState {
  final String message;

  const PrescriptionCreateLoading({required this.message});

  @override
  List<Object> get props => [message];

}

final class PrescriptionSuccess extends PrescriptionState {
  final String message;

  const PrescriptionSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

final class PrescriptionFailure extends PrescriptionState {
  final String message;

  const PrescriptionFailure({required this.message});

  @override
  List<Object> get props => [message];
}
