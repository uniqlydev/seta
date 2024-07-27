part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthAuthenticatedDoctor extends AuthState {
  final User user;
  final String email;
  final String userType;
  final String firstName;
  final String lastName;
  final List<String> patients;

  const AuthAuthenticatedDoctor(
      {required this.user,
      required this.email,
      required this.userType,
      required this.firstName,
      required this.lastName,
      required this.patients});

  @override
  List<Object> get props => [user, userType];
}

class AuthAuthenticatedPatient extends AuthState {
  final User user;
  final String email;
  final String firstName;
  final String lastName;
  final List<PrescriptionModel> prescriptions;

  const AuthAuthenticatedPatient(
      {required this.user,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.prescriptions});

  @override
  List<Object> get props => [user];
}

class Authunauthenticated extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});

  @override
  List<Object> get props => [message];
}
