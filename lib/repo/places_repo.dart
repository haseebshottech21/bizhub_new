import 'dart:convert';
// import 'package:bizhub_new/model/place_auto_complete.dart';
import 'package:bizhub_new/model/place_auto_complete.dart';
import 'package:flutter/foundation.dart';

import '../model/place_detail_model.dart';
import '../model/place_model.dart';
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

  // static Future<PlaceDetail?> fetchDetailUrl(
  //   Uri uri, {
  //   Map<String, String>? header,
  // }) async {
  //   try {
  //     final response = await http.get(uri, headers: header);
  //     final loadedData = jsonDecode(response.body);

  //     if (response.statusCode == 200) {
  //       final placeDetail = PlaceDetail.fromJson(loadedData['result']);
  //       return placeDetail;
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  //   return null;
  // }

  // Future<List<PlacesModel>> getPlaces(String query) async {
  //   try {
  //     List<PlacesModel> placesList = [];
  //     final response = await http.get(
  //       Uri.parse(
  //         'https://maps.googleapis.com/maps/api/place/autocomplete/json?key=$mapAPIKEY&input=$query',
  //       ),
  //     );
  //     final loadedData = jsonDecode(response.body);

  //     if (response.statusCode == 200) {
  //       placesList = (loadedData['predictions'] as List)
  //           .map((place) => PlacesModel.fromJson(place))
  //           .toList();
  //       return placesList;
  //     } else {
  //       return placesList;
  //     }
  //   } catch (e) {
  //     Utils.toastMessage(e.toString());
  //     return [];
  //   }
  // }

  // Future<PlaceDetailModel> getPlaceDetail(String placeId) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse(
  //         'https://maps.googleapis.com/maps/api/place/details/json?key=$mapAPIKEY&place_id=$placeId',
  //       ),
  //     );

  //     final loadedData = jsonDecode(response.body);

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       // print(loadedData);
  //       final placeDetail = PlaceDetailModel.fromJson(loadedData['result']);
  //       return placeDetail;
  //     } else {
  //       return PlaceDetailModel.fromEmptyJson();
  //     }
  //   } catch (e) {
  //     Utils.toastMessage(e.toString());
  //     return PlaceDetailModel.fromEmptyJson();
  //   }
  // }
}
