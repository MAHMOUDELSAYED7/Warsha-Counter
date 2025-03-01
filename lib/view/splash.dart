import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warsha_counter/core/utils/extensions/extensions.dart';
import 'package:warsha_counter/core/utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  void _redirect() => Future.delayed(
      Duration(seconds: 2), () => context.pushNamed(RoutesManager.login));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          FadeIn(
            duration: Duration(milliseconds: 900),
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              radius: context.width / 4,
              child: BounceIn(
                duration: Duration(milliseconds: 900),
                child: Text(
                  "Counter\nألورشه",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ).center(),
              ),
            ),
          ),
          Positioned(
              bottom: 30,
              child: FadeInUp(
                duration: Duration(microseconds: 500),
                child: Text(
                  "أعتبرها سبلاش جامده",
                  style: TextStyle(fontSize: 18),
                ),
              ))
        ],
      ).withSize(width: double.infinity, height: double.infinity),
    );
  }
}
