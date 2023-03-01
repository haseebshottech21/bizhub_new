import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../view_model/all_services_view_model.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key, required this.allServiceViewModel})
      : super(key: key);

  final AllServicesViewModel allServiceViewModel;

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  // static const LatLng pinPosition = LatLng(37.3797536, -122.1017334);

  // static LatLng pinPosition = const LatLng(0, 0);

  // these are the minimum required values to set
  // the camera position
  // CameraPosition initialLocation = CameraPosition(
  //   zoom: 12,
  //   bearing: 10,
  //   target: pinPosition,
  // );

  late CameraPosition initialLocation;

  late BitmapDescriptor pinLocationIcon;
  final Set<Marker> _markers = {};
  final Set<Circle> _circles = HashSet<Circle>();
  final Completer<GoogleMapController> mapController = Completer();
  // late BitmapDescriptor _markerIcon;

  // final GeolocatorPlatform _geoLocatorPlatform = GeolocatorPlatform.instance;

  // Future<bool> _handlePermission() async {
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission != LocationPermission.always) {
  //     permission = await _geoLocatorPlatform.requestPermission();
  //     if (permission == LocationPermission.always ||
  //         permission == LocationPermission.whileInUse) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } else {
  //     return true;
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _setCircles();
  }

  doubleConverter(String latlong) {
    return double.parse(latlong);
  }

  // @override
  // void initState() {
  //   // _handlePermission();

  //   double latitude = double.parse(
  //     widget.allServiceViewModel.serviceDetalModel!.latitude.toString(),
  //   );
  //   double longitude = double.parse(
  //     widget.allServiceViewModel.serviceDetalModel!.longitude.toString(),
  //   );

  //   pinPosition = LatLng(latitude, longitude);

  //   initialLocation = CameraPosition(
  //     zoom: 15,
  //     bearing: 10,
  //     target: pinPosition,
  //   );

  //   // BitmapDescriptor.fromAssetImage(
  //   //   const ImageConfiguration(devicePixelRatio: 1.5),
  //   //   'assets/images/destination_map_marker.png',
  //   // ).then((onValue) {
  //   //   pinLocationIcon = onValue;
  //   // });
  //   // _setMarkerIcon();
  //   _setCircles();
  //   super.initState();
  // }

  // void _setMarkerIcon() async {
  //   _markerIcon = await BitmapDescriptor.fromAssetImage(
  //     const ImageConfiguration(devicePixelRatio: 1.5),
  //     'assets/images/destination_map_marker.png',
  //   );
  // }

  // final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _markers.clear();
    setState(() {
      Marker(
        // icon: pinLocationIcon!,
        markerId: MarkerId(
          widget.allServiceViewModel.serviceDetalModel!.address.toString(),
        ),
        position: LatLng(
          doubleConverter(
            widget.allServiceViewModel.serviceDetalModel!.latitude.toString(),
          ),
          doubleConverter(
            widget.allServiceViewModel.serviceDetalModel!.longitude.toString(),
          ),
        ),
        // infoWindow: InfoWindow(
        //   title: '',
        //   snippet: '',
        //   // onTap: () {
        //   //   print(
        //   //       "${widget.allServiceViewModel.serviceDetalModel!.latitude}, ${widget.allServiceViewModel.serviceDetalModel!.longitude}");
        //   // },
        // ),
        // onTap: () {
        //   print("Clicked on marker");
        // },
      );
      // print(
      //     "${widget.allServiceViewModel.serviceDetalModel!.latitude}, ${widget.allServiceViewModel.serviceDetalModel!.longitude}");
      // _markers[widget.cityData['name']] = marker;
    });
  }

  // void _onMapCreated(GoogleMapController controller) async {
  //   // _mapController = controller;
  //   _markers.clear();

  //   setState(() {
  //     _markers.add(
  //       Marker(
  //         markerId: const MarkerId("0"),
  //         position: LatLng(
  //             double.parse(widget
  //                 .allServiceViewModel.serviceDetalModel!.latitude
  //                 .toString()),
  //             double.parse(widget
  //                 .allServiceViewModel.serviceDetalModel!.longitude
  //                 .toString())),
  //         infoWindow: const InfoWindow(
  //           title: "San Francsico",
  //           snippet: "An Interesting city",
  //         ),
  //         icon: _markerIcon,
  //       ),
  //     );
  //   });
  // }

  void _setCircles() {
    _circles.add(
      Circle(
        circleId: const CircleId("0"),
        center: LatLng(
          doubleConverter(
            widget.allServiceViewModel.serviceDetalModel!.latitude.toString(),
          ),
          doubleConverter(
            widget.allServiceViewModel.serviceDetalModel!.longitude.toString(),
          ),
        ),
        radius: 2000,
        strokeWidth: 1,
        strokeColor: Colors.white,
        fillColor: const Color.fromRGBO(52, 186, 37, .6),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.22,
      // child: GoogleMap(
      //   onMapCreated: _onMapCreated,
      //   mapType: MapType.normal,
      //   zoomGesturesEnabled: false,
      //   compassEnabled: false,
      //   zoomControlsEnabled: false,
      //   scrollGesturesEnabled: false,
      //   myLocationButtonEnabled: false,
      //   // initialCameraPosition: CameraPosition(
      //   //   target: LatLng(37.77483, -122.41942),
      //   //   zoom: 12,
      //   // ),
      //   initialCameraPosition: initialLocation,
      //   markers: _markers,
      //   // polygons: _polygons,
      //   // polylines: _polylines,
      //   // circles: _circles,
      // ),
      child: GoogleMap(
        mapType: MapType.normal,
        zoomGesturesEnabled: false,
        compassEnabled: false,
        zoomControlsEnabled: false,
        scrollGesturesEnabled: false,
        myLocationButtonEnabled: false,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            doubleConverter(
              widget.allServiceViewModel.serviceDetalModel!.latitude.toString(),
            ),
            doubleConverter(
              widget.allServiceViewModel.serviceDetalModel!.longitude
                  .toString(),
            ),
          ),
          zoom: 12,
          bearing: 8,
        ),
        markers: _markers,
        circles: _circles,
      ),
    );
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  Future<void> _disposeController() async {
    final GoogleMapController controller = await mapController.future;
    controller.dispose();
  }
}
