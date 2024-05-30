import 'package:codingbryant/blocs/user_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        title: const Text('Coding Bryant'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(AuthSignOutRequested());
            },
          ),
        
        ],
      ),
      body: const Center(
        child: Text('Welcome to Coding Bryant', style: TextStyle(color: Colors.white, fontSize: 24)),
      ),
    );
  }
}