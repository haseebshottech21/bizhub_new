import 'package:bizhub_new/repo/places_repo.dart';
import 'package:bizhub_new/utils/shared_prefrences.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../model/place_detail_model.dart';
import '../model/place_detail_model.dart';
import '../model/place_model.dart';

class LocationViewModel extends ChangeNotifier {
  LatLng latLng = const LatLng(0.0, 0.0);
  String address = '';

  String get getAddress => address;

  List<PlacesModel> placesList = [];
  PlaceDetailModel placeDetailModel = PlaceDetailModel.fromEmptyJson();
  PlacesRepo placesRepo = PlacesRepo();
  final prefrences = Prefrences();

  set setAddress(
    String address,
  ) {
    this.address = address;
    notifyListeners();
  }

  final GeolocatorPlatform _geoLocatorPlatform = GeolocatorPlatform.instance;

  Future<bool> _handlePermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission != LocationPermission.always) {
      permission = await _geoLocatorPlatform.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  Future<LatLng?> getCurrentLocation(BuildContext context) async {
    bool permission = await _handlePermission();
    if (permission) {
      final geoPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latLng = LatLng(geoPosition.latitude, geoPosition.longitude);
      // final registrationCompanyProvider =
      //     Provider.of<RegisterCompanyViewModel>(context, listen: false);

      await getLocationFromCoordinates(latLng);
    }
    return null;
  }

  Future<void> getStoreLocationIfExist(BuildContext context) async {
    final longitude = await prefrences.getSharedPreferenceValue('longitude');
    // final latitude = await utilities.getSharedPreferenceValue('latitude');
    // final address = await utilities.getSharedPreferenceValue('address');
    // print('$longitude long');
    // print('$latitude lat');
    // print('$address address');
    if (longitude == null) {
      await getCurrentLocation(context);
    }
    if (longitude != null) {
      await getLocalCoordinates();
    }
    notifyListeners();
  }

  setLocalCoordinates(LatLng coordinate, String address) {
    placeDetailModel =
        PlaceDetailModel(placeAddress: getAddress, placeLocation: coordinate);
    prefrences.setSharedPreferenceValue(
        'longitude', coordinate.longitude.toString());
    prefrences.setSharedPreferenceValue(
        'latitude', coordinate.latitude.toString());
    prefrences.setSharedPreferenceValue('address', address);
    // notifyListeners();
    getLocalCoordinates();
  }

  Future<void> getLocalCoordinates() async {
    final longitude = await prefrences.getSharedPreferenceValue('longitude');
    final latitude = await prefrences.getSharedPreferenceValue('latitude');
    final address = await prefrences.getSharedPreferenceValue('address');
    placeDetailModel = PlaceDetailModel(
      placeAddress: address.toString(),
      placeLocation: LatLng(
        double.parse(latitude.toString()),
        double.parse(longitude.toString()),
      ),
    );
  }

  Future<void> getLocationFromCoordinates(LatLng coordinate) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(
      coordinate.latitude,
      coordinate.longitude,
    );
    final address = placeMarks.first;
    setAddress =
        '${address.street}, ${address.subLocality}, ${address.locality}, ${address.administrativeArea}, ${address.postalCode}, ${address.country}';
    setAddress = this.address.replaceAll(', ,', ',');
    setLocalCoordinates(coordinate, getAddress);
  }

  setLatLng(LatLng latitudeAndLogitude) async {
    latLng = latitudeAndLogitude;
    await getLocationFromCoordinates(latitudeAndLogitude);
    notifyListeners();
  }

  Future<void> getPlaces(String query) async {
    // if (!(await Utilities().isInternetAvailable())) {
    //   return;
    // }
    // print(query);
    placesList = await placesRepo.getPlaces(query);
    notifyListeners();
  }

  Future<void> getPlaceDetail(String placeId) async {
    final detailModel = await placesRepo.getPlaceDetail(placeId);
    setLocalCoordinates(detailModel.placeLocation, detailModel.placeAddress);
    notifyListeners();
  }
}
