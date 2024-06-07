import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:codingbryant/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user_bloc/auth_bloc.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'SETA', style: TextStyle(fontFamily: 'RobotoMono', fontSize: 60, fontWeight: FontWeight.w800, color: Colors.deepPurple), // change font
            ),
            Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                      
                    ),
                    width: 380,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Username',
                        prefixIcon: Icon(Icons.person), // Icon for Username
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    width: 380,
                    child: TextFormField(
                      obscureText: true, // Set to true to hide the password text
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock), // Icon for Password
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Handle form submission here
                      print('Form submitted!');
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//       appBar: AppBar(
//         title: const Text('Login'),
//       ),
//       body: BlocConsumer<AuthBloc,AuthState>(
//         listener: (context, state) => {
//           if (state is AuthAuthenticated) {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const HomeScreen(),
//               ),
//             )
//           }else if (state is AuthFailure) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.message),
//               ),
//             )
//           }
//         },
//         builder:(context, state) {
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 TextField(
//                   controller: _emailController,
//                   decoration: const InputDecoration(
//                     labelText: 'Email',
//                   ),
//                 ),
//                 TextField(
//                   controller: _passwordController,
//                   decoration: const InputDecoration(
//                     labelText: 'Password',
//                   ),
//                   obscureText: true,
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     context.read<AuthBloc>().add(
//                       AuthSignInRequested(
//                         email: _emailController.text,
//                         password: _passwordController.text,
//                       ),
//                     );
//                   },
//                   child: const Text('Sign In'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     context.read<AuthBloc>().add(
//                       AuthSignUpRequested(
//                         email: _emailController.text,
//                         password: _passwordController.text,
//                       ),
//                     );
//                   },
//                   child: const Text('Sign Up'),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
