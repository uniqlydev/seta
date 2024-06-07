import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const inputDecoration = InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      fillColor: Colors.white,
      filled: true,
    );

    // Dropdown options
    List<String> userTypeOptions = ['Doctor', 'Patient'];
    List<String> genderOptions = ['Male', 'Female'];
    String? selectedUserType;
    String? selectedGender;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Create a SETA Account',
                style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 30,
                  color: Color(0xFF683F7B),
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 360,
                height: 465,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE4D6FF),
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    TextField(
                      decoration: inputDecoration.copyWith(hintText: 'Email Address'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: inputDecoration.copyWith(hintText: 'First Name'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: inputDecoration.copyWith(hintText: 'Last Name'),
                    ),
                    const SizedBox(height: 10),
                    // Row for the two dropdowns
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                border: InputBorder.none,
                                hintText: '- User Type -',
                              ),
                              value: selectedUserType,
                              onChanged: (newValue) {
                                selectedUserType = newValue!;
                              },
                              items: userTypeOptions.map((option) {
                                return DropdownMenuItem(
                                  value: option,
                                  child: Text(option),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey)
                            ),
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                border: InputBorder.none,
                                hintText: '- Gender -',
                              ),
                              value: selectedGender,
                              onChanged: (newValue) {
                                selectedGender = newValue!;
                              },
                              items: genderOptions.map((option) {
                                return DropdownMenuItem(
                                  value: option,
                                  child: Text(option),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: inputDecoration.copyWith(hintText: 'Password'),
                      obscureText: true,
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: inputDecoration.copyWith(hintText: 'Confirm Password'),
                      obscureText: true,
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: 90,
                      height: 25,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 12),
                        ),
                        child: const Text('Sign Up'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    'Log In',
                    style: TextStyle(color: Color(0xFF683F7B)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
