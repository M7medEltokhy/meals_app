import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:meals_app/core/app_color.dart';
import 'package:meals_app/core/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    isFirstTime();
  }

  Future<void> isFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool(ISFIRSTTIME);

    Future.delayed(const Duration(seconds: 3), () {
      if (firstTime == null || firstTime) {
        Navigator.pushReplacementNamed(context, onboarding);
      } else {
        Navigator.pushReplacementNamed(context, appLayout);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(child: Lottie.asset('assets/animations/cooking.json')),
    );
  }
}
