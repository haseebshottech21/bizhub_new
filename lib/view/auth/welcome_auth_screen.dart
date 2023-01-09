// import 'package:bizhub_new/components/deafult_button.dart';
// import 'package:bizhub_new/utils/routes/routes_name.dart';
// import 'package:flutter/material.dart';

// import '../../utils/utils.dart';

// class WelcomeAuthScreen extends StatelessWidget {
//   const WelcomeAuthScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final phoneDevice = Utils.getDeviceType() == 'phone';

//     return Scaffold(
//       body: Stack(
//         children: [
//           SizedBox(
//             width: size.width,
//             height: size.height,
//             child: Image.asset(
//               'assets/images/intro_3_bg.png',
//               fit: phoneDevice ? BoxFit.cover : BoxFit.fill,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 30, left: 6, right: 6),
//             child: Column(
//               // crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 const SizedBox(height: 12.0),
//                 const Text(
//                   'Join the Hub',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 12.0),
//                 const Text(
//                   'Post Find and Connect',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 17,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 30.0),
//                 // DeafultButton(
//                 //   title: 'Explore',
//                 //   onPress: () {
//                 //     Navigator.of(context).pushNamed(RouteName.explore);
//                 //   },
//                 // ),
//                 // const SizedBox(height: 15.0),
//                 DeafultButton(
//                   title: 'LOGIN',
//                   onPress: () {
//                     Navigator.of(context).pushNamed(RouteName.login);
//                   },
//                 ),
//                 const SizedBox(height: 15.0),
//                 DeafultButton(
//                   title: 'REGISTER',
//                   color: Colors.white.withOpacity(0.3),
//                   onPress: () {
//                     Navigator.of(context).pushNamed(RouteName.signup);
//                   },
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
