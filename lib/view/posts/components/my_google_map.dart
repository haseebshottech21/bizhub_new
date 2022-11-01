import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../view_model/my_service_view_model.dart';

class MyGoogleMap extends StatefulWidget {
  const MyGoogleMap({Key? key, required this.myServiceViewModel})
      : super(key: key);

  final MyServiceViewModel myServiceViewModel;

  @override
  State<MyGoogleMap> createState() => _MyGoogleMapState();
}

class _MyGoogleMapState extends State<MyGoogleMap> {
  static LatLng pinPosition = const LatLng(0, 0);

  late CameraPosition initialLocation;

  late BitmapDescriptor pinLocationIcon;
  final Set<Marker> _markers = {};
  final Set<Circle> _circles = HashSet<Circle>();
  final Completer<GoogleMapController> mapController = Completer();
  late BitmapDescriptor _markerIcon;

  // @override
  // void initState() {
  //   double latitude = double.parse(
  //     widget.myServiceViewModel.serviceModel!.latitude.toString(),
  //   );
  //   double longitude = double.parse(
  //     widget.myServiceViewModel.serviceModel!.longitude.toString(),
  //   );

  //   pinPosition = LatLng(latitude, longitude);

  //   initialLocation = CameraPosition(
  //     zoom: 14.5,
  //     bearing: 10,
  //     target: pinPosition,
  //   );

  //   BitmapDescriptor.fromAssetImage(
  //     const ImageConfiguration(devicePixelRatio: 1.5),
  //     'assets/images/destination_map_marker.png',
  //   ).then((onValue) {
  //     pinLocationIcon = onValue;
  //   });
  //   super.initState();
  // }

  @override
  void initState() {
    // _handlePermission();
    double latitude = double.parse(
      widget.myServiceViewModel.serviceModel!.latitude.toString(),
    );
    double longitude = double.parse(
      widget.myServiceViewModel.serviceModel!.longitude.toString(),
    );

    pinPosition = LatLng(latitude, longitude);

    initialLocation = CameraPosition(
      zoom: 15,
      bearing: 10,
      target: pinPosition,
    );

    // BitmapDescriptor.fromAssetImage(
    //   const ImageConfiguration(devicePixelRatio: 1.5),
    //   'assets/images/destination_map_marker.png',
    // ).then((onValue) {
    //   pinLocationIcon = onValue;
    // });
    // _setMarkerIcon();
    _setCircles();
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    // _mapController = controller;
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId("0"),
          position: pinPosition,
          // infoWindow: const InfoWindow(
          //   title: "San Francsico",
          //   snippet: "An Interesting city",
          // ),
          icon: _markerIcon,
        ),
      );
    });
  }

  void _setCircles() {
    _circles.add(
      Circle(
        circleId: const CircleId("0"),
        center: pinPosition,
        radius: 200,
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
      height: size.height * 0.18,
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        mapType: MapType.normal,
        zoomGesturesEnabled: false,
        compassEnabled: false,
        zoomControlsEnabled: false,
        scrollGesturesEnabled: false,
        myLocationButtonEnabled: false,
        // initialCameraPosition: CameraPosition(
        //   target: LatLng(37.77483, -122.41942),
        //   zoom: 12,
        // ),
        initialCameraPosition: initialLocation,
        markers: _markers,
        // polygons: _polygons,
        // polylines: _polylines,
        circles: _circles,
      ),
      // child: GoogleMap(
      //   mapType: MapType.normal,
      //   zoomGesturesEnabled: false,
      //   compassEnabled: false,
      //   zoomControlsEnabled: false,
      //   scrollGesturesEnabled: false,
      //   myLocationButtonEnabled: false,
      //   markers: _markers,
      //   initialCameraPosition: initialLocation,
      //   onMapCreated: (GoogleMapController controller) {
      //     mapController.complete(controller);
      //     setState(
      //       () {
      //         _markers.add(
      //           Marker(
      //             markerId: MarkerId(
      //               initialLocation.toString(),
      //             ),
      //             position: pinPosition,
      //             icon: pinLocationIcon,
      //           ),
      //         );
      //       },
      //     );
      //   },
      // ),
    );
  }
}
