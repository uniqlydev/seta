import 'package:flutter/material.dart';
import 'package:codingbryant/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user_bloc/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'SETA',
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 60,
                      fontWeight: FontWeight.w800,
                      color: Colors.deepPurple,
                    ),
                  ),
                  Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:30.0),
                          child: Row(
                            children: [
                              Icon(Icons.person),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    hintText: 'Username',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            children: [
                              Icon(Icons.lock),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    hintText: 'Password',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              AuthSignInRequested(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                          },
                          child: const Text('Login'),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Go to screen register_screen.dart
                            Navigator.pushNamed(context, '/register');
                          },
                          child: const Text("Don't have an account?"),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black, backgroundColor: Colors.grey[300],
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
