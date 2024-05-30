part of 'auth_bloc.dart';

abstract class AuthState extends Equatable{
  const AuthState();

  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;

  AuthAuthenticated({required this.user});

  @override
  List<Object> get props => [user];
}

class Authunauthenticated extends AuthState {}


class AuthFailure extends AuthState {
  late final String message;

  AuthFailure({required this.message});

  @override
  List<Object> get props => [message];
}


