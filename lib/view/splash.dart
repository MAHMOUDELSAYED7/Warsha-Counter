import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // _redirect();
  }

  void _redirect() => Future.delayed(
      Duration(seconds: 2), () => Navigator.pushNamed(context, "/home"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
