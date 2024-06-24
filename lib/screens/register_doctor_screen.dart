import 'package:codingbryant/blocs/user_bloc/auth_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class RegisterDoctorScreen extends StatelessWidget {
  RegisterDoctorScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _licenseNumberController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

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
          } else if (state is AuthAuthenticated) {
            if (state.userType == 'D') {
              Navigator.pushNamed(context, '/dashboard-doctor');
            }
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
                            controller: _emailController,
                            decoration: inputDecoration.copyWith(
                              hintText: 'Email Address',
                              prefixIcon: const Icon(Icons.email),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _firstNameController,
                                  decoration: inputDecoration.copyWith(
                                    hintText: 'First Name',
                                    prefixIcon: const Icon(Icons.person),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: _lastNameController,
                                  decoration: inputDecoration.copyWith(
                                    hintText: 'Last Name',
                                    prefixIcon: const Icon(Icons.person_outline),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: TextFormField(
                            controller: _licenseNumberController,
                            decoration: inputDecoration.copyWith(
                              hintText: 'License Number',
                              prefixIcon: const Icon(Icons.credit_card),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: TextFormField(
                            controller: _passwordController,
                            decoration: inputDecoration.copyWith(
                              hintText: 'Password',
                              prefixIcon: const Icon(Icons.lock),
                            ),
                            obscureText: true,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: TextFormField(
                            controller: _confirmPasswordController,
                            decoration: inputDecoration.copyWith(
                              hintText: 'Confirm Password',
                              prefixIcon: const Icon(Icons.lock_outline),
                            ),
                            obscureText: true,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              AuthSignUpRequestedDoctor(
                                email: _emailController.text,
                                password: _passwordController.text,
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text,
                                username: _licenseNumberController.text,
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
                                      Navigator.pushNamed(context, '/login');
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

  void setState(VoidCallback fn) {
    // This method is a placeholder, it should be replaced with appropriate state management.
    fn();
  }
}
