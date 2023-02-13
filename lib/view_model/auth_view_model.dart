// import 'package:bizhub_new/model/user_model.dart';
import 'dart:convert';
import 'dart:io';
// import 'package:bizhub_new/repo/notification_repo.dart';
import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:bizhub_new/utils/shared_prefrences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/report_model.dart';
import '../model/user_model.dart';
import '../repo/auth_repo.dart';
import '../utils/utils.dart';
import 'bottom_navigation_view_model.dart';

class AuthViewModel extends ChangeNotifier {
  final authRepo = AuthRepository();
  final prefrences = Prefrences();
  File? image;
  UserModel? user;
  UserModel? viewUser;
  String? token;

  // bool isLoading = false;

  checkToken() async {
    token = await prefrences.getSharedPreferenceValue('token');
    print('TOKEN: $token');
  }

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

  bool isCheckTCAndPP = false;
  toggleTCAndPP() {
    isCheckTCAndPP = !isCheckTCAndPP;
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
    isCheckTCAndPP = false;
  }

  Map<String, dynamic> imageDetail = {
    'image': '',
    'imagePath': '',
    'extension': '',
    'local': false,
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
      'extension': image!.path.split('.').last,
      'local': true,
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

  Future<void> setPrefrenceValues() async {
    final firstName = await prefrences.getSharedPreferenceValue('firstname');
    final lastName = await prefrences.getSharedPreferenceValue('lastname');
    final image = await prefrences.getSharedPreferenceValue('image');
    final email = await prefrences.getSharedPreferenceValue('email');
    final phone = await prefrences.getSharedPreferenceValue('phone');
    prefrence = {
      'firstName': firstName.toString(),
      'lastName': lastName.toString(),
      'image': image.toString(),
      'email': email.toString(),
      'phone': phone.toString(),
    };
    // print(prefrence);
    notifyListeners();
  }

  String sendOTPEmail = '';

  Future<void> setSendOTPEmail(String otpEmail) async {
    await prefrences.setSharedPreferenceValue('otpemail', otpEmail);
    notifyListeners();
  }

  Future<void> getOTPEmail() async {
    sendOTPEmail = await prefrences.getSharedPreferenceValue('otpemail');
    notifyListeners();
  }

  dynamic getPrefrenceValue(dynamic key) {
    return (prefrence[key] ?? '').toString();
  }

  Future<void> getUser(
    BuildContext context,
  ) async {
    user = null;
    imageDetail['local'] = false;
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
      Future.delayed(Duration.zero).then(
        (value) {
          // print(value);
          setLoad(false);
          // if (kDebugMode) {
          // clearFields();
          // Navigator.of(context).pushNamedAndRemoveUntil(
          //   RouteName.home,
          //   (route) => false,
          // );
          Provider.of<BottomNavigationViewModel>(context, listen: false)
              .bottomIndex = 0;
          Navigator.of(context).pushNamedAndRemoveUntil(
            RouteName.home,
            (route) => false,
          );
          // print(loadedData['message'].toString());
          Utils.toastMessage('Logging Successfully!');
          // }
        },
      );
    }
  }

  Future<void> signUp(
    dynamic data,
    String otpEmail,
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
          // if (kDebugMode) {
          // clearFields();
          setSendOTPEmail(otpEmail);
          Navigator.pushNamed(context, RouteName.otp);
          // print('Successfully Login');
          Utils.toastMessage('Register Successfully!');
          // }
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
    // // print(loadedData);
    if (loadedData == null) {
      setbtnLoad(false);
    } else if (loadedData != null) {
      Future.delayed(const Duration(seconds: 1)).then(
        (value) async {
          setbtnLoad(false);
          Navigator.of(context).pop();
          setPrefrenceValues();
          await getUser(context);
          Utils.toastMessage('Successfully Update');
        },
      );
    }
  }

  // VIEW OTHER PROFILE
  Future<void> viewOtherProfile({
    required BuildContext context,
    required String userId,
  }) async {
    setLoad(true);
    Future.delayed(const Duration(seconds: 1)).then(
      (value) async {
        viewUser = await authRepo.showOtherUser(userId: userId);
        setLoad(false);
      },
    );
    notifyListeners();
  }

  Future<void> passwordVerificationEmail({
    required String emailAddress,
    required BuildContext context,
  }) async {
    setLoad(true);
    Map data = {'email': emailAddress};
    if (emailAddress.isNotEmpty) {
      await Prefrences().setSharedPreferenceValue('verifyemail', emailAddress);
    }
    final loadedData = await authRepo.forgotPasswordApi(data);
    if (loadedData == null) {
      setLoad(false);
    } else if (loadedData != null) {
      Future.delayed(const Duration(seconds: 1)).then(
        (value) {
          setLoad(false);
          Navigator.pushNamed(context, RouteName.resetPassword);
          Utils.toastMessage('Send Verification Code!');
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
          // if (kDebugMode) {
          Navigator.pushNamed(context, RouteName.login);
          Utils.toastMessage('Password Update Successfully!');
          // }
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
          // if (kDebugMode) {
          // clearFields();
          Navigator.of(context).pop();
          // print('Successfully Login');
          Utils.toastMessage('Password Update Successfully!');
          // }
        },
      );
    }
  }

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
          // if (kDebugMode) {
          Navigator.pushNamed(context, RouteName.otpSuccess);
          // Utils.toastMessage('Password Update Successfully!');
          // }
        },
      );
    }
  }

  Future<void> deleteAccount({
    required dynamic data,
    required BuildContext context,
  }) async {
    setLoad(true);
    final loadedData = await authRepo.deleteUserApi(data);
    print(loadedData);
    if (loadedData == null) {
      setLoad(false);
    } else if (loadedData != null) {
      Future.delayed(const Duration(seconds: 1)).then((value) {
        setLoad(false);
        Navigator.pop(context, true);
        Utils.toastMessage('Delete Account Success');
        // Future.delayed(const Duration(seconds: 5)).then((value) {
        Provider.of<BottomNavigationViewModel>(context, listen: false)
            .bottomIndex = 0;
        Navigator.of(context).pushNamedAndRemoveUntil(
          RouteName.login,
          (route) => false,
        );
        Utils.toastMessage('Logged Out');
        // });
      });
    }
  }

  Future<void> logout(
    BuildContext context,
  ) async {
    setLoad(true);
    final loadedData = await authRepo.logoutApi();
    // print(loadedData);
    if (loadedData == null) {
      setLoad(false);
    } else if (loadedData != null) {
      Future.delayed(const Duration(seconds: 1)).then((value) {
        // print(value);
        setLoad(false);
        // if (kDebugMode) {
        // clearFields();
        Provider.of<BottomNavigationViewModel>(context, listen: false)
            .bottomIndex = 0;
        // Navigator.pushNamed(context, RouteName.login);
        Navigator.of(context).pushNamedAndRemoveUntil(
          RouteName.home,
          (route) => false,
        );
        // NotificationRepo().deleteFcmToken();
        // print('Successfully Login');
        Utils.toastMessage('Logged Out');
      });
    }
  }

  String? reportReasonText;
  List<ReportModel> reportedData = [];

  // selectReportedReason(int index) {
  //   for (var element in reportedData) {
  //     element.isSelected = false;
  //   }
  //   reportedData[index].isSelected = true;
  //   reportReasonText = reportedData[index].reportText;
  //   print(reportReasonText);
  //   notifyListeners();
  // }

  // selectCategory(String id) {
  //   if (id == categoryId) {
  //     categoryId = '';
  //   } else {
  //     categoryId = id;
  //   }
  //   notifyListeners();
  // }
  String? reportedId;

  getReportedDate() {
    reportedData = [];
    reportedData.add(ReportModel(false, 'Inappriopate post'));
    reportedData.add(ReportModel(false, 'This user is threatenting me'));
    reportedData.add(ReportModel(false, 'This is a fake account'));
    reportedData.add(ReportModel(false, 'Spam'));
    reportedData.add(ReportModel(false, 'Fraud'));
    reportedData.add(ReportModel(false, 'Other'));
  }

  selectReportedReason(int index) {
    for (var element in reportedData) {
      element.isSelected = false;
    }
    reportedData[index].isSelected = true;
    reportReasonText = reportedData[index].reportText;
    notifyListeners();
  }

  unSelectReportedReason(TextEditingController controller) {
    for (var element in reportedData) {
      element.isSelected = false;
    }
    if (controller.text.isNotEmpty) {
      controller.clear();
    }
    notifyListeners();
  }

  Future<void> reportUser({
    required dynamic data,
    required BuildContext context,
    required TextEditingController controller,
  }) async {
    setLoad(true);
    await Future.delayed(const Duration(seconds: 1));
    // final loadedData = await chatRepo.sendOfferApi(data);
    final loadedData = await authRepo.reportOtherUser(data);
    if (loadedData == null) {
      setLoad(false);
    } else if (loadedData != null) {
      setLoad(false);
      await Future.delayed(const Duration(seconds: 1)).then((value) {
        controller.clear();
        Utils.toastMessage('Reported User Success!');
        Navigator.pop(context);
      });
    }
  }
}
