import 'package:codingbryant/blocs/prescription_bloc/prescription_bloc.dart';
import 'package:codingbryant/blocs/user_bloc/auth_bloc.dart';
import 'package:codingbryant/repositories/auth_repository.dart';
import 'package:codingbryant/repositories/prescribe_repository.dart';
import 'package:codingbryant/screens/doctor/dashboard_doctor_screen.dart';
import 'package:codingbryant/screens/doctor/medication_screen.dart';
import 'package:codingbryant/screens/doctor/patient_details_screen.dart';
import 'package:codingbryant/screens/landing_page.dart';
import 'package:codingbryant/screens/patient/dashboard_patient_screen.dart';
import 'package:codingbryant/screens/login_screen.dart';
import 'package:codingbryant/screens/patient/patient_prescription_details.dart';
import 'package:codingbryant/screens/doctor/prescription_screen.dart';
import 'package:codingbryant/screens/doctor/register_doctor_screen.dart';
import 'package:codingbryant/screens/patient/register_patient_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authRepository: AuthRepository()),
        ),
        BlocProvider(
          create: (context) =>
              PrescriptionBloc(prescriptionRepository: PrescribeRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "SetaPill",
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthInitial) {
              return LandingPage();
            } else if (state is AuthAuthenticated) {
              if (state.userType == 'D') {
                return DashboardDoctorScreen(); // Replace with right pages
              } else if (state.userType == 'P') {
                return DashboardPatientScreen(); // Replace with right pages
              } else {
                return const Scaffold(
                    body: Text(
                        "if this is showing, something went wrong. Please contact the developer."));
              }
            } else {
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
            }
          },
        ),
        routes: {
          '/register-doctor': (context) => RegisterDoctorScreen(),
          '/login': (context) => LoginScreen(),
          '/dashboard-doctor': (context) => const DashboardDoctorScreen(),
          '/prescription-form': (context) => PrescriptionScreen(),
          '/prescription-confirm': (context) =>
              const PatientPrescriptionDetails(),
          '/dashboard-patient': (context) => DashboardPatientScreen(),
          '/register-patient': (context) => RegisterPatientScreen(),
          '/medication-screen': (context) => const MedicationScreen(),
          '/patient-details-screen': (context) => PatientDetailsScreen(
                patientName: '',
              ),
        },
      ),
    );
  }
}
