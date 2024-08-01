import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class Initial extends StatelessWidget {
  const Initial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: LoadingAnimationWidget.stretchedDots(
          color: Colors.blue,
          size: 100
        )
      )
    );
  }
}