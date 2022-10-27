import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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

  @override
  void initState() {
    // _handlePermission();

    double latitude = double.parse(
      widget.allServiceViewModel.serviceDetalModel!.latitude.toString(),
    );
    double longitude = double.parse(
      widget.allServiceViewModel.serviceDetalModel!.longitude.toString(),
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
