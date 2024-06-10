import 'package:bloc/bloc.dart';
import 'package:codingbryant/models/FirebaseUser.dart';
import 'package:codingbryant/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
        final User? user = await _authRepository.signInWithUsernameAndPassword(
          username: event.username,
          password: event.password
        );

        if (user != null) {
          // Get UUID
          final userType = await getUserType(user.uid);
          emit(AuthAuthenticated(user: user, userType: userType!));

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
          password: event.password,
        );

        final FireBaseUser user0 = FireBaseUser(
          uid: user!.uid,
          email: event.email,
          username: event.username,
          first_name: event.firstName,
          last_name: event.lastName,
          gender: event.gender,
          user_type: event.type.toString(),
        );

        emit(AuthAuthenticated(user: user, userType: user0.user_type));

        await _firestore.collection('users').doc(user.uid).set({
          'email': user.email,
          'uid': user.uid,
          'username': user0.username,
          'first_name': user0.first_name,
          'last_name': user0.last_name,
          'gender': user0.gender,
          'user_type': user0.user_type,
          'created_At': FieldValue.serverTimestamp(),
        });


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

  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthSignInRequested) {

      try {
        final User? user = await _authRepository.signInWithUsernameAndPassword(
          username: event.username,
          password: event.password
        );

        if (user != null) {

          final usertType = await _authRepository.getUserType(user.uid);
          yield AuthAuthenticated(user: user, userType: usertType!);
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

        final firebaseUser = FireBaseUser(
          uid: user!.uid,
          email: event.email,
          username: event.username,
          first_name: event.firstName,
          last_name: event.lastName,
          gender: event.gender,
          user_type: 'P',
        );

        await _firestore.collection('users').doc(user.uid).set({
          'email': user.email,
          'uid': user.uid,
          'username': firebaseUser.email,
          'first_name': firebaseUser.first_name,
          'last_name': firebaseUser.last_name,
          'gender': firebaseUser.gender,
          'created_At': FieldValue.serverTimestamp(),
        });

        yield AuthAuthenticated(user: user, userType: firebaseUser.user_type);
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


  Future<String?> getUserType(String uid) async {
    try {
      final userDoc = await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        return userDoc['user_type'];
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

}
