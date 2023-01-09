import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/mytheme.dart';
import '../utils/routes/routes_name.dart';
import '../utils/shared_prefrences.dart';
import 'auth/without_auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String? token;

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

    super.initState();
    checkAuthentication();
  }

  void checkAuthentication() async {
    SplashScreen.token = await prefrences.getSharedPreferenceValue('token');
    // print('MY TOKEN: ${SplashScreen.token}');
    final firstTime =
        await prefrences.getSharedPreferenceValue('first_time') ?? '0';
    // // final image = await prefrences.getSharedPreferenceValue('image');
    // print('token ' + token.toString());
    // // print('image ' + image.toString());
    if (SplashScreen.token == null || SplashScreen.token == '') {
      if (firstTime == '0') {
        await prefrences.setSharedPreferenceValue('first_time', '1');
        // Timer(
        //   const Duration(milliseconds: 2500),
        //   () => Navigator.pushReplacementNamed(context, RouteName.onboard),
        // );

        Timer(
          const Duration(milliseconds: 2500),
          () => Navigator.of(context)
              .pushNamedAndRemoveUntil(RouteName.onboard, (route) => false),
        );
      } else {
        // print('object 2');
        Timer(
          const Duration(milliseconds: 2500),
          () => Navigator.of(context).pushReplacementNamed(RouteName.home).then(
                (value) => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (ctx) => const WithoutAuthScreen(),
                    settings: const RouteSettings(
                      arguments: false,
                    ),
                  ),
                  (route) => false,
                ),
              ),
        );
      }
    } else {
      Timer(
        const Duration(milliseconds: 2500),
        () => Navigator.of(context)
            .pushNamedAndRemoveUntil(RouteName.home, (route) => false),
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
