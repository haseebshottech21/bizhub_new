import 'dart:convert';
import 'package:bizhub_new/model/user_model.dart';
import '../utils/app_url.dart';
import 'package:http/http.dart' as http;
import '../utils/shared_prefrences.dart';
import '../utils/utils.dart';

class AuthRepository {
  final prefrence = Prefrences();

  Future<UserModel> showUser() async {
    try {
      http.Response response = await http.get(
        Uri.parse(AppUrl.showUserEndPoint),
        headers: await AppUrl().headerWithAuth(),
      );
      final responseLoaded = jsonDecode(response.body);
      // print(response);
      updateCrediential(responseLoaded['data']);
      return UserModel.fromJson(responseLoaded['data']);
    } catch (e) {
      // print(e.toString());
      rethrow;
    }
  }

  Future<UserModel> showOtherUser({
    required String userId,
  }) async {
    try {
      http.Response response = await http.get(
        Uri.parse('${AppUrl.showUserEndPoint}/$userId'),
        headers: await AppUrl().headerWithAuth(),
      );
      final responseLoaded = jsonDecode(response.body);
      // print(response);
      return UserModel.fromJson(responseLoaded['data']);
    } catch (e) {
      // print(e.toString());
      rethrow;
    }
  }

  Future<dynamic> reportOtherUser(dynamic data) async {
    try {
      http.Response response = await http.post(
        Uri.parse(AppUrl.reportUserEndPoint),
        body: data,
        headers: await AppUrl().headerWithAuth(),
      );

      final responseLoaded = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return responseLoaded;
      } else {
        // Utils.toastMessage(responseLoaded['message']);
      }
    } catch (e) {
      // print(e.toString());
      Utils.toastMessage(e.toString());
      // Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<dynamic> loginApi(dynamic data) async {
    try {
      http.Response response = await http.post(
        Uri.parse(AppUrl.loginEndPoint),
        body: data,
        headers: AppUrl.header,
      );

      final responseLoaded = jsonDecode(response.body);

      // print(responseLoaded);

      if (response.statusCode == 200 || response.statusCode == 201) {
        await setCrediential(responseLoaded['data']);

        // print(responseLoaded);

        // if (isRemember) {
        //   await utilties.setSharedPreferenceValue('remember_email', email);
        //   await utilties.setSharedPreferenceValue(
        //       'remember_password', password);
        // } else {
        //   await utilties.removeSharedPreferenceValue('remember_email');
        //   await utilties.removeSharedPreferenceValue('remember_password');
        // }

        // Fluttertoast.showToast(msg: responseLoaded['message']);
        return responseLoaded;
      } else {
        Utils.toastMessage(responseLoaded['message']);
      }
    } catch (e) {
      // print(e.toString());
      Utils.toastMessage(e.toString());
      // Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<dynamic> registerApi(dynamic data) async {
    try {
      http.Response response = await http.post(
        Uri.parse(AppUrl.signUpEndPoint),
        body: data,
        headers: AppUrl.header,
      );

      final responseLoaded = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        setOTPCredientail(responseLoaded['data']);

        return responseLoaded;
      } else {
        if (responseLoaded is Map<String, dynamic> &&
            responseLoaded.containsKey('errors')) {
          final errors = responseLoaded['errors'] as Map<String, dynamic>;
          if (errors.containsKey('email')) {
            final emailErrors = errors['email'] as List<dynamic>;
            final errorMessage =
                emailErrors.isNotEmpty ? emailErrors.first : 'Unknown error';

            Utils.toastMessage(errorMessage.toString());
          }
        } else {
          Utils.toastMessage(responseLoaded['message']);
        }
      }
    } catch (e) {
      // print(e.toString());
      Utils.toastMessage(e.toString());
    }
  }

  Future<dynamic> validateOTPApi(dynamic data) async {
    try {
      http.Response response = await http.post(
        Uri.parse(AppUrl.validateOTPEndPoint),
        body: data,
        headers: AppUrl.header,
      );
      final responseLoaded = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        await prefrence.removeSharedPreferenceValue('uniqueId');
        await prefrence.removeSharedPreferenceValue('resendId');

        return responseLoaded;
      } else if (response.statusCode == 409 || response.statusCode == 404) {
        setResendOTPCredientail(responseLoaded['data']);
      } else {
        // print('status: ${response.statusCode}');
        // print(responseLoaded);
        if (responseLoaded is Map<String, dynamic> &&
            responseLoaded.containsKey('errors')) {
          final errors = responseLoaded['errors'] as Map<String, dynamic>;
          if (errors.containsKey('otp')) {
            final otpErrors = errors['otp'] as List<dynamic>;
            final errorMessage =
                otpErrors.isNotEmpty ? otpErrors.first : 'Unknown error';

            Utils.toastMessage(errorMessage.toString());
          }
        } else {
          // print('status: ${response.statusCode}');

          Utils.toastMessage(responseLoaded['message']);
        }
      }
    } catch (e) {
      // print(e.toString());
      Utils.toastMessage(e.toString());
      // Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<dynamic> resendOTPApi(dynamic data) async {
    try {
      http.Response response = await http.post(
        Uri.parse(AppUrl.resendOTPEndPoint),
        body: data,
        headers: AppUrl.header,
      );
      final responseLoaded = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        setOTPCredientail(responseLoaded['data']);

        // print(responseLoaded.toString());
        return responseLoaded;
      } else {
        Utils.toastMessage(responseLoaded['message']);
      }
    } catch (e) {
      Utils.toastMessage(e.toString());
    }
  }

  Future<dynamic> forgotPasswordApi(dynamic data) async {
    try {
      http.Response response = await http.post(
        Uri.parse(AppUrl.forgotPasswordEndPoint),
        body: data,
        headers: AppUrl.header,
      );
      final responseLoaded = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // print(responseLoaded.toString());
        return responseLoaded;
      } else {
        Utils.toastMessage(responseLoaded['message']);
      }
    } catch (e) {
      // print(e.toString());
      Utils.toastMessage(e.toString());
      // Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<dynamic> resetPasswordApi(dynamic data) async {
    try {
      http.Response response = await http.post(
        Uri.parse(AppUrl.resetPasswordEndPoint),
        body: data,
        headers: AppUrl.header,
      );
      final responseLoaded = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // print(responseLoaded.toString());
        return responseLoaded;
      } else {
        Utils.toastMessage(responseLoaded['message']);
      }
    } catch (e) {
      // print(e.toString());
      Utils.toastMessage(e.toString());
      // Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<dynamic> updateUserApi(dynamic data) async {
    try {
      http.Response response = await http.post(
        Uri.parse(AppUrl.updateUserEndPoint),
        body: data,
        headers: await AppUrl().headerWithAuth(),
      );
      final responseLoaded = jsonDecode(response.body);
      // print(responseLoaded);
      if (response.statusCode == 200 || response.statusCode == 201) {
        updateCrediential(responseLoaded['data']);
        return responseLoaded;
      } else {
        Utils.toastMessage(responseLoaded['message']);
        // print(responseLoaded['message']);
      }
    } catch (e) {
      // print(e.toString());
      Utils.toastMessage(e.toString());
    }
  }

  Future<dynamic> updatePasswordApi(dynamic data) async {
    try {
      http.Response response = await http.post(
        Uri.parse(AppUrl.updatePasswordEndPoint),
        body: data,
        headers: await AppUrl().headerWithAuth(),
      );
      final responseLoaded = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return responseLoaded;
      } else {
        Utils.toastMessage(responseLoaded['message']);
      }
    } catch (e) {
      // print(e.toString());
      Utils.toastMessage(e.toString());
    }
  }

  Future<dynamic> deleteUserApi(dynamic data) async {
    try {
      http.Response response = await http.post(
        Uri.parse(AppUrl.deleteUserEndPoint),
        body: data,
        headers: await AppUrl().headerWithAuth(),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        await removeCrediential();
        return responseData;
      } else {
        Utils.toastMessage(responseData['message']);
      }
    } catch (e) {
      Utils.toastMessage(e.toString());
    }
  }

  Future<dynamic> logoutApi() async {
    // var uri = Uri.parse(url);
    // dynamic responseJson;

    try {
      http.Response response = await http.get(
        Uri.parse(AppUrl.logoutEndPoint),
        headers: await AppUrl().headerWithAuth(),
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await removeCrediential();
        // await FirebaseMessaging.instance.deleteToken();
        return responseData;
      } else {
        Utils.toastMessage(responseData['message']);
      }
    } catch (e) {
      // print(e.toString());
      Utils.toastMessage(e.toString());
      // Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> setCrediential(dynamic loadedData) async {
    await prefrence.setSharedPreferenceValue(
      'token',
      loadedData['token'],
    );
    await prefrence.setSharedPreferenceValue(
      'firstname',
      loadedData['user']['first_name'],
    );
    await prefrence.setSharedPreferenceValue(
      'lastname',
      loadedData['user']['last_name'],
    );
    if (loadedData['user']['image'] != null) {
      await prefrence.setSharedPreferenceValue(
        'image',
        loadedData['user']['image'],
      );
    }
    await prefrence.setSharedPreferenceValue(
      'email',
      loadedData['user']['email'],
    );
    await prefrence.setSharedPreferenceValue(
      'phone',
      loadedData['user']['phone'],
    );
  }

  Future<void> setOTPCredientail(dynamic loadedData) async {
    await prefrence.setSharedPreferenceValue(
      'uniqueId',
      loadedData['uniqueId'],
    );
  }

  Future<void> setResendOTPCredientail(dynamic loadedData) async {
    await prefrence.setSharedPreferenceValue(
      'resendId',
      loadedData['resendId'],
    );
  }

  Future<void> updateCrediential(dynamic loadedData) async {
    await prefrence.setSharedPreferenceValue(
      'firstname',
      loadedData['first_name'],
    );
    await prefrence.setSharedPreferenceValue(
      'lastname',
      loadedData['last_name'],
    );
    if (loadedData['image'] != null) {
      await prefrence.setSharedPreferenceValue(
        'image',
        loadedData['image'],
      );
    }
    await prefrence.setSharedPreferenceValue('email', loadedData['email']);
    await prefrence.setSharedPreferenceValue('phone', loadedData['phone']);
  }

  Future<void> removeCrediential() async {
    await prefrence.removeSharedPreferenceValue('token');
    await prefrence.removeSharedPreferenceValue('firstname');
    await prefrence.removeSharedPreferenceValue('lastname');
    await prefrence.removeSharedPreferenceValue('image');
    await prefrence.removeSharedPreferenceValue('email');
    await prefrence.removeSharedPreferenceValue('phone');
    await prefrence.removeSharedPreferenceValue('categories');
  }
}
