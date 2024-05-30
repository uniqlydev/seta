part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();

  List<Object> get props => [];
}

class SignUpUser extends AuthEvent {
  final String email;
  final String password;

  const SignUpUser({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignOutUser extends AuthEvent {}