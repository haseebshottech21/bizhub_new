import 'dart:convert';
import 'dart:developer';
// import 'package:dio/dio.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:bizhub_new/model/user_model.dart';

import '../utils/app_url.dart';
import 'package:http/http.dart' as http;

import '../utils/shared_prefrences.dart';
import '../utils/utils.dart';

class AuthRepository {
  final prefrence = Prefrences();
  // final response = await Dio().get(url);
  // final dio = Dio();

  // Future<dynamic> loginApi(dynamic data) async {
  //   try {
  //     dynamic response =
  //         await _apiServices.getPostApiResponse(AppUrl.loginEndPoint, data);
  //     // print(response);
  //     setCrediential(response['data']);
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<UserModel?> getUserData() async {
    UserModel? user;
    try {
      http.Response response = await http.get(
        Uri.parse(AppUrl.showUserEndPoint),
        headers: await AppUrl().headerWithAuth(),
      );
      // final response = await Dio().get(url);
      final responseLoaded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        user = UserModel.fromJson(responseLoaded['data']);
        return user;
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return user;
  }

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
      print(e.toString());
      Utils.toastMessage(e.toString());
      // Fluttertoast.showToast(msg: e.toString());
    }
    //   final responseLoaded = json.decode(response.body);
    //   // print(response.statusCode);
    //   if (response.statusCode == 200) {
    //     return Success(response: responseLoaded);
    //   } else {
    //     // print(responseLoaded['message'].toString());
    //     return Failure(errorResponse: responseLoaded['message']);
    //   }
    //   //   return Failure(
    //   //       code: userInvalidResponse, errorResponse: responseLoaded['']);
    //   // } on HttpException {
    //   //   return Failure(code: noInternet, errorResponse: 'No Internet');
    //   // } on FormatException {
    //   //   return Failure(code: inValidFormat, errorResponse: 'Invalid Format');
    //   // } catch (e) {
    //   //   return Failure(code: unknowError, errorResponse: 'Unknown Error');
    // } on SocketException {
    //   throw Failure(errorResponse: 'No Internet Connetion! ');
    // }
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

  // Future<dynamic> logoutApi() async {
  //   try {
  //     dynamic response =
  //         // final reesponse =
  //         await _apiServices.getLogoutApiResponse(AppUrl.logoutEndPoint);
  //     // print('res:  $reesponse');
  //     await removeCrediential();
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

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

  // Future<PostModel?> getSinglePostData() async {
  //   PostModel? result;
  //   try {
  //     // final response = await http.get(
  //     //   Uri.parse("https://jsonplaceholder.typicode.com/posts"),
  //     //   headers: {
  //     //     HttpHeaders.contentTypeHeader: "application/json",
  //     //   },
  //     // );
  //     final response = await Dio().get(url);

  //     if (response.statusCode == 200) {
  //       final item = response.data;
  //       result = PostModel.fromJson(item);
  //     } else {
  //       print("error");
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  //   return result;
  // }

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
    await prefrence.setSharedPreferenceValue(
      'email',
      loadedData['user']['email'],
    );
    await prefrence.setSharedPreferenceValue(
      'phone',
      loadedData['user']['phone'],
    );
  }

  Future<void> updateCrediential(dynamic loadedData) async {
    await prefrence.setSharedPreferenceValue(
        'firstname', loadedData['first_name']);
    await prefrence.setSharedPreferenceValue(
        'lastname', loadedData['last_name']);
    await prefrence.setSharedPreferenceValue('email', loadedData['email']);
    await prefrence.setSharedPreferenceValue('phone', loadedData['phone']);
  }

  Future<void> removeCrediential() async {
    await prefrence.removeSharedPreferenceValue('token');
    await prefrence.removeSharedPreferenceValue('firstname');
    await prefrence.removeSharedPreferenceValue('lastname');
    await prefrence.removeSharedPreferenceValue('email');
    await prefrence.removeSharedPreferenceValue('phone');
  }
}
