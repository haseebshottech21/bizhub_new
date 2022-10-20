import 'dart:convert';
import '../model/place_detail_model.dart';
import '../model/place_model.dart';
import 'package:http/http.dart' as http;
import '../utils/utils.dart';

class PlacesRepo {
  String mapAPIKEY = 'AIzaSyCSD5azLj8EdgAmcNdIFAq08bhij-4O7RU';

  Future<List<PlacesModel>> getPlaces(String query) async {
    try {
      List<PlacesModel> placesList = [];
      final response = await http.get(
        Uri.parse(
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?key=$mapAPIKEY&input=$query',
        ),
      );
      final loadedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        placesList = (loadedData['predictions'] as List)
            .map((place) => PlacesModel.fromJson(place))
            .toList();
        return placesList;
      } else {
        return placesList;
      }
    } catch (e) {
      Utils.toastMessage(e.toString());
      return [];
    }
  }

  Future<PlaceDetailModel> getPlaceDetail(String placeId) async {
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
