import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  // Initialize the ConfettiController immediately
  final ConfettiController _confettiController = ConfettiController(duration: Duration(seconds: 10));

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    _animationController.forward();

    // Start the confetti animation
    _confettiController.play();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _confettiController.dispose(); // Don't forget to dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COMPLETED'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2, // Downward direction
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              maxBlastForce: 140,  // Increased for more spread
              minBlastForce: 100,   // Increased for more spread
              gravity: 0.1,        // Decreased for slower fall
              blastDirectionality: BlastDirectionality.explosive,            
              ),
          ),
          Center(
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'A step closer to being your best version!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'You get to keep your money!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Icon(
                    Icons.bolt_rounded,
                    size: 50,
                    color: Colors.amber,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'You also managed to avoid downloading Malware :)',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}