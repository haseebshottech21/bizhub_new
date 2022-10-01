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

  // All Services
  Future<List<ServiceModel>> fetchAllServicesList({
    required String serviceType,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('${AppUrl.allServiceEndPoint}?type=$serviceType'),
        headers: await AppUrl().headerWithAuth(),
      );
      // print('${AppUrl.allServiceEndPoint}?type=$serviceType');
      final loadedData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<ServiceModel> allServicesList = (loadedData['data'] as List)
            .map((e) => ServiceModel.fromJson(e))
            .toList();
        return allServicesList;
      } else {
        Utils.toastMessage(loadedData['message']);
      }
    } catch (e) {
      Utils.toastMessage(e.toString());
    }
    return [];
  }

  Future<ServiceModel?> fetchAllService({
    required String serviceId,
  }) async {
    ServiceModel? allService;
    try {
      final response = await http.get(
        Uri.parse('${AppUrl.myPosterServiceDetailEndPoint}/$serviceId'),
        headers: await AppUrl().headerWithAuth(),
      );
      // print(response.body);
      final loadedData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // ServiceModel myPosterService =
        //     loadedData['data'].map((e) => ServiceModel.fromJson(e)).toList();
        allService = ServiceModel.fromJson(loadedData['data']);
        // print(myPosterService);
        return allService;
      } else {
        Utils.toastMessage(loadedData['message']);
      }
    } catch (e) {
      Utils.toastMessage(e.toString());
    }
    return allService;
  }

  // POSTER
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

  Future<ServiceModel?> fetchMyPosterService({
    required String serviceId,
  }) async {
    ServiceModel? myPosterService;
    try {
      final response = await http.get(
        Uri.parse('${AppUrl.myPosterServiceDetailEndPoint}/$serviceId'),
        headers: await AppUrl().headerWithAuth(),
      );
      // print(response.body);
      final loadedData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // ServiceModel myPosterService =
        //     loadedData['data'].map((e) => ServiceModel.fromJson(e)).toList();
        myPosterService = ServiceModel.fromJson(loadedData['data']);
        // print(myPosterService);
        return myPosterService;
      } else {
        Utils.toastMessage(loadedData['message']);
      }
    } catch (e) {
      Utils.toastMessage(e.toString());
    }
    return myPosterService;
  }

  // WORKER
  Future<List<ServiceModel>> fetchMyWorkerServiceList() async {
    try {
      final response = await http.get(
        Uri.parse(AppUrl.myWorkerServiceEndPoint),
        headers: await AppUrl().headerWithAuth(),
      );
      // print(response.body);
      final loadedData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<ServiceModel> myWorkerServiceList = (loadedData['data'] as List)
            .map((e) => ServiceModel.fromJson(e))
            .toList();
        return myWorkerServiceList;
      } else {
        Utils.toastMessage(loadedData['message']);
      }
    } catch (e) {
      Utils.toastMessage(e.toString());
    }
    return [];
  }

  // DELETE
  Future<bool> deleteMyService({
    required String serviceId,
  }) async {
    // ServiceModel? myPosterService;
    try {
      final response = await http.delete(
        Uri.parse('${AppUrl.deleteMyServiceEndPoint}/$serviceId'),
        headers: await AppUrl().headerWithAuth(),
      );
      // print(response.body);
      final loadedData = json.decode(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        Utils.toastMessage(loadedData['message']);
        return false;
      }
    } catch (e) {
      Utils.toastMessage(e.toString());
      return false;
    }
  }
}
