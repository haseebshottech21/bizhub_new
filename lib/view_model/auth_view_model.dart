// import 'package:bizhub_new/model/user_model.dart';
import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:bizhub_new/utils/shared_prefrences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/user_model.dart';
import '../repo/auth_repo.dart';
import '../utils/utils.dart';
import 'bottom_navigation_view_model.dart';

class AuthViewModel extends ChangeNotifier {
  final authRepo = AuthRepository();
  final prefrences = Prefrences();
  UserModel? user;

  // bool isLoading = false;

  bool passwordHide = true;
  bool confirmPasswordHide = true;
  togglePassword() {
    passwordHide = !passwordHide;
    notifyListeners();
  }

  toggleConfirmPassword() {
    confirmPasswordHide = !confirmPasswordHide;
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

  bool _btnloading = false;
  bool get btnloading => _btnloading;
  setbtnLoad(bool status) {
    _btnloading = status;
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

  Map<String, String> prefrence = {
    'firstName': '',
    'lastName': '',
    'email': '',
    'phone': '',
  };

  void setPrefrenceValues() async {
    final firstName = await prefrences.getSharedPreferenceValue('firstname');
    final lastName = await prefrences.getSharedPreferenceValue('lastname');
    final email = await prefrences.getSharedPreferenceValue('email');
    final phone = await prefrences.getSharedPreferenceValue('phone');
    prefrence = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
    };
    print(prefrence);
    notifyListeners();
  }

  String getPrefrenceValue(String key) {
    return (prefrence[key] ?? '').toString();
  }

  Future<void> getUser(
    BuildContext context,
  ) async {
    setLoad(true);
    user = await authRepo.showUser();
    if (user != null) {
      setLoad(false);
    }
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

  Future<void> signIn(BuildContext context) async {
    setLoad(true);
    Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        setLoad(false);
        Navigator.of(context).pushNamedAndRemoveUntil(
          RouteName.home,
          (route) => false,
        );
      },
    );
  }

  // getUser() async {
  //   setLoad(true);
  //   user = (await authRepo.g());
  //   // print(user!.email.toString());
  //   setLoad(false);

  //   notifyListeners();

  //   // print(post.length);
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
            // print(loadedData['message'].toString());
            Utils.toastMessage('Logging Successfully!');
          }
        },
      );
    }
  }

  Future<void> signUp(
    dynamic data,
    BuildContext context,
  ) async {
    setLoad(true);
    final loadedData = await authRepo.registerApi(data);
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
            Navigator.pushNamed(context, RouteName.otpSuccess);
            // print('Successfully Login');
            Utils.toastMessage('Register Successfully!');
          }
        },
      );
    }
  }

  Future<void> updateUser(
    dynamic data,
    BuildContext context,
  ) async {
    setbtnLoad(true);
    final loadedData = await authRepo.updateUserApi(data);
    // print(loadedData);
    if (loadedData == null) {
      setbtnLoad(false);
    } else if (loadedData != null) {
      Future.delayed(const Duration(seconds: 1)).then(
        (value) {
          // print(value);
          setbtnLoad(false);
          if (kDebugMode) {
            // clearFields();
            Navigator.of(context).pop();
            // print('Successfully Login');
            Utils.toastMessage('Successfully Update');
          }
        },
      );
    }
  }

  // Future<void> signUp(BuildContext context) async {
  //   setLoad(true);
  //   Future.delayed(const Duration(seconds: 3)).then(
  //     (value) {
  //       setLoad(false);
  //       Navigator.pushNamed(context, RouteName.otp);
  //     },
  //   );
  // }

  Future<void> otpVerify(BuildContext context) async {
    setLoad(true);
    Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        setLoad(false);
        Navigator.pushNamed(context, RouteName.otpSuccess);
      },
    );
  }

  // Future<void> logout(BuildContext context) async {
  //   setLoad(true);
  //   Future.delayed(const Duration(seconds: 3)).then(
  //     (value) {
  //       setLoad(false);
  //       Provider.of<BottomNavigationViewModel>(context, listen: false)
  //           .bottomIndex = 0;
  //       Navigator.pushNamed(context, RouteName.login);
  //     },
  //   );
  // }

  Future<void> logout(
    BuildContext context,
  ) async {
    setLoad(true);
    final loadedData = await authRepo.logoutApi();
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
            Navigator.pushNamed(context, RouteName.otp);

            Provider.of<BottomNavigationViewModel>(context, listen: false)
                .bottomIndex = 0;
            Navigator.pushNamed(context, RouteName.login);
            // print('Successfully Login');
            Utils.toastMessage('Logged Out');
          }
        },
      );
    }
  }
}
