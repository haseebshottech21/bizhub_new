import 'package:bizhub_new/repo/places_repo.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../model/auto_complete_prediction.dart';
import '../model/place_auto_complete.dart';
import '../model/place_detail_model.dart';
import '../utils/routes/routes_name.dart';
import '../utils/shared_prefrences.dart';
import 'all_services_view_model.dart';

// class LocationViewModel with ChangeNotifier {
//   PlaceDetailModel myCurrentLocation = PlaceDetailModel.fromEmptyJson();
//   LatLng latLng = const LatLng(0.0, 0.0);
//   String address = '';

//   //   LatLng latLng = const LatLng(0.0, 0.0);
// //   String address = '';
// //   String postalCode = '';

//   // GetLocationViewModel(): longitude=0,latitude=0,address='';

//   set setAddress(
//     String address,
//   ) {
//     this.addresdress;
//     notifyListeners();
//   }

//   String get getAddress => address;

//   final GeolocatorPlatform _geoLocatorPlatform = GeolocatorPlatform.instance;

//   updateMyLocation() {
//     // if (placeDetailModel.placeAddress.isNotEmpty) {
//     //   myCurrentLocation = placeDetailModel;
//     //   if (setValue) {
//     //     setLocalCoordinates(placeDetailModel);
//     //   }
//     //   notifyListeners();
//     //   // Navigator.of(context).pop();
//     // } else {
//     //   // Fluttertoast.showToast(msg: "Please select a location");
//     // }
//     if (placeDetailModel.placeAddress.isNotEmpty) {
//       myCurrentLocation = placeDetailModel;
//       notifyListeners();
//     }
//   }

//   // updatDestinationLoaction(context) {
//   //   if (placeDetailModel.placeAddress.isNotEmpty) {
//   //     myDestinationLocation = placeDetailModel;
//   //     notifyListeners();
//   //     // Navigator.of(context).pop();
//   //   } else {
//   //     // Fluttertoast.showToast(msg: 'Please select a destination');
//   //   }
//   // }

//   String get getMyAddress => myCurrentLocation.placeAddress;
//   // String get getDestinationAddress => myDestinationLocation.placeAddress;

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

//   // Future<void> getLocationFromCoordinates(LatLng coordinate) async {
//   //   List<Placemark> placeMarks = await placemarkFromCoordinates(
//   //     coordinate.latitude,
//   //     coordinate.longitude,
//   //   );
//   //   final address = placeMarks.first;
//   //   setAddress =
//   //       '${address.street}, ${address.subLocality}, ${address.locality}, ${address.administrativeArea}, ${address.postalCode}, ${address.country}';
//   //   setAddress = this.address.replaceAll(', ,', ',');

//   //   setLocalCoordinates(
//   //     PlaceDetailModel(placeAddress: getAddress, placeLocation: coordinate),
//   //   );
//   // }

//   Future<void> getLocationFromCoordinates(LatLng coordinate) async {
//     // bool permission = await _handlePermission();
//     // if (permission) {
//     // final geoPosition = await Geolocator.getCurrentPosition(
//     //   desiredAccuracy: LocationAccuracy.high,
//     // );
//     // latLng = LatLng(geoPosition.latitude, geoPosition.longitude);
//     // // final registrationCompanyProvider =
//     // //     Provider.of<RegisterCompanyViewModel>(context, listen: false);

//     // await getLocationFromCoordinates(latLng);
//     // return latLng;
//     List<Placemark> placeMarks = await placemarkFromCoordinates(
//       coordinate.latitude,
//       coordinate.longitude,
//     );
//     final address = placeMarks.first;
//     setAddress =
//         '${address.street}, ${address.subLocality}, ${address.locality}, ${address.administrativeArea}, ${address.postalCode}, ${address.country}';
//     setAddress = this.address.replaceAll(', ,', ',');
//     // }
//     // setLocalCoordinates(
//     //     PlaceDetailModel(placeAddress: getAddress, placeLocation: coordinate));
//   }

//   setLocalCoordinates(PlaceDetailModel placeModel) async {
//     // placeDetailModel = PlaceDetailModel(
//     //   placeAddress: getAddress,
//     //   placeLocation: coordinate,
//     // );
//     await prefrences.setSharedPreferenceValue(
//       'longitude',
//       placeModel.placeLocation.longitude.toString(),
//     );
//     await prefrences.setSharedPreferenceValue(
//       'latitude',
//       placeModel.placeLocation.latitude.toString(),
//     );
//     await prefrences.setSharedPreferenceValue(
//       'address',
//       placeModel.placeAddress,
//     );
//     notifyListeners();
//     getLocalCoordinates();
//   }

//   Future<void> getLocalCoordinates() async {
//     final longitude = await prefrences.getSharedPreferenceValue('longitude');
//     final latitude = await prefrences.getSharedPreferenceValue('latitude');
//     final address = await prefrences.getSharedPreferenceValue('address');

//     myCurrentLocation = PlaceDetailModel(
//       placeAddress: address.toString(),
//       placeLocation: LatLng(
//         double.parse(latitude.toString()),
//         double.parse(longitude.toString()),
//       ),
//     );
//     notifyListeners();
//   }

//   final prefrences = Prefrences();

//   Future<LatLng?> getCurrentLocation({required BuildContext context}) async {
//     bool permission = await _handlePermission();
//     if (permission) {
//       final geoPosition = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//       latLng = LatLng(geoPosition.latitude, geoPosition.longitude);
//       // final registrationCompanyProvider =
//       //     Provider.of<RegisterCompanyViewModel>(context, listen: false);

//       await getLocationFromCoordinates(latLng);
//       return latLng;
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
//       LatLng currentCordinates =
//           await getCurrentLocation(context: context) ?? const LatLng(0.0, 0.0);
//       myCurrentLocation = PlaceDetailModel(
//         placeAddress: getAddress,
//         placeLocation: currentCordinates,
//       );
//     }
//     if (longitude != null) {
//       await getLocalCoordinates();
//     }
//     notifyListeners();
//   }

//   setLatLng(LatLng latitudeAndLogitude) async {
//     latLng = latitudeAndLogitude;
//     await getLocationFromCoordinates(latitudeAndLogitude);
//     notifyListeners();
//   }

//   List<PlacesModel> placesList = [];
//   PlaceDetailModel placeDetailModel = PlaceDetailModel.fromEmptyJson();
//   // PlaceWebService placeWebService = PlaceWebService();
//   PlacesRepo placeWebService = PlacesRepo();

//   Future<void> getPlaces(String query) async {
//     // if (!(await Utilities().isInternetAvailable())) {
//     //   return;
//     // }
//     placesList = await placeWebService.getPlaces(query);
//     notifyListeners();
//   }

// //cleared function
//   Future<void> getPlaceDetail(String placeId) async {
//     placeDetailModel = await placeWebService.getPlaceDetail(placeId);
//     // print(placeDetailModel.placeAddress);
//     notifyListeners();
//   }
// }

class LocationViewModel with ChangeNotifier {
  // double? latitude;
  // double? longitude;
  PlaceDetailModel mySearchLocation = PlaceDetailModel.fromEmptyJson();
  PlaceDetailModel myCurrentLocation = PlaceDetailModel.fromEmptyJson();
  // PlaceDetailModel placeDetailModel = PlaceDetailModel.fromEmptyJson();
  PlacesRepo placeWebService = PlacesRepo();
  final prefrences = Prefrences();
  LatLng latLng = const LatLng(0.0, 0.0);
  String locationAddress = "";

  LatLng mylatLng = const LatLng(0.0, 0.0);
  String mylocationAddress = "";
  bool checkGetMyLocation = false;

  PlaceDetailModel placeDetailModel = PlaceDetailModel.fromEmptyJson();

  // updateMyLocation() {
  //   if (placeDetailModel.placeAddress.isNotEmpty) {
  //     myCurrentLocation = placeDetailModel;
  //     setLocalCoordinates(placeDetailModel);
  //     notifyListeners();
  //     print(myCurrentLocation.placeAddress);
  //     print(myCurrentLocation.placeLocation.latitude);
  //     print(myCurrentLocation.placeLocation.longitude);
  //     // Navigator.of(context).pop();
  //   } else {
  //     Fluttertoast.showToast(msg: "Please select a location");
  //   }
  // }

  setLocalCoordinates(PlaceDetailModel placeModel) async {
    await prefrences.setSharedPreferenceValue(
      'myLocationlongitude',
      placeModel.placeLocation.longitude.toString(),
    );
    await prefrences.setSharedPreferenceValue(
      'myLocationlatitude',
      placeModel.placeLocation.latitude.toString(),
    );
    await prefrences.setSharedPreferenceValue(
      'myLocationAddress',
      placeModel.placeAddress,
    );
    getMyCurrentLocation();
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoad(bool status) {
    _loading = status;
    notifyListeners();
  }

  bool _btnloading = false;
  bool get btnloading => _btnloading;
  setBtnLoad(bool status) {
    _btnloading = status;
    notifyListeners();
  }

  getMyCurrentLocation() async {
    mylocationAddress =
        await prefrences.getSharedPreferenceValue('myLocationAddress');
  }

  Future<void> getLatLong(BuildContext context) async {
    Future<Position> data = _determinePosition(context);
    await data.then((value) async {
      // print("value $value");
      // setState(() {
      //   lat = value.latitude;
      //   long = value.longitude;
      // });
      latLng = LatLng(value.latitude, value.longitude);
      // latitude = value.latitude;
      // longitude = value.longitude;

      await getAddress(value.latitude, value.longitude);
      notifyListeners();
    }).catchError((error) {
      // print("Error $error");
    });
  }

  Future<LatLng?> getMyLatLong({
    required BuildContext context,
    bool route = false,
  }) async {
    setBtnLoad(true);
    // setLoad(true);
    Future<Position> data = _determinePosition(context);
    await data.then((value) async {
      // print("value $value");
      // setState(() {
      //   lat = value.latitude;
      //   long = value.longitude;
      // });
      mylatLng = LatLng(value.latitude, value.longitude);
      // latitude = value.latitude;
      // longitude = value.longitude;

      // getMyAddress(value.latitude, value.longitude);
      await getLocationFromCoordinates(mylatLng);
      await prefrences.setSharedPreferenceBoolValue('myloc', true);
      await prefrences.setSharedPreferenceValue(
        'myLocationlongitude',
        mylatLng.longitude.toString(),
      );
      await prefrences.setSharedPreferenceValue(
        'myLocationlatitude',
        mylatLng.latitude.toString(),
      );
      await prefrences.setSharedPreferenceValue(
        'myLocationAddress',
        mylocationAddress,
      );

      // notifyListeners();

      // notifyListeners();
      // if (mylocationAddress.isNotEmpty) {
      // print('mylocation : ' + mylocationAddress);
      setBtnLoad(false);
      // setLoad(false);

      if (route) {
        Future.delayed(const Duration(seconds: 1)).then((value) {
          Navigator.of(context).pushReplacementNamed(RouteName.home);
        });
      } else {
        Future.delayed(const Duration(seconds: 1)).then((value) async {
          getAllSerices(context);
        });
      }

      return mylatLng;
      // }
    }).catchError((error) {
      // print("Error $error");
      return error;
    });
    return null;
  }

  //For convert lat long to address
  getAddress(lat, long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    // '${address.street}, ${address.subLocality}, ${address.locality}, ${address.administrativeArea}, ${address.postalCode}, ${address.country}'
    // setState(() {
    locationAddress =
        "${placemarks[0].street!}, ${placemarks[0].locality!}, ${placemarks[0].administrativeArea!}, ${placemarks[0].postalCode!}, ${placemarks[0].country!}";
    // });

    for (int i = 0; i < placemarks.length; i++) {
      // print("INDEX $i ${placemarks[i]}");
    }
    // print(locationAddress);
    // notifyListeners();
  }

  // Future<void> getStoreLocationIfExist(BuildContext context) async {
  //   final longitude = await prefrences.getSharedPreferenceValue('longitude');
  //   // final latitude = await utilities.getSharedPreferenceValue('latitude');
  //   // final address = await utilities.getSharedPreferenceValue('address');
  //   print('$longitude long');
  //   // print('$latitude lat');
  //   // print('$address address');
  //   if (longitude == null) {
  //     LatLng currentCordinates =
  //         await getMyLatLong(context: context) ?? const LatLng(0.0, 0.0);
  //     myCurrentLocation = PlaceDetailModel(
  //       placeAddress: mylocationAddress,
  //       placeLocation: currentCordinates,
  //     );
  //   }
  //   if (longitude != null) {
  //     await getLocalCoordinates();
  //   }
  //   notifyListeners();
  // }

  Future<void> getLocationFromCoordinates(LatLng coordinate) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(
      coordinate.latitude,
      coordinate.longitude,
    );
    final address = placeMarks.first;
    // mylocationAddress =
    //     '${address.street}, ${address.subLocality}, ${address.locality}, ${address.administrativeArea}, ${address.postalCode}, ${address.country}';
    mylocationAddress =
        '${address.locality}, ${address.administrativeArea}, ${address.postalCode}, ${address.country}';
    mylocationAddress = mylocationAddress.replaceAll(', ,', ',');

    // print(address.administrativeArea);
  }

  // Future<void> getLocalCoordinates() async {
  //   final longitude = await prefrences.getSharedPreferenceValue('longitude');
  //   final latitude = await prefrences.getSharedPreferenceValue('latitude');
  //   final address = await prefrences.getSharedPreferenceValue('myAddress');

  //   myCurrentLocation = PlaceDetailModel(
  //     placeAddress: address.toString(),
  //     placeLocation: LatLng(
  //       double.parse(latitude.toString()),
  //       double.parse(longitude.toString()),
  //     ),
  //   );
  //   notifyListeners();
  // }

  String mapAPIKEY = 'AIzaSyCSD5azLj8EdgAmcNdIFAq08bhij-4O7RU';

  List<AutoCompletePrediction> placePrediction = [];
  PlaceDetail? placesDetail;

  void placeAutoComplete(String query) async {
    Uri uri = Uri.https(
      "maps.googleapis.com",
      "maps/api/place/autocomplete/json",
      {
        "input": query,
        "key": mapAPIKEY,
      },
    );

    String? response = await PlacesRepo.fetchUrl(uri);

    if (response != null) {
      // print(response);
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutoCompleteResult(response);
      if (result.prediction != null) {
        placePrediction = result.prediction!;
      }
      notifyListeners();
    }
  }

  void getNewPlaceDetail(String placeId) async {
    mySearchLocation = await placeWebService.fetchPlacesDetail(placeId);
    // print(mySearchLocation.placeAddress);
    if (mySearchLocation.placeAddress.isNotEmpty) {
      locationAddress = mySearchLocation.placeAddress;
      latLng = mySearchLocation.placeLocation;
    }
    notifyListeners();
  }

  Future<void> getMyPlaceDetail(String placeId) async {
    setLoad(true);
    myCurrentLocation = await placeWebService.fetchPlacesDetail(placeId);
    // print(mySearchLocation.placeAddress);
    if (myCurrentLocation.placeAddress.isNotEmpty) {
      mylocationAddress = myCurrentLocation.placeAddress;
      mylatLng = myCurrentLocation.placeLocation;

      List<Placemark> placeMarks = await placemarkFromCoordinates(
        myCurrentLocation.placeLocation.latitude,
        myCurrentLocation.placeLocation.longitude,
      );
      final address = placeMarks.first;
      // mylocationAddress =
      //     '${address.street}, ${address.subLocality}, ${address.locality}, ${address.administrativeArea}, ${address.postalCode}, ${address.country}';
      mylocationAddress =
          '${address.locality}, ${address.administrativeArea}, ${address.postalCode}, ${address.country}';
      mylocationAddress =
          mylocationAddress.replaceAll(', ,', ',').replaceAll(' ,', '');
    }

    await prefrences.setSharedPreferenceBoolValue('myloc', true);
    await setLocalCoordinates(myCurrentLocation);
    // await provider.getLatLong();
    // await provider.checkAuth();

    // print('setLong: ' + myCurrentLocation.placeLocation.longitude.toString());
    // print('setLat: ' + myCurrentLocation.placeLocation.latitude.toString());

    setLoad(false);
  }

  String? token;

  Future<void> getAllSerices(BuildContext context) async {
    final navigator = Navigator.of(context);
    final serviceProvider =
        Provider.of<AllServicesViewModel>(context, listen: false);
    serviceProvider.page = 1;
    serviceProvider.hasNextPage = true;
    token = await prefrences.getSharedPreferenceValue('token');
    Future.delayed(Duration.zero).then((value) async {
      await serviceProvider.getLatLongAndMiles();
      if (token == null || token == '') {
        await serviceProvider.getAllServiceWithoutAuth();
      } else {
        await serviceProvider.getAllService();
      }
      navigator.pop();
    });
    notifyListeners();
  }
}
