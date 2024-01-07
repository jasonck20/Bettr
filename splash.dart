import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async'; // For Timer
import 'package:bettr/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Timer _imageTimer;
  int _imageIndex = 0;

  final List<String> _images = [
    'images/title1.png',
    'images/title2.png', // Replace with your actual image paths
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationController.forward();

    _imageTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_imageIndex < _images.length - 1) {
        setState(() {
          _imageIndex++;
        });
      } else {
        timer.cancel();
      }
    });

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeScreen(stringValue: '', timeUnit: '', passedValue: '')),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _imageTimer.cancel();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 255, 255, 255), Color.fromARGB(255, 255, 255, 255)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _animation,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: Image(
                  key: ValueKey<String>(_images[_imageIndex]),
                  image: AssetImage(_images[_imageIndex]),
                ),
              ),
            ),
            const SizedBox(height: 40),
            FadeTransition(
              opacity: _animation,
              child: const Text(
                'High Risk   High Reward',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
  
              ),
            ),
          ],
        ),
      ),
    );
  }
}