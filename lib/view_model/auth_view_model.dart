// import 'package:bizhub_new/model/user_model.dart';
import 'dart:convert';
import 'dart:io';
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
  File? image;
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

  initialSignupValues() {
    imageDetail['imagePath'] = '';
    imageDetail['extension'] = '';
  }

  Map<String, String> imageDetail = {
    'image': '',
    'imagePath': '',
    'extension': ''
  };

  Future setImage({
    required BuildContext context,
    required File file,
  }) async {
    image = file;
    Navigator.of(context).pop();

    final bytes = File(image!.path).readAsBytesSync();
    // String base64Image = "data:image/${image!.path.split('.').last};base64,${base64Encode(bytes)}";
    String base64Image = base64Encode(bytes);
    imageDetail = {
      'image': base64Image,
      'imagePath': image!.path,
      'extension': image!.path.split('.').last
    };
    notifyListeners();
  }

  //       'image': 'data:image/${image.path.split('.').last};base64,' +
  //           base64Encode(await img.readAsBytes()),

  Map<String, String> prefrence = {
    'firstName': '',
    'lastName': '',
    'image': '',
    'email': '',
    'phone': '',
  };

  void setPrefrenceValues() async {
    final firstName = await prefrences.getSharedPreferenceValue('firstname');
    final lastName = await prefrences.getSharedPreferenceValue('lastname');
    final image = await prefrences.getSharedPreferenceValue('image');
    final email = await prefrences.getSharedPreferenceValue('email');
    final phone = await prefrences.getSharedPreferenceValue('phone');
    prefrence = {
      'firstName': firstName,
      'lastName': lastName,
      'image': image,
      'email': email,
      'phone': phone,
    };
    // print(prefrence);
    notifyListeners();
  }

  String getPrefrenceValue(String key) {
    return (prefrence[key] ?? '').toString();
  }

  Future<void> getUser(
    BuildContext context,
  ) async {
    user = null;
    setLoad(true);
    user ??= await authRepo.showUser();
    setLoad(false);
    // if (user != null) {
    //   setLoad(false);
    // }
    notifyListeners();
  }

  // Future<void> getMyPosterServiceList(
  //   BuildContext context,
  // ) async {
  //   setLoad(true);
  //   Future.delayed(const Duration(seconds: 3)).then(
  //     (value) async {
  //       // getMyPosts = getPosts();
  //       if (posterServiceList.isEmpty) {
  //         posterServiceList = await serviceRepo.fetchMyPosterServiceList();
  //       }
  //       setLoad(false);
  //     },
  //   );
  //   notifyListeners();
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
            Navigator.pushNamed(context, RouteName.otp);
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

  Future<void> passwordVerificationEmail({
    required String emailAddress,
    required BuildContext context,
  }) async {
    setLoad(true);
    Map data = {
      'email': emailAddress,
    };
    if (emailAddress.isNotEmpty) {
      await Prefrences().setSharedPreferenceValue('verifyemail', emailAddress);
    }
    final loadedData = await authRepo.forgotPasswordApi(data);
    // print(loadedData);
    if (loadedData == null) {
      setLoad(false);
    } else if (loadedData != null) {
      Future.delayed(const Duration(seconds: 1)).then(
        (value) {
          // print(value);
          setLoad(false);
          if (kDebugMode) {
            Navigator.pushNamed(context, RouteName.resetPassword);
            Utils.toastMessage('Send Verification Code!');
          }
        },
      );
    }
  }

  Future<void> resetPassword({
    required String verificationCode,
    required String newPassword,
    required String confirmNewPassword,
    required BuildContext context,
  }) async {
    setLoad(true);
    Map data = {
      'forget_token': verificationCode,
      'password': newPassword,
      'password_confirmation': confirmNewPassword,
      'email': await Prefrences().getSharedPreferenceValue('verifyemail'),
    };
    final loadedData = await authRepo.resetPasswordApi(data);
    // print(loadedData);
    if (loadedData == null) {
      setLoad(false);
    } else if (loadedData != null) {
      Future.delayed(const Duration(seconds: 1)).then(
        (value) {
          // print(value);
          setLoad(false);
          if (kDebugMode) {
            Navigator.pushNamed(context, RouteName.login);
            Utils.toastMessage('Password Update Successfully!');
          }
        },
      );
    }
  }

  Future<void> updatePassword(
    dynamic data,
    BuildContext context,
  ) async {
    setLoad(true);
    final loadedData = await authRepo.updatePasswordApi(data);
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
            Navigator.of(context).pop();
            // print('Successfully Login');
            Utils.toastMessage('Password Update Successfully!');
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

  Future<void> otpValidate({
    required String otpCode,
    required BuildContext context,
  }) async {
    setLoad(true);
    Map data = {
      'otp': otpCode,
      'unique_id': await Prefrences().getSharedPreferenceValue('uniqueId'),
    };
    final loadedData = await authRepo.validateOTPApi(data);
    // print(loadedData);
    if (loadedData == null) {
      setLoad(false);
    } else if (loadedData != null) {
      Future.delayed(const Duration(seconds: 1)).then(
        (value) {
          // print(value);
          setLoad(false);
          if (kDebugMode) {
            Navigator.pushNamed(context, RouteName.otpSuccess);
            // Utils.toastMessage('Password Update Successfully!');
          }
        },
      );
    }
  }

  // Future<void> otpVerify(BuildContext context) async {
  //   setLoad(true);
  //   Future.delayed(const Duration(seconds: 3)).then(
  //     (value) {
  //       setLoad(false);
  //       Navigator.pushNamed(context, RouteName.otpSuccess);
  //     },
  //   );
  // }

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
            Provider.of<BottomNavigationViewModel>(context, listen: false)
                .bottomIndex = 0;
            // Navigator.pushNamed(context, RouteName.login);
            Navigator.of(context).pushNamedAndRemoveUntil(
              RouteName.login,
              (route) => false,
            );
            // print('Successfully Login');
            Utils.toastMessage('Logged Out');
          }
        },
      );
    }
  }
}
