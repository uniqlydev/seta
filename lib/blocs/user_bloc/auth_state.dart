part of 'auth_bloc.dart';

abstract class AuthState extends Equatable{
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}


class AuthAuthenticated extends AuthState {
  final User user;
  final String userType;
  final String firstName;
  final List<String> patients;

  const AuthAuthenticated({required this.user, required this.userType, required this.firstName, required this.patients});

  @override
  List<Object> get props => [user, userType];
}


class Authunauthenticated extends AuthState {}


class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});

  @override
  List<Object> get props => [message];
}



