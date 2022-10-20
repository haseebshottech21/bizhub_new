import 'dart:async';

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
  final Completer<GoogleMapController> mapController = Completer();

  @override
  void initState() {
    double latitude = double.parse(
      widget.myServiceViewModel.serviceModel!.latitude.toString(),
    );
    double longitude = double.parse(
      widget.myServiceViewModel.serviceModel!.longitude.toString(),
    );

    pinPosition = LatLng(latitude, longitude);

    initialLocation = CameraPosition(
      zoom: 14.5,
      bearing: 10,
      target: pinPosition,
    );

    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 1.5),
      'assets/images/destination_map_marker.png',
    ).then((onValue) {
      pinLocationIcon = onValue;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.17,
      child: GoogleMap(
        mapType: MapType.normal,
        zoomGesturesEnabled: false,
        compassEnabled: false,
        zoomControlsEnabled: false,
        scrollGesturesEnabled: false,
        myLocationButtonEnabled: false,
        markers: _markers,
        initialCameraPosition: initialLocation,
        onMapCreated: (GoogleMapController controller) {
          mapController.complete(controller);
          setState(
            () {
              _markers.add(
                Marker(
                  markerId: MarkerId(
                    initialLocation.toString(),
                  ),
                  position: pinPosition,
                  icon: pinLocationIcon,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
