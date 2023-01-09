import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/routes/routes_name.dart';
import '../utils/shared_prefrences.dart';
import '../view/auth/without_auth_screen.dart';

class BottomNavigationViewModel with ChangeNotifier {
  final prefrences = Prefrences();
  String? token;

  int bottomIndex = 0;

  int get currentIndex => bottomIndex;

  // set currentIndex(int index) {
  //   _currentIndex = index;
  //   notifyListeners();
  // }

  toggleCurrentIndex(int index) {
    bottomIndex = index;
    notifyListeners();
  }

  // toggleCurrentIndex(BuildContext context, int index) {
  //   // print('Bottom Index initial: $index');

  //   if (token == null || token == '') {
  //     if (bottomIndex == 0 || bottomIndex == 3) {
  //       if (index == 1 || index == 2) {
  //         // bottomIndex = 0;
  //         // print('Bottom Index: $bottomIndex');
  //         // print('Index: $index');
  //         Timer(
  //           Duration.zero,
  //           () => Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (ctx) => const WithoutAuthScreen(),
  //               settings: const RouteSettings(
  //                 arguments: true,
  //               ),
  //             ),
  //           ),
  //         );
  //       } else {
  //         // print('INDEX $index');
  //         if (bottomIndex == 0 || bottomIndex == 3) {
  //           print('object');
  //           bottomIndex = index;
  //           notifyListeners();
  //         }
  //       }
  //     }
  //   } else {
  //     bottomIndex = index;
  //     notifyListeners();
  //   }
  //   // else {
  //   //   print('Bottom Index: $bottomIndex');
  //   //   print('Index: $index');

  //   // }
  //   // notifyListeners();
  // }

  checkToken() async {
    token = await prefrences.getSharedPreferenceValue('token');
    notifyListeners();
    // print('BOTTOM TOKEN: $token');
  }

  // checkAuth(BuildContext context, int? index) async {
  //   // token = await prefrences.getSharedPreferenceValue('token');
  //   checkToken();
  //   if (token == null || token == '') {
  //     if (index == 1 || index == 2) {
  //       Timer(
  //         Duration.zero,
  //         () => Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (ctx) => const WithoutAuthScreen(),
  //             settings: const RouteSettings(arguments: false),
  //           ),
  //         ),
  //       );
  //     }
  //   } else {
  //     toggleCurrentIndex(index!);
  //   }
  // }

  cerateNewPost(BuildContext context) async {
    checkToken();
    if (token == null || token == '') {
      Timer(
        Duration.zero,
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => const WithoutAuthScreen(),
            settings: const RouteSettings(arguments: false),
          ),
        ),
      );
    } else {
      Navigator.of(context).pushNamed(RouteName.selectService);
    }
  }

  // showDialog(BuildContext context) {
  //   return bottomIndex == 2
  //       ? showGeneralDialog(
  //           context: context,
  //           barrierColor: Colors.white, // Background color
  //           barrierDismissible: false,
  //           barrierLabel: 'Dialog',
  //           transitionDuration: const Duration(milliseconds: 200),
  //           pageBuilder: (_, __, ___) {
  //             return Padding(
  //               padding:
  //                   const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   // Icon(Icons.close, color: Colors.white)
  //                   ElevatedButton(
  //                     onPressed: () {
  //                       Provider.of<BottomNavigationViewModel>(context,
  //                               listen: false)
  //                           .bottomIndex = 0;
  //                       Navigator.of(context).pushNamedAndRemoveUntil(
  //                         RouteName.home,
  //                         (route) => false,
  //                       );
  //                     },
  //                     child: const Text('Close'),
  //                   )
  //                   // IconButton(
  //                   //   icon: const Icon(Icons.close),
  //                   //   onPressed: () => Navigator.pop(context),
  //                   //   // child: const Text('Dismiss'),
  //                   // ),
  //                   // Expanded(
  //                   //   flex: 5,
  //                   //   // child: SizedBox.expand(child: FlutterLogo()),
  //                   //   child: Container(
  //                   //     color: Colors.white,
  //                   //   ),
  //                   // ),
  //                   // // Expanded(
  //                   // //   flex: 1,
  //                   // //   child: SizedBox.expand(
  //                   // //     child: IconButton(
  //                   // //       onPressed: () {},
  //                   // //       icon: Icon(
  //                   // //         Icons.close,
  //                   // //         color: Colors.red,
  //                   // //       ),
  //                   // //     ),
  //                   // //   ),
  //                   // // ),
  //                   // Expanded(
  //                   //   flex: 1,
  //                   //   child: SizedBox.expand(
  //                   //     child: IconButton(
  //                   //       icon: const Icon(Icons.close),
  //                   //       onPressed: () => Navigator.pop(context),
  //                   //       // child: const Text('Dismiss'),
  //                   //     ),
  //                   //   ),
  //                   // ),
  //                 ],
  //               ),
  //             );
  //           },
  //         )
  //       : const SizedBox();
  // }
}
