import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceDetailModel {
  String placeAddress;
  LatLng placeLocation;
  PlaceDetailModel({
    required this.placeAddress,
    required this.placeLocation,
  });
  factory PlaceDetailModel.fromJson(Map<String, dynamic> json) {
    return PlaceDetailModel(
      placeAddress: json['formatted_address'],
      placeLocation: LatLng(
        json['geometry']['location']['lat'],
        json['geometry']['location']['lng'],
      ),
    );
  }
  factory PlaceDetailModel.fromEmptyJson() {
    return PlaceDetailModel(
      placeAddress: '',
      placeLocation: const LatLng(
        44.500000,
        -89.500000,
      ),
    );
  }
}
