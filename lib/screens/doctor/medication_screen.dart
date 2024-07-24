import 'package:codingbryant/blocs/user_bloc/auth_bloc.dart';
import 'package:codingbryant/models/medication_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicationScreen extends StatefulWidget {
  const MedicationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MedicationScreenState createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  late final List<MedicationModel> medications;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state is AuthAuthenticated) {
          return SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 2 / 9,
                width: double.infinity,
                color: Colors.blue,
                child: const Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Text(
                              'Medications',
                              style: TextStyle(
                                fontFamily: 'RobotoMono',
                                fontSize: 32,
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 0),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ));
        } else if (state is AuthFailure) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
