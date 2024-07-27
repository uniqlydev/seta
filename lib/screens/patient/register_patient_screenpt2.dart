import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:codingbryant/blocs/user_bloc/auth_bloc.dart';

class RegisterPatientScreenpt2 extends StatelessWidget {
  final String email;
  final String password;
  final String username;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String gender;

  RegisterPatientScreenpt2({
    super.key,
    required this.email,
    required this.password,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.gender,
  });

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const inputDecoration = InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      fillColor: Colors.white,
      filled: true,
    );

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is AuthAuthenticatedPatient) {
            Navigator.of(context).pushNamedAndRemoveUntil('/dashboard-patient', (Route<dynamic> route) => false);
          }
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'SETA',
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 60,
                      color: Color(0xFF683F7B),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: TextFormField(
                            controller: _weightController,
                            decoration: inputDecoration.copyWith(
                              hintText: 'Weight (kg)',
                              prefixIcon: const Icon(Icons.line_weight),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: TextFormField(
                            controller: _heightController,
                            decoration: inputDecoration.copyWith(
                              hintText: 'Height (cm)',
                              prefixIcon: const Icon(Icons.height),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: TextFormField(
                            controller: _birthdateController,
                            decoration: inputDecoration.copyWith(
                              hintText: 'Birthdate (YYYY-MM-DD)',
                              prefixIcon: const Icon(Icons.cake),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              AuthSignUpRequestPatient(
                                email: email,
                                password: password,
                                username: username,
                                firstName: firstName,
                                lastName: lastName,
                                phoneNumber: phoneNumber,
                                gender: gender,
                                weight: double.parse(_weightController.text),
                                height: double.parse(_heightController.text),
                                bday: DateTime.parse(_birthdateController.text),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                          child: const Text('Sign Up'),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: RichText(
                            text: TextSpan(
                              text: 'Already have an account? ',
                              style: const TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: 'Log In',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
