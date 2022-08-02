import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  // final _myRepo = AuthRepository();

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

  bool _signupLoading = false;
  bool get signupLoading => _signupLoading;

  signUpLoading(bool value) {
    _signupLoading = value;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    setLoad(true);
    Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        setLoad(false);
        Navigator.pushNamed(context, RouteName.home);
      },
    );
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

  // Future<void> loginApi(dynamic data, BuildContext context) async {
  //   setLoading(true);
  //   _myRepo.loginApi(data).then((value) {
  //     setLoading(false);
  //     final userPrefrence = Provider.of<UserViewModel>(context, listen: false);
  //     userPrefrence.saveUser(
  //       UserModel(token: value['token'].toString()),
  //     );
  //     Utils.flushBarMessage('Login Successfull', context);
  //     Navigator.pushNamed(context, RouteName.home);
  //     if (kDebugMode) {
  //       print(value.toString());
  //     }
  //   }).onError((error, stackTrace) {
  //     setLoading(false);
  //     Utils.flushBarMessage(error.toString(), context);
  //     if (kDebugMode) {
  //       print(error.toString());
  //     }
  //   });
  // }

  // Future<void> signUpApi(dynamic data, BuildContext context) async {
  //   signUpLoading(true);
  //   _myRepo.registerApi(data).then((value) {
  //     signUpLoading(false);
  //     Utils.flushBarMessage('Signup Successfully', context);
  //     Navigator.pushNamed(context, RouteName.home);
  //     if (kDebugMode) {
  //       print(value.toString());
  //     }
  //   }).onError((error, stackTrace) {
  //     signUpLoading(false);
  //     Utils.flushBarMessage(error.toString(), context);
  //     if (kDebugMode) {
  //       print(error.toString());
  //     }
  //   });
  // }
}
