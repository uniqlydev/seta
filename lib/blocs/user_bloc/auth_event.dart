part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  List<Object> get props => [];
}


class AuthStarted extends AuthEvent {}

class AuthLoggedIn extends AuthEvent {}

class AuthLoggedOut extends AuthEvent {}