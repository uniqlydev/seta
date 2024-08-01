import 'package:bloc/bloc.dart';
import 'package:codingbryant/models/doctor_model.dart';
import 'package:codingbryant/models/patient_model.dart';
import 'package:codingbryant/models/prescription_model.dart';
import 'package:codingbryant/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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

  Future<void> _onSignInRequested(
      AuthSignInRequested event, Emitter<AuthState> emit) async {
    try {
      final User? user = await _authRepository.signInWithUsernameAndPassword(
          username: event.username, password: event.password);

      if (user != null) {
        // Get firstname based on uid either patient or doctor
        final doctor =
            await _firestore.collection('doctors').doc(user.uid).get();
        final patient =
            await _firestore.collection('patients').doc(user.uid).get();

        // Get first name if doctor, username if patient

        String userName =
            doctor.exists ? doctor['first_name'] : patient['first_name'];

        String lastName =
            doctor.exists ? doctor['last_name'] : patient['last_name'];

        String? userType;

        if (doctor.exists) {
          userType = 'D';
        } else if (patient.exists) {
          userType = 'P';
        }

        String email = doctor.exists ? doctor['email'] : patient['email'];


        if (userType == 'D') {
          // Retreive subcollection of patients
          print(user.uid);

          // Print every sub collection under doctors
          final patientsList = await _firestore
              .collection('doctors')
              .doc(user.uid)
              .collection('patients');

          
          // Initialize a Set to store unique patient IDs
          Set<String> uniquePatientIds = {};

          final querySnapshot = await patientsList.get();

          // Loop through the documents
          for (var doc in querySnapshot.docs) {
            uniquePatientIds.add(doc.id);
          }

    

          // Iterate through and retrieve the username
          List<String> first_names = [];



          for (var id in uniquePatientIds) {

            var pdf = await _firestore.collection('patients').doc(id).get();

            first_names.add(pdf['first_name']);
          }

          // Convert the Set to a list if necessary
          List<String> uniquePatientIdsList = first_names.toList();

          emit(AuthAuthenticatedDoctor(
              user: user,
              email: email,
              userType: userType!,
              firstName: userName,
              lastName: lastName,
              patients: uniquePatientIdsList));
        } else if (userType == 'P') {

          // Retrieve the patient's prescriptions

          final prescriptions = await _firestore
              .collection('patients')
              .doc(user.uid)
              .collection('prescriptions')
              .get();

          List<PrescriptionModel> prescriptionList = [];

          for (var doc in prescriptions.docs) {
            prescriptionList.add(PrescriptionModel(
              id: doc.id,
              drugClass: doc['drugClass'],
              medication: doc['medication'],
              dosage: doc['dosage'],
              instructions: doc['instructions'],
            ));
          }

          // Print all
          prescriptionList.forEach((element) {
            print(element.id);
            print(element.dosage);
          });


          emit(AuthAuthenticatedPatient(
              user: user,
              email: email,
              firstName: userName,
              lastName: lastName,
              prescriptions: prescriptionList));
        } else {
          emit(Authunauthenticated());
        }
      } else {
        emit(Authunauthenticated());
      }
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onSignUpRequestedDoctor(
      AuthSignUpRequestedDoctor event, Emitter<AuthState> emit) async {
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
      );

      // send to firestore
      await _firestore.collection('doctors').doc(user.uid).set({
        'email': doctor.email,
        'uid': doctor.id,
        'username': doctor.username,
        'first_name': doctor.firstName,
        'last_name': doctor.lastName,
        'created_At': FieldValue.serverTimestamp(),
      });

      // Get subcollection
      final patients = await _firestore
          .collection('prescriptions')
          .where('doctorId', isEqualTo: user.uid)
          .get();

      // Initialize a Set to store unique patient IDs
      Set<String> uniquePatientIds = {};

      // Iterate through the query snapshot
      for (var document in patients.docs) {
        // Get the patientId from each document
        String patientId = document.data()['patientId'];

        // Add patientId to the Set (Sets automatically handle duplicates)
        uniquePatientIds.add(patientId);
      }

      // Convert the Set to a list if necessary
      List<String> uniquePatientIdsList = uniquePatientIds.toList();

      emit(AuthAuthenticatedDoctor(
          user: user,
          email: doctor.email,
          userType: doctor.userType,
          firstName: doctor.firstName,
          lastName: doctor.lastName,
          patients: uniquePatientIdsList));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onSignUpRequestedPatient(
      AuthSignUpRequestPatient event, Emitter<AuthState> emit) async {
 
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
          gender: event.gender,
          weight: event.weight,
          height: event.height,
          bday: event.bday
          );

      // send to firestore
      await _firestore.collection('patients').doc(user.uid).set({
        'email': patient.email,
        'uid': patient.id,
        'username': patient.username,
        'first_name': patient.firstName,
        'last_name': patient.lastName,
        'phone_number': patient.phoneNumber,
        'bday': patient.bday,
        'weight': patient.weight,
        'height': patient.height,
        'created_At': FieldValue.serverTimestamp(),
      });


      emit(AuthAuthenticatedPatient(
          user: user,
          email: patient.email,
          firstName: patient.firstName,
          lastName: patient.lastName,
          prescriptions: const []));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onSignOutRequested(
      AuthSignOutRequested event, Emitter<AuthState> emit) async {
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
            username: event.username, password: event.password);

        if (user != null) {
          final usertType = await _authRepository.getUserType(user.uid);

          if (usertType == 'D') {
            final doctor =
                await _firestore.collection('doctors').doc(user.uid).get();
            // Get subcollection of patients
            final patients = await _firestore
                .collection('prescriptions')
                .where('doctorId', isEqualTo: user.uid)
                .get();

            // Initialize a Set to store unique patient IDs
            Set<String> uniquePatientIds = {};

            // Iterate through the query snapshot
            for (var document in patients.docs) {
              // Get the patientId from each document
              String patientId = document.data()['patientId'];

              // Add patientId to the Set (Sets automatically handle duplicates)
              uniquePatientIds.add(patientId);
            }

            // Convert the Set to a list if necessary
            List<String> uniquePatientIdsList = uniquePatientIds.toList();

            yield AuthAuthenticatedDoctor(
                user: user,
                email: doctor['email'],
                userType: usertType!,
                firstName: doctor['first_name'],
                lastName: doctor['last_name'],
                clinicName: doctor['clinic_name'],
                clinicHours: doctor['clinic_hours'],
                patients: uniquePatientIdsList);
          } else if (usertType == 'P') {
            final patient =
                await _firestore.collection('patients').doc(user.uid).get();
            yield AuthAuthenticatedDoctor(
                user: user,
                email: patient['email'],
                userType: usertType!,
                firstName: patient['first_name'],
                lastName: patient['last_name'],
                phoneNumber: patient['phone_number'],
                birthday: patient['birthday'],
                height: patient['height'],
                weight: patient['weight'],
                bloodType: patient['blood_type'],
                patients: const []);
          }
        } else {
          yield Authunauthenticated();
        }
      } catch (e) {
        yield AuthFailure(message: e.toString());
      }
    } else if (event is AuthSignUpRequestedDoctor) {
      try {
        final User? user = await _authRepository.signUpWithEmailandPassword(
            email: event.email, password: event.password);

        final DoctorModel doctor = DoctorModel(
          id: user!.uid,
          email: event.email,
          username: event.username,
          firstName: event.firstName,
          lastName: event.lastName,
        );
        // Send to firestore
        await _firestore.collection('doctors').doc(user.uid).set({
          'email': doctor.email,
          'uid': doctor.id,
          'username': doctor.username,
          'first_name': doctor.firstName,
          'last_name': doctor.lastName,
          'Patients': doctor.patients,
          'created_At': FieldValue.serverTimestamp(),
        });

        // Get subcollection patients
        final patients = await _firestore
            .collection('prescriptions')
            .where('doctorId', isEqualTo: user.uid)
            .get();

        // Initialize a Set to store unique patient IDs
        Set<String> uniquePatientIds = {};

        // Iterate through the query snapshot
        for (var document in patients.docs) {
          // Get the patientId from each document
          String patientId = document.data()['patientId'];

          // Add patientId to the Set (Sets automatically handle duplicates)
          uniquePatientIds.add(patientId);
        }

        // Convert the Set to a list if necessary
        List<String> uniquePatientIdsList = uniquePatientIds.toList();

        yield AuthAuthenticatedDoctor(
            user: user,
            email: doctor.email,
            userType: doctor.userType,
            firstName: doctor.firstName,
            lastName: doctor.lastName,
            patients: uniquePatientIdsList);
      } catch (e) {
        yield AuthFailure(message: e.toString());
      }
    } else if (event is AuthSignUpRequestPatient) {
      try {
        final User? user = await _authRepository.signUpWithEmailandPassword(
            email: event.email, password: event.password);

        final PatientModel patient = PatientModel(
            id: user!.uid,
            email: event.email,
            username: event.username,
            firstName: event.firstName,
            lastName: event.lastName,
            phoneNumber: event.phoneNumber,
            weight: event.weight,
            height: event.height,
            bday: event.bday,
            gender: event.gender);

        // send to firestore
        await _firestore.collection('patients').doc(user.uid).set({
          'email': patient.email,
          'username': patient.username,
          'first_name': patient.firstName,
          'last_name': patient.lastName,
          'phone_number': patient.phoneNumber,
          'gender': patient.gender,
          'weight': patient.weight,
          'height': patient.height,
          'bday': patient.bday,
          'created_At': FieldValue.serverTimestamp(),
        });

        yield AuthAuthenticatedDoctor(
            user: user,
            email: patient.email,
            userType: patient.userType,
            firstName: patient.firstName,
            lastName: patient.lastName,
            patients: const []);
      } catch (e) {
        yield AuthFailure(message: e.toString());
      }
    } else if (event is AuthSignOutRequested) {
      try {
        await _authRepository.signOut();
        yield Authunauthenticated();
      } catch (e) {
        yield AuthFailure(message: e.toString());
      }
    }
  }
}
