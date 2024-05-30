import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:codingbryant/models/UserModel.dart';
import 'package:codingbryant/services/authentication.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService = AuthService();

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) => {});

    on<SignUpUser>((event, emit) async {
      emit(AuthLoading(isLoading: true));
      try {
        final Usermodel? user = await authService.signUpUser(
          event.email,
          event.password,
        );

        if (user != null) {
          emit(AuthSuccess(message: 'User created successfully', user: user));
        } else {
          emit(const AuthFailure(message: 'Failed to create user'));
        }
      }catch(e) {
        emit(AuthFailure(message: e.toString()));
      }

      emit(AuthLoading(isLoading: false));
    });

    on<SignOutUser>((event, emit) async {
      emit(AuthLoading(isLoading: true));

      try {
        authService.signOutUser();
      }catch(e) {
        emit(AuthFailure(message: e.toString()));
      }

      emit(AuthLoading(isLoading: false));
    });
  }
}
