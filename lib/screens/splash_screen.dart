import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 4),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Homescreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 32,
      fontFamily: 'Horizon',
      fontWeight: FontWeight.bold,
      shadows: [
        Shadow(
          blurRadius: 3,
          offset: Offset(2, 2),
          color: Colors.grey,
        )
      ],
    );

    TextStyle typewriterTextStyle = TextStyle(
      color: Colors.grey[800],
      fontSize: 18,
    );

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade200,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'Pexels™️ - Wallpapers',
                    textAlign: TextAlign.center,
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                ],
                isRepeatingAnimation: true,
              ),
            ),
            const SizedBox(height: 100),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  speed: const Duration(milliseconds: 50),
                  'Developed by: Swapnil Pingale',
                  textStyle: typewriterTextStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
