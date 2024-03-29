import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/dummy_data.dart';
import '../utils/routes/routes_name.dart';
import '../widgets/onboard_widget.dart';
// import 'auth/without_auth_screen.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({Key? key}) : super(key: key);

  static const routeName = '/onboard';

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  // final prefrences = Prefrences();
  int currentPage = 0;

  void checkAuth() async {
    // Timer(
    //   Duration.zero,
    //   () => Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (ctx) => const WithoutAuthScreen(),
    //       settings: const RouteSettings(
    //         arguments: false,
    //       ),
    //     ),
    //   ),
    // );
    Timer(
      Duration.zero,
      () => Navigator.of(context)
          .pushNamedAndRemoveUntil(RouteName.getMyAddress, (route) => false),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(systemNavigationBarColor: Colors.black),
    );
    return SafeArea(
      child: SizedBox(
        child: Stack(
          children: [
            PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemCount: onboardData.length,
              itemBuilder: (context, index) => OnBoardWidget(
                backimg: onboardData[index].image,
                title: onboardData[index].text,
                desc: onboardData[index].description,
                onPressed: checkAuth,
                // desc2: onboardData[index].subDes,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardData.length,
                      (index) => builDot(index),
                    ),
                  ),
                  // const SizedBox(height: 20)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  AnimatedContainer builDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 8),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: currentPage == index
            ? const Color(0xFF0ca20d)
            : const Color(0xFF404040),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
