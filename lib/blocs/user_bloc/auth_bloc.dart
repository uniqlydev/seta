import 'package:bloc/bloc.dart';
import 'package:codingbryant/models/doctor_model.dart';
import 'package:codingbryant/models/patient_model.dart';
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
        on<AuthSignUpRequestedDoctor>(_onSignUpRequestedDoctor);
        on<AuthSignUpRequestPatient>(_onSignUpRequestedPatient);
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

    Future<void> _onSignUpRequestedDoctor(AuthSignUpRequestedDoctor event, Emitter<AuthState> emit) async {
      try {

        final User? user = await _authRepository.signUpWithEmailandPassword(
          email: event.email,
          password: event.password,
        );

        final DoctorModel doctor = DoctorModel(
          id: user!.uid,
          email: event.email,
          username: event.username,
          firstName: event.firstName,
          lastName: event.lastName,
          licenseNumber: event.licenseNumber,
        );


        // send to firestore
        await _firestore.collection('doctors').doc(user.uid).set({
          'email': doctor.email,
          'uid': doctor.id,
          'username': doctor.username,
          'first_name': doctor.firstName,
          'last_name': doctor.lastName,
          'license_number': doctor.licenseNumber,
          'Patients': doctor.patients,
          'created_At': FieldValue.serverTimestamp(),
        });

        emit (AuthAuthenticated(user: user, userType: doctor.userType));

      } catch (e) {
        emit(AuthFailure(message: e.toString()));
      }
    }

    Future<void> _onSignUpRequestedPatient (AuthSignUpRequestPatient event, Emitter<AuthState> emit) async {
        
        try {
          final User? user = await _authRepository.signUpWithEmailandPassword(
            email: event.email,
            password: event.password,
          );
  
          final PatientModel patient = PatientModel(
            id: user!.uid,
            email: event.email,
            username: event.username,
            firstName: event.firstName,
            lastName: event.lastName,
            phoneNumber: event.phoneNumber,
            gender: event.gender
          );
  
          // send to firestore
          await _firestore.collection('patients').doc(user.uid).set({
            'email': patient.email,
            'uid': patient.id,
            'username': patient.username,
            'first_name': patient.firstName,
            'last_name': patient.lastName,
            'phone_number': patient.phoneNumber,
            'prescriptions': patient.prescriptions,
            'created_At': FieldValue.serverTimestamp(),
          });

          emit(AuthAuthenticated(user: user, userType: patient.userType));
  
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
    }else if (event is AuthSignUpRequestedDoctor) {

      try {
        final User? user = await _authRepository.signUpWithEmailandPassword(
          email: event.email,
          password: event.password
        );

        final DoctorModel doctor = DoctorModel(
          id: user!.uid,
          email: event.email,
          username: event.username,
          firstName: event.firstName,
          lastName: event.lastName,
          licenseNumber: event.licenseNumber,
        );
        // Send to firestore
        await _firestore.collection('doctors').doc(user.uid).set({
          'email': doctor.email,
          'uid': doctor.id,
          'username': doctor.username,
          'first_name': doctor.firstName,
          'last_name': doctor.lastName,
          'license_number': doctor.licenseNumber,
          'Patients': doctor.patients,
          'created_At': FieldValue.serverTimestamp(),
        });

        yield AuthAuthenticated(user: user, userType: doctor.userType);
      } catch (e) {
        yield AuthFailure(message: e.toString());
      }
    }else if (event is AuthSignUpRequestPatient) {
        try {
          final User? user = await _authRepository.signUpWithEmailandPassword(
            email: event.email,
            password: event.password
          );
  
          final PatientModel patient = PatientModel(
            id: user!.uid,
            email: event.email,
            username: event.username,
            firstName: event.firstName,
            lastName: event.lastName,
            phoneNumber: event.phoneNumber,
            gender: event.gender
          );
  
          // send to firestore
          await _firestore.collection('patients').doc(user.uid).set({
            'email': patient.email,
            'username': patient.username,
            'first_name': patient.firstName,
            'last_name': patient.lastName,
            'phone_number': patient.phoneNumber,
            'gender': patient.gender,
            'prescriptions': patient.prescriptions,
            'created_At': FieldValue.serverTimestamp(),
          });
  
          yield AuthAuthenticated(user: user, userType: patient.userType);
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
