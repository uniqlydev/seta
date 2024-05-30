part of 'auth_bloc.dart';

abstract class AuthState {
  const AuthState();

  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {
  final bool isLoading;

  AuthLoading({required this.isLoading});
}

class AuthSuccess extends AuthState {
  final String message;
  final Usermodel user;

  const AuthSuccess({required this.message, required this.user});

  @override
  List<Object> get props => [message, user];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});

  @override
  List<Object> get props => [message];
}