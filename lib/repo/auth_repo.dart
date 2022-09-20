import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import '../utils/app_url.dart';
import 'package:http/http.dart' as http;

import '../utils/utils.dart';

class AuthRepository {
  Future<dynamic> loginApi(dynamic data) async {
    try {
      http.Response response = await http.post(
        Uri.parse(AppUrl.loginEndPoint),
        body: data,
        headers: AppUrl.header,
      );
      final responseLoaded = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // await setCrediential(responseLoaded['data']);

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
      Fluttertoast.showToast(msg: e.toString());
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
}
