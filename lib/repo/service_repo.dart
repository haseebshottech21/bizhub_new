import 'dart:convert';

import 'package:bizhub_new/model/service_model.dart';

import '../utils/app_url.dart';
import '../utils/shared_prefrences.dart';
import 'package:http/http.dart' as http;

import '../utils/utils.dart';

class ServiceRepository {
  final prefrence = Prefrences();

  Future<dynamic> createService(dynamic data) async {
    try {
      http.Response response = await http.post(
        Uri.parse(AppUrl.createServiceEndPoint),
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

  Future<List<ServiceModel>> fetchMyPosterServiceList() async {
    try {
      final response = await http.get(
        Uri.parse(AppUrl.myPosertServiceEndPoint),
        headers: await AppUrl().headerWithAuth(),
      );
      // print(response.body);
      final loadedData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<ServiceModel> myPosterServiceList = (loadedData['data'] as List)
            .map((e) => ServiceModel.fromJson(e))
            .toList();
        return myPosterServiceList;
      } else {
        Utils.toastMessage(loadedData['message']);
      }
    } catch (e) {
      Utils.toastMessage(e.toString());
    }
    return [];
  }
}
