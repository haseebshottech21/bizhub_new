class AppUrl {
  // final prefrences = Prefrences();
  // static var baseUrl = 'https://dev81.myprojectstaging.net/custom/crm';
  static var baseUrl = 'http://10.0.0.39:125';

  // Auth
  static var loginEndPoint = '$baseUrl/api/login';

  static const Map<String, String> header = {
    'Accept': 'application/json',
    // 'Content-Type': 'application/json'
  };

  Future<Map<String, String>> headerWithAuth() async {
    return {
      'Accept': 'application/json',
      // 'Authorization':
      //     'Bearer ${await prefrences.getSharedPreferenceValue('token')}'
    };
  }
}
