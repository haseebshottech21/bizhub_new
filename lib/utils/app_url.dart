import 'package:bizhub_new/utils/shared_prefrences.dart';

class AppUrl {
  final prefrences = Prefrences();
  // static var baseUrl = 'https://dev81.myprojectstaging.net/custom/crm';
  static var baseUrl = 'http://10.0.0.39:125';

  // Auth
  static var loginEndPoint = '$baseUrl/api/login';
  static var signUpEndPoint = '$baseUrl/api/register';
  static var updateUserEndPoint = '$baseUrl/api/update-user';
  static var logoutEndPoint = '$baseUrl/api/logout';

  // Show User
  static var showUserEndPoint = '$baseUrl/api/show-user';

  static const Map<String, String> header = {
    'Accept': 'application/json',
    // 'Content-Type': 'application/json'
  };

  Future<Map<String, String>> headerWithAuth() async {
    return {
      'Accept': 'application/json',
      'Authorization':
          'Bearer ${await prefrences.getSharedPreferenceValue('token')}'
    };
  }
}
