import 'dart:async';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:bizhub_new/view/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/mytheme.dart';
import '../utils/routes/routes_name.dart';
import '../utils/shared_prefrences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final prefrences = Prefrences();

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceOut,
      reverseCurve: Curves.bounceInOut,
    );
    _animationController.forward();

    checkAuthentication();
    super.initState();
  }

  void checkAuthentication() async {
    final token = await prefrences.getSharedPreferenceValue('token');
    // final image = await prefrences.getSharedPreferenceValue('image');
    // print('token ' + token.toString());
    // print('image ' + image.toString());
    if (token == null || token == '') {
      Timer(
        const Duration(milliseconds: 2500),
        () => Navigator.pushReplacementNamed(context, RouteName.onboard),
      );
    } else {
      Timer(
        const Duration(milliseconds: 2500),
        () => Navigator.pushReplacementNamed(context, RouteName.home),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    // );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(systemNavigationBarColor: Colors.black),
    );
    return Scaffold(
      backgroundColor: MyTheme.splash,
      body: SizedBox(
        child: Center(
          child: ScaleTransition(
            scale: _animation,
            child: Image.asset('assets/images/bizhub_logo.png', height: 80),
          ),
        ),
      ),
    );
  }
}
