part of 'auth_bloc.dart';

abstract class AuthState extends Equatable{
  const AuthState();

  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState {
  final FireBaseUser user;

  AuthSuccess({required this.user});

  @override
  List<Object> get props => [user];

}

class AuthFailure extends AuthState {
  late final String message;

  AuthFailure({required this.message});

  @override
  List<Object> get props => [message];
}


