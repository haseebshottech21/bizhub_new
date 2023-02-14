import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/routes/routes_name.dart';
import '../utils/shared_prefrences.dart';
import '../view/auth/without_auth_screen.dart';

class BottomNavigationViewModel with ChangeNotifier {
  // PageController myPage = PageController(initialPage: 0);

  final prefrences = Prefrences();
  String? token;

  int bottomIndex = 0;

  int get currentIndex => bottomIndex;

  toggleCurrentIndex(int index) {
    bottomIndex = index;
    // myPage.jumpToPage(index);
    notifyListeners();
  }

  toggleToChatIndex() {
    bottomIndex = 2;
    notifyListeners();
  }

  checkToken() async {
    token = await prefrences.getSharedPreferenceValue('token');
    notifyListeners();
    // print('BOTTOM TOKEN: $token');
  }

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

  bool? myLocationEnable;

  routeCheck(BuildContext context) async {
    final navigator = Navigator.of(context);
    myLocationEnable =
        await Prefrences().getSharedPreferenceBoolValue('myloc') ?? false;
    if (myLocationEnable!) {
      navigator.pushNamedAndRemoveUntil(RouteName.home, (route) => false);
    } else {
      navigator.pushNamedAndRemoveUntil(
          RouteName.getMyAddress, (route) => false);
    }
  }
}

// class BottomController with ChangeNotifier {
//   int bottomSelectedIndex = 0;

//   PageController pageController = PageController(
//     initialPage: 0,
//     keepPage: true,
//   );

//   void pageChanged(int index) {
//     bottomSelectedIndex = index;
//     notifyListeners();
//   }

//   void bottomTapped(int index) {
//     bottomSelectedIndex = index;
//     pageController.animateToPage(
//       index,
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.ease,
//     );
//     notifyListeners();
//   }

//   void goToYellow() {
//     bottomSelectedIndex = 2;
//     pageController.animateToPage(
//       2,
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.ease,
//     );
//     notifyListeners();
//   }
// }
