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

class AuthSignUpRequestedDoctor extends AuthEvent {
  final String email;
  final String password; 
  final String username;
  final String firstName; 
  final String lastName; 
  final String licenseNumber;

  AuthSignUpRequestedDoctor({
    required this.email,
    required this.password,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.licenseNumber
  });



  @override
  List<Object> get props => [email, password, username, firstName, lastName, licenseNumber];
}

class AuthSignUpRequestPatient extends AuthEvent {
  final String email;
  final String password;
  final String username;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String gender; 

  AuthSignUpRequestPatient({
    required this.email,
    required this.password,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.gender
  });

}

class AuthCheckUserType extends AuthEvent {
  final String uid; 

  AuthCheckUserType({required this.uid});

  @override
  List<Object> get props => [uid];
}

class AuthSignOutRequested extends AuthEvent {}