part of 'auth_bloc.dart';

abstract class AuthState extends Equatable{
  const AuthState();

  List<Object> get props => [];
}

class AuthInitial extends AuthState {}


class AuthAuthenticated extends AuthState {
  final User user;
  final String userType;

  AuthAuthenticated({required this.user, required this.userType});

  @override
  List<Object> get props => [user, userType];
}


class Authunauthenticated extends AuthState {}


class AuthFailure extends AuthState {
  late final String message;

  AuthFailure({required this.message});

  @override
  List<Object> get props => [message];
}



