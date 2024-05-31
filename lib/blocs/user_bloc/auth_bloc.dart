import 'package:bloc/bloc.dart';
import 'package:codingbryant/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthInitial()) {
        on<AuthSignInRequested>(_onSignInRequested);
        on<AuthSignUpRequested>(_onSignUpRequested);
        on<AuthSignOutRequested>(_onSignOutRequested);
      }

    Future<void> _onSignInRequested(AuthSignInRequested event, Emitter<AuthState> emit) async {

      try {
        final User? user = await _authRepository.signInWithEmailandPassword(
          email: event.email,
          password: event.password
        );

        if (user != null) {
          emit(AuthAuthenticated(user: user));
        } else {
          emit(Authunauthenticated());
        }
      } catch (e) {
        emit(AuthFailure(message: e.toString()));
      }
    }

    Future<void> _onSignUpRequested(AuthSignUpRequested event, Emitter<AuthState> emit) async {

      try {
        final User? user = await _authRepository.signUpWithEmailandPassword(
          email: event.email,
          password: event.password
        );

        if (user != null) {
          emit(AuthAuthenticated(user: user));
        } else {
          emit(Authunauthenticated());
        }
      } catch (e) {
        emit(AuthFailure(message: e.toString()));
      }
    }

    Future<void> _onSignOutRequested(AuthSignOutRequested event, Emitter<AuthState> emit) async {

      try {
        await _authRepository.signOut();
        emit(Authunauthenticated());
      } catch (e) {
        emit(AuthFailure(message: e.toString()));
      }
    }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthSignInRequested) {

      try {
        final User? user = await _authRepository.signInWithEmailandPassword(
          email: event.email,
          password: event.password
        );

        if (user != null) {
          yield AuthAuthenticated(user: user);
        } else {
          yield Authunauthenticated();
        }
      } catch (e) {
        yield AuthFailure(message: e.toString());
      }
    }else if (event is AuthSignUpRequested) {

      try {
        final User? user = await _authRepository.signUpWithEmailandPassword(
          email: event.email,
          password: event.password
        );

        if (user != null) {
          yield AuthAuthenticated(user: user);
        } else {
          yield Authunauthenticated();
        }
      } catch (e) {
        yield AuthFailure(message: e.toString());
      }
    }else if (event is AuthSignOutRequested) {

      try {
        await _authRepository.signOut();
        yield Authunauthenticated();
      } catch (e) {
        yield AuthFailure(message: e.toString());
      }
    }
  }
}
