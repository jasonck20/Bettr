//import 'package:bettr/home.dart';
import 'package:bettr/splash.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Lexend'),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen()
    );
  }
}


