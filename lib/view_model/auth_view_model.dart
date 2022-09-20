import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../repo/auth_repo.dart';
import '../utils/utils.dart';

class AuthViewModel extends ChangeNotifier {
  final authRepo = AuthRepository();

  // bool isLoading = false;

  bool passwordHide = true;
  togglePassword() {
    passwordHide = !passwordHide;
    notifyListeners();
  }

  bool isRemember = false;
  checkRemeber() {
    isRemember = !isRemember;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoad(bool status) {
    _loading = status;
    notifyListeners();
  }

  // changLoadingState() {
  //   isLoading = !isLoading;
  //   notifyListeners();
  // }

  bool _signupLoading = false;
  bool get signupLoading => _signupLoading;

  signUpLoading(bool value) {
    _signupLoading = value;
    notifyListeners();
  }

  // Future<void> login(dynamic data, BuildContext context) async {
  //   setLoad(true);
  //   authRepo.loginApi(data).then((value) {
  //     Future.delayed(const Duration(seconds: 3)).then(
  //       (value) {
  //         // print(value);
  //         setLoad(false);
  //         if (kDebugMode) {
  //           // clearFields();
  //           Navigator.of(context).pushNamedAndRemoveUntil(
  //             RouteName.home,
  //             (route) => false,
  //           );
  //           print('Successfully Login');
  //           // Utils.toastMessage('Logging Successfully!');
  //           Fluttertoast.showToast(msg: 'Logging Successfully!');
  //         }
  //       },
  //     );
  //   }).onError((error, stackTrace) {
  //     setLoad(false);
  //     Fluttertoast.showToast(msg: error.toString());
  //     if (kDebugMode) {
  //       print(error.toString());
  //     }
  //   });
  // }

  Future<void> login(
    dynamic data,
    BuildContext context,
  ) async {
    setLoad(true);
    final loadedData = await authRepo.loginApi(data);
    // print(loadedData);
    if (loadedData == null) {
      setLoad(false);
    } else if (loadedData != null) {
      Future.delayed(const Duration(seconds: 1)).then(
        (value) {
          // print(value);
          setLoad(false);
          if (kDebugMode) {
            // clearFields();
            Navigator.of(context).pushNamedAndRemoveUntil(
              RouteName.home,
              (route) => false,
            );
            // print('Successfully Login');
            Utils.toastMessage('Logging Successfully!');
          }
        },
      );
    }
  }

  Future<void> signUp(BuildContext context) async {
    setLoad(true);
    Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        setLoad(false);
        Navigator.pushNamed(context, RouteName.otp);
      },
    );
  }

  Future<void> otpVerify(BuildContext context) async {
    setLoad(true);
    Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        setLoad(false);
        Navigator.pushNamed(context, RouteName.otpSuccess);
      },
    );
  }

  Future<void> logout(BuildContext context) async {
    setLoad(true);
    Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        setLoad(false);
        Navigator.pushNamed(context, RouteName.login);
      },
    );
  }
}
