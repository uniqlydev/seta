import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

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
            SizedBox(height: 50), // Add space between animation and SETA text
            SizedBox(
              height: 200, // Adjust the height as needed
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ExplicitAnimations(),
                  SizedBox(height: 15),
                  Positioned(
                    bottom: 30,
                    child: Text(
                      'SETA',
                      style: TextStyle(
                        fontSize: 100,
                        fontWeight: FontWeight.w900,
                        color: Colors.blue, // Set text color to blue
                        shadows: [Shadow(blurRadius: 5, color: Colors.blueGrey)], // Add drop shadow
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register-patient');
                  },
                  child: Text(
                    'Register as Patient',
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
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register-doctor');
                  },
                  child: Text(
                    'Register as Physician',
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text(
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
    return AlignTransition(
      alignment: _alignAnimation,
      child: RotationTransition(
        turns: _rotationAnimation,
        child: const Icon(
          Icons.local_hospital,
          color: Colors.redAccent,
          size: 50,
        ),
      ),
    );
  }
}
