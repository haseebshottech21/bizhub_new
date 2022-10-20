import 'package:bizhub_new/repo/places_repo.dart';
import 'package:bizhub_new/utils/shared_prefrences.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../model/place_detail_model.dart';
import '../model/place_detail_model.dart';
import '../model/place_model.dart';

// class LocationViewModel extends ChangeNotifier {
//   LatLng latLng = const LatLng(0.0, 0.0);
//   String address = '';
//   String postalCode = '';

//   String get getAddress => address;
//   String get getPostalCode => postalCode;

//   List<PlacesModel> placesList = [];
//   PlaceDetailModel placeDetailModel = PlaceDetailModel.fromEmptyJson();
//   PlacesRepo placesRepo = PlacesRepo();
//   final prefrences = Prefrences();

//   set setAddress(
//     String address,
//   ) {
//     this.address = address;
//     notifyListeners();
//   }

//   set setPostalCode(
//     String address,
//   ) {
//     this.address = address;
//     notifyListeners();
//   }

//   final GeolocatorPlatform _geoLocatorPlatform = GeolocatorPlatform.instance;

//   Future<bool> _handlePermission() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission != LocationPermission.always) {
//       permission = await _geoLocatorPlatform.requestPermission();
//       if (permission == LocationPermission.always ||
//           permission == LocationPermission.whileInUse) {
//         return true;
//       } else {
//         return false;
//       }
//     } else {
//       return true;
//     }
//   }

//   Future<LatLng?> getCurrentLocation(BuildContext context) async {
//     bool permission = await _handlePermission();
//     if (permission) {
//       final geoPosition = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//       latLng = LatLng(geoPosition.latitude, geoPosition.longitude);
//       // final registrationCompanyProvider =
//       //     Provider.of<RegisterCompanyViewModel>(context, listen: false);

//       await getLocationFromCoordinates(latLng);
//     }
//     return null;
//   }

//   Future<void> getStoreLocationIfExist(BuildContext context) async {
//     final longitude = await prefrences.getSharedPreferenceValue('longitude');
//     // final latitude = await utilities.getSharedPreferenceValue('latitude');
//     // final address = await utilities.getSharedPreferenceValue('address');
//     // print('$longitude long');
//     // print('$latitude lat');
//     // print('$address address');
//     if (longitude == null) {
//       await getCurrentLocation(context);
//     }
//     if (longitude != null) {
//       await getLocalCoordinates();
//     }
//     notifyListeners();
//   }

//   setLocalCoordinates(PlaceDetailModel placeDetailModel) {
//     prefrences.setSharedPreferenceValue(
//       'longitude',
//       placeDetailModel.placeLocation.longitude.toString(),
//     );
//     prefrences.setSharedPreferenceValue(
//       'latitude',
//       placeDetailModel.placeLocation.latitude.toString(),
//     );
//     prefrences.setSharedPreferenceValue('address', address);
//     // notifyListeners();
//     getLocalCoordinates();
//   }

//   Future<void> getLocalCoordinates() async {
//     final longitude = await prefrences.getSharedPreferenceValue('longitude');
//     final latitude = await prefrences.getSharedPreferenceValue('latitude');
//     final address = await prefrences.getSharedPreferenceValue('address');
//     final postalCode =
//         await prefrences.getSharedPreferenceValue('postal_code') ?? "0000";
//     placeDetailModel = PlaceDetailModel(
//       placeAddress: address.toString(),
//       placeLocation: LatLng(
//         double.parse(latitude.toString()),
//         double.parse(longitude.toString()),
//       ),
//       postalCode: postalCode.toString(),
//     );
//   }

//   Future<void> getLocationFromCoordinates(LatLng coordinate) async {
//     List<Placemark> placeMarks = await placemarkFromCoordinates(
//       coordinate.latitude,
//       coordinate.longitude,
//     );
//     final address = placeMarks.first;
//     setPostalCode = address.postalCode ?? "0000";
//     setAddress =
//         '${address.street}, ${address.subLocality}, ${address.locality}, ${address.administrativeArea}, ${address.postalCode}, ${address.country}';
//     setAddress = this.address.replaceAll(', ,', ',');

//     setLocalCoordinates(
//       PlaceDetailModel(
//         placeLocation: coordinate,
//         placeAddress: getAddress,
//         postalCode: getPostalCode,
//       ),
//     );
//   }

//   setLatLng(LatLng latitudeAndLogitude) async {
//     latLng = latitudeAndLogitude;
//     await getLocationFromCoordinates(latitudeAndLogitude);
//     notifyListeners();
//   }

//   Future<void> getPlaces(String query) async {
//     // if (!(await Utilities().isInternetAvailable())) {
//     //   return;
//     // }
//     // print(query);
//     placesList = await placesRepo.getPlaces(query);
//     notifyListeners();
//   }

//   Future<void> getPlaceDetail(String placeId) async {
//     final detailModel = await placesRepo.getPlaceDetail(placeId);
//     // setLocalCoordinates(detailModel.placeLocation, detailModel.placeAddress);
//     setLocalCoordinates(detailModel);
//     notifyListeners();
//   }
// }

class LocationViewModel with ChangeNotifier {
  PlaceDetailModel myCurrentLocation = PlaceDetailModel.fromEmptyJson();
  // PlaceDetailModel myDestinationLocation = PlaceDetailModel.fromEmptyJson();
  LatLng latLng = const LatLng(0.0, 0.0);
  String address = '';

  //   LatLng latLng = const LatLng(0.0, 0.0);
//   String address = '';
//   String postalCode = '';

  // GetLocationViewModel(): longitude=0,latitude=0,address='';

  set setAddress(
    String address,
  ) {
    this.address = address;
    notifyListeners();
  }

  String get getAddress => address;

  final GeolocatorPlatform _geoLocatorPlatform = GeolocatorPlatform.instance;

  updateMyLocation() {
    // if (placeDetailModel.placeAddress.isNotEmpty) {
    //   myCurrentLocation = placeDetailModel;
    //   if (setValue) {
    //     setLocalCoordinates(placeDetailModel);
    //   }
    //   notifyListeners();
    //   // Navigator.of(context).pop();
    // } else {
    //   // Fluttertoast.showToast(msg: "Please select a location");
    // }
    if (placeDetailModel.placeAddress.isNotEmpty) {
      myCurrentLocation = placeDetailModel;
      notifyListeners();
    }
  }

  // updatDestinationLoaction(context) {
  //   if (placeDetailModel.placeAddress.isNotEmpty) {
  //     myDestinationLocation = placeDetailModel;
  //     notifyListeners();
  //     // Navigator.of(context).pop();
  //   } else {
  //     // Fluttertoast.showToast(msg: 'Please select a destination');
  //   }
  // }

  String get getMyAddress => myCurrentLocation.placeAddress;
  // String get getDestinationAddress => myDestinationLocation.placeAddress;

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

  Future<void> getLocationFromCoordinates(LatLng coordinate) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(
      coordinate.latitude,
      coordinate.longitude,
    );
    final address = placeMarks.first;
    setAddress =
        '${address.street}, ${address.subLocality}, ${address.locality}, ${address.administrativeArea}, ${address.postalCode}, ${address.country}';
    setAddress = this.address.replaceAll(', ,', ',');

    // setLocalCoordinates(
    //     PlaceDetailModel(placeAddress: getAddress, placeLocation: coordinate));
  }

  setLocalCoordinates(PlaceDetailModel placeModel) async {
    // placeDetailModel = PlaceDetailModel(
    //   placeAddress: getAddress,
    //   placeLocation: coordinate,
    // );
    await prefrences.setSharedPreferenceValue(
      'longitude',
      placeModel.placeLocation.longitude.toString(),
    );
    await prefrences.setSharedPreferenceValue(
      'latitude',
      placeModel.placeLocation.latitude.toString(),
    );
    await prefrences.setSharedPreferenceValue(
      'address',
      placeModel.placeAddress,
    );
    // notifyListeners();
    // getLocalCoordinates();
  }

  Future<void> getLocalCoordinates() async {
    final longitude = await prefrences.getSharedPreferenceValue('longitude');
    final latitude = await prefrences.getSharedPreferenceValue('latitude');
    final address = await prefrences.getSharedPreferenceValue('address');

    myCurrentLocation = PlaceDetailModel(
      placeAddress: address.toString(),
      placeLocation: LatLng(
        double.parse(latitude.toString()),
        double.parse(longitude.toString()),
      ),
    );
    notifyListeners();
  }

  final prefrences = Prefrences();

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
      return latLng;
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
      LatLng currentCordinates =
          await getCurrentLocation(context) ?? const LatLng(0.0, 0.0);
      myCurrentLocation = PlaceDetailModel(
        placeAddress: getAddress,
        placeLocation: currentCordinates,
      );
    }
    if (longitude != null) {
      await getLocalCoordinates();
    }
    notifyListeners();
  }

  setLatLng(LatLng latitudeAndLogitude) async {
    latLng = latitudeAndLogitude;
    await getLocationFromCoordinates(latitudeAndLogitude);
    notifyListeners();
  }

  List<PlacesModel> placesList = [];
  PlaceDetailModel placeDetailModel = PlaceDetailModel.fromEmptyJson();
  // PlaceWebService placeWebService = PlaceWebService();
  PlacesRepo placeWebService = PlacesRepo();

  Future<void> getPlaces(String query) async {
    // if (!(await Utilities().isInternetAvailable())) {
    //   return;
    // }
    placesList = await placeWebService.getPlaces(query);
    notifyListeners();
  }

//cleared function
  Future<void> getPlaceDetail(String placeId) async {
    placeDetailModel = await placeWebService.getPlaceDetail(placeId);
    // print(placeDetailModel.placeAddress);
    notifyListeners();
  }
}
