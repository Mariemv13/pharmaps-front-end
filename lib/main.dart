import 'package:flutter/material.dart';
import 'package:pharmaps/pages/splash/splash_screen.dart';
import 'package:pharmaps/utils/constants.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: greenColor),
      home: const SplashScreen(),
    );
  }   
}