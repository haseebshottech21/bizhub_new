import 'package:flutter/foundation.dart';

class BottomNavigationViewModel with ChangeNotifier {
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
}
