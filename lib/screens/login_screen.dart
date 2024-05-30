import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
