import 'package:codingbryant/blocs/user_bloc/auth_bloc.dart';
import 'package:codingbryant/repositories/auth_repository.dart';
import 'package:codingbryant/screens/dashboard_doctor_screen.dart';
import 'package:codingbryant/screens/landing_page.dart';
import 'package:codingbryant/screens/login_screen.dart';
import 'package:codingbryant/screens/register_doctor_screen.dart';
import 'package:codingbryant/screens/register_patient_screen.dart';
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
      ],
      child: MaterialApp (
        debugShowCheckedModeBanner: false, // Add this line to define the named parameter
        title: "SetaPill",
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthInitial) {
              return LandingPage();
            } else if (state is AuthAuthenticated) {
              return LandingPage();
            } else {
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            }
          },
        ),
        routes: {
          '/register-doctor': (context) => const RegisterDoctorScreen(),
          '/login':(context) => LoginScreen(),
          '/register-patient': (context) => const RegisterPatientScreen(),
          '/dashboard-doctor': (context) => const DashboardDoctorScreen(),
        },
      ),
    );
  }
}

