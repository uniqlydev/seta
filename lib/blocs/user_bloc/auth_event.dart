part of 'auth_bloc.dart';


abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthSignInRequested extends AuthEvent {
  final String email;
  final String password; 

  AuthSignInRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthSignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String username;
  final String firstName;
  final String lastName;
  final Char type;
  final String gender;

  AuthSignUpRequested({
    required this.email,
    required this.password,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.type,
  });

  @override
  List<Object> get props => [email, password, username, firstName, lastName, type, gender];
}

class AuthSignOutRequested extends AuthEvent {}