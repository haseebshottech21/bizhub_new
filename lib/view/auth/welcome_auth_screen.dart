import 'package:bizhub_new/components/deafult_button.dart';
import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

class WelcomeAuthScreen extends StatelessWidget {
  const WelcomeAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // const FullBackground(assetImagePath: 'assets/images/intro_3_bg.png'),
          SizedBox(
            width: size.width,
            height: size.height,
            child: Image.asset(
              'assets/images/intro_3_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Join the Hub',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12.0),
                const Text(
                  'Post Find and Connect with',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30.0),
                DeafultButton(
                  title: 'LOGIN',
                  onPress: () {
                    Navigator.of(context).pushNamed(RouteName.login);
                  },
                ),
                // FormButton(
                //   text: 'LOGIN',
                //   color: AppColors.primaryColor,
                //   size: Size(size.width * 0.75, size.height * 0.065),
                //   onPressed: () {
                //     // Navigator.of(context).pushNamed(LoginScreen.routeName);
                //   },
                // ),
                const SizedBox(height: 15.0),
                DeafultButton(
                  title: 'REGISTER',
                  color: Colors.white.withOpacity(0.3),
                  onPress: () {
                    Navigator.of(context).pushNamed(RouteName.signup);
                  },
                ),
                // FormButton(
                //   text: 'REGISTER',
                //   color: Colors.white.withOpacity(0.4),
                //   size: Size(size.width * 0.75, size.height * 0.065),
                //   onPressed: () {
                //     // Navigator.of(context).pushNamed(SignUpScreen.routeName);
                //   },
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
