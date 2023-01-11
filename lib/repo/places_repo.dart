import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../model/place_detail_model.dart';
import 'package:http/http.dart' as http;
import '../utils/utils.dart';

class PlacesRepo {
  String mapAPIKEY = 'AIzaSyCSD5azLj8EdgAmcNdIFAq08bhij-4O7RU';

  static Future<String?> fetchUrl(Uri uri,
      {Map<String, String>? header}) async {
    try {
      final response = await http.get(uri, headers: header);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<PlaceDetailModel> fetchPlacesDetail(String placeId) async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://maps.googleapis.com/maps/api/place/details/json?key=$mapAPIKEY&place_id=$placeId',
        ),
      );

      final loadedData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // print(loadedData);
        final placeDetail = PlaceDetailModel.fromJson(loadedData['result']);
        return placeDetail;
      } else {
        return PlaceDetailModel.fromEmptyJson();
      }
    } catch (e) {
      Utils.toastMessage(e.toString());
      return PlaceDetailModel.fromEmptyJson();
    }
  }
}
