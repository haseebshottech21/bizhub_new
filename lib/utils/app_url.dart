import 'package:bizhub_new/utils/shared_prefrences.dart';

class AppUrl {
  final prefrences = Prefrences();
  // static var baseUrl = 'https://dev81.myprojectstaging.net/custom/crm';
  static var baseUrl = 'http://10.0.0.39:125';

  // Auth
  static var loginEndPoint = '$baseUrl/api/login';
  static var signUpEndPoint = '$baseUrl/api/register';
  static var forgotPasswordEndPoint = '$baseUrl/api/forget-password';
  static var resetPasswordEndPoint = '$baseUrl/api/reset-password';
  static var updateUserEndPoint = '$baseUrl/api/update-user';
  static var updatePasswordEndPoint = '$baseUrl/api/change-password';
  static var logoutEndPoint = '$baseUrl/api/logout';

  //  Categories
  static var showCategoriesEndPoint = '$baseUrl/api/categories-show';

  // User
  static var showUserEndPoint = '$baseUrl/api/show-user';

  // Service
  static var createServiceEndPoint = '$baseUrl/api/add-service';
  static var allServiceEndPoint = '$baseUrl/api/service';
  static var myPosertServiceEndPoint = '$baseUrl/api/my-services';
  static var myWorkerServiceEndPoint = '$baseUrl/api/my-worker-services';
  static var myPosterServiceDetailEndPoint = '$baseUrl/api/service-detail';
  static var deleteMyServiceEndPoint = '$baseUrl/api/delete-service';

  // Chats
  static var sendOfferEndPoint = '$baseUrl/api/send-offer';
  static var posterChatListEndPoint = '$baseUrl/api/poster-offer-list';
  static var workerChatListEndPoint = '$baseUrl/api/service-offer-list';
  static var messagesListEndPoint = '$baseUrl/api/fetch-chat';

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
