import 'package:codingbryant/blocs/user_bloc/auth_bloc.dart';
import 'package:codingbryant/repositories/auth_repository.dart';
import 'package:codingbryant/screens/home_screen.dart';
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
        debugShowCheckedModeBanner: false,
        title: "SetaPill",
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthInitial) {
              return LoginScreen();
            } else if (state is AuthAuthenticated) {
              if (state.userType == 'd') {
                return HomeScreen(); // Replace with right pages
              } else {
                return HomeScreen(); // Replace with right pages
              }
            } else {
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            }
          },
        ),
        routes: {
          '/register-doctor': (context) => const RegisterDoctorScreen(),
          '/login':(context) => LoginScreen(),
          '/register-patient': (context) => RegisterPatientScreen(),
        },
      ),
    );
  }
}

