import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50), // Add space between animation and SETA text
            SizedBox(
              height: 200, // Adjust the height as needed
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Positioned(
                    top: 0,
                    child: ExplicitAnimations(),
                  ),
                  Positioned(
                    bottom: 30,
                    child: Container(
                      // Set the width to match the text's width
                      child: const Text(
                        'SETA',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.w900,
                          color: Colors.blue, // Set text color to blue
                          shadows: [
                            Shadow(blurRadius: 5, color: Colors.blueGrey)
                          ], // Add drop shadow
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register-patient');
                  },
                  child: const Text(
                    'Register as Patient',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 5, // Add elevation
                    shadowColor: Colors.black, // Add shadow color
                    backgroundColor: Colors.green, // Set background color for patient
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register-doctor');
                  },
                  child: const Text(
                    'Register as Physician',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 5, // Add elevation
                    shadowColor: Colors.black, // Add shadow color
                    backgroundColor: Colors.redAccent, // Set background color for doctor
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text(
                'Login',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set text color to white
                ),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 5, // Add elevation
                shadowColor: Colors.black, // Add shadow color
                backgroundColor: Colors.blue, // Set background color to blue
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExplicitAnimations extends StatefulWidget {
  const ExplicitAnimations({Key? key}) : super(key: key);

  @override
  State<ExplicitAnimations> createState() => _ExplicitAnimationsState();
}

class _ExplicitAnimationsState extends State<ExplicitAnimations>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation<AlignmentGeometry> _alignAnimation;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5), // Slow down the animation (5 seconds)
      vsync: this,
    )..repeat(reverse: true);

    _alignAnimation = Tween<AlignmentGeometry>(
      begin: Alignment.topLeft,
      end: Alignment.topRight,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
      ),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260, // Match the width of the text 'SETA'
      child: AlignTransition(
        alignment: _alignAnimation,
        child: RotationTransition(
          turns: _rotationAnimation,
          child: const Icon(
            Icons.local_hospital,
            color: Colors.redAccent,
            size: 50,
          ),
        ),
      ),
    );
  }
}
