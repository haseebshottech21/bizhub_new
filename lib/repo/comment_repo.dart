import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/app_url.dart';
import '../utils/utils.dart';

class CommentRepository {
  Future<dynamic> sendOfferApi(dynamic data) async {
    try {
      http.Response response = await http.post(
        Uri.parse(AppUrl.sendOfferEndPoint),
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
      // Fluttertoast.showToast(msg: e.toString());
    }
  }
}
