import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import '../components/deafult_button.dart';
// import '../view/auth/without_auth_screen.dart';
// import '../view/splash_screen.dart';

class OnBoardWidget extends StatelessWidget {
  final String title, desc, backimg;
  final void Function()? onPressed;
  const OnBoardWidget({
    required this.title,
    required this.desc,
    // required this.desc2,
    required this.backimg,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: Image.asset(
              backimg,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () {
                // Navigator.of(context).pushReplacementNamed(RouteName.welcome);
                Navigator.of(context).pushReplacementNamed(RouteName.home);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Text(
                    'SKIP',
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 60, left: 6, right: 6),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12.0),
                Text(
                  desc,
                  style: const TextStyle(color: Colors.white, fontSize: 17),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5.0),
                // Text(
                //   desc2,
                //   style: const TextStyle(
                //     color: Colors.white,
                //     fontSize: 17,
                //     fontWeight: FontWeight.w600,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                const SizedBox(height: 20.0),
                // FormButton(
                //   text: 'Get Started',
                //   color: AppColors.primaryColor,
                //   size: Size(size.width * 0.75, size.height * 0.065),
                //   onPressed: () {
                //     Navigator.of(context)
                //         .pushReplacementNamed(WelcomeAuthScreen.routeName);
                //   },
                // ),
                DeafultButton(
                  title: 'GET STARTED',
                  onPress: onPressed,
                  // onPress: () {
                  //   // Navigator.of(context)
                  //   //     .pushReplacementNamed(RouteName.welcome);
                  //   if (SplashScreen.token == null ||
                  //       SplashScreen.token == '') {
                  //     Timer(
                  //       Duration.zero,
                  //       () => Navigator.pushReplacementNamed(
                  //               context, RouteName.home)
                  //           .then(
                  //         (value) => Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (ctx) => const WithoutAuthScreen(),
                  //             settings: const RouteSettings(
                  //               arguments: true,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   }
                  // },
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 10),
                //   child: ElevatedButton(
                //     onPressed: () {
                //       Navigator.of(context)
                //           .pushReplacementNamed(RouteName.welcome);

                //       // AuthController.instance.loginUser(
                //       //   emailController.text.trim(),
                //       //   passController.text.trim(),
                //       // );
                //     },
                //     style: ElevatedButton.styleFrom(
                //       primary: MyTheme.greenColor,
                //       shape: BeveledRectangleBorder(
                //         borderRadius: BorderRadius.circular(2),
                //       ),
                //     ),
                //     child: const Center(
                //       child: Padding(
                //         padding: EdgeInsets.all(12.0),
                //         child: Text(
                //           'GET STARTED',
                //           style: TextStyle(fontSize: 16),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 70.0),
              ],
            ),
          )
        ],
      ),
    );
  }
}
