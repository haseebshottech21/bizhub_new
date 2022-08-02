import 'package:flutter/foundation.dart';

class BottomNavigationViewModel with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  // set currentIndex(int index) {
  //   _currentIndex = index;
  //   notifyListeners();
  // }

  toggleCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
