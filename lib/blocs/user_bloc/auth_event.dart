part of 'auth_bloc.dart';


abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthSignInRequested extends AuthEvent {
  final String username;
  final String password; 

  AuthSignInRequested({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class AuthSignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String username;
  final String firstName;
  final String lastName;
  final String type;
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

class AuthCheckUserType extends AuthEvent {
  final String uid; 

  AuthCheckUserType({required this.uid});

  @override
  List<Object> get props => [uid];
}

class AuthSignOutRequested extends AuthEvent {}