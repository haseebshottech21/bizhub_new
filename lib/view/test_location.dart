// import 'package:bizhub_new/model/place_auto_complete.dart';
// import 'package:bizhub_new/repo/places_repo.dart';
import 'package:bizhub_new/view_model/location_view_model.dart';
import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
// import '../model/auto_complete_prediction.dart';
import '../utils/routes/routes_name.dart';

class TestLocation extends StatefulWidget {
  const TestLocation({Key? key}) : super(key: key);

  @override
  State<TestLocation> createState() => _TestLocationState();
}

class _TestLocationState extends State<TestLocation> {
  @override
  void initState() {
    // getLocationAddress();
    Provider.of<LocationViewModel>(context, listen: false).getLatLong(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locationViewModel =
        Provider.of<LocationViewModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D39F2),
        centerTitle: true,
        title: const Text("Get Location"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Lat : ${locationViewModel.latLng.latitude}"),
            Text("Long : ${locationViewModel.latLng.longitude}"),
            Text(
              "Address : ${locationViewModel.locationAddress.isEmpty ? 'Choose Location' : locationViewModel.locationAddress}",
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              onPressed: () {
                Navigator.pushNamed(context, RouteName.testSearchLocation);
              },
              child: const Text("Search Location"),
            ),
            ElevatedButton(
              onPressed: () {
                // print("Latitute : ${locationViewModel.latLng.latitude}");
                // print("Longitude : ${locationViewModel.latLng.longitude}");
                // print("Address : ${locationViewModel.locationAddress}");
              },
              child: const Text("My Address Long Lat"),
            ),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     primary: const Color(0xFF0D39F2),
            //   ),
            //   onPressed: locationViewModel.getLatLong,
            //   child: const Text("Get My Location"),
            // ),
          ],
        ),
      ),
    );
  }
}

class TestSearchLocation extends StatefulWidget {
  const TestSearchLocation({Key? key}) : super(key: key);

  @override
  State<TestSearchLocation> createState() => _TestSearchLocationState();
}

class _TestSearchLocationState extends State<TestSearchLocation> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final locationViewModel =
        Provider.of<LocationViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade100,
            child: const Icon(Icons.location_on_sharp, color: Colors.black54),
          ),
        ),
        title: const Text(
          'Search Location',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade100,
              child: const Icon(Icons.clear, color: Colors.black54),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: controller,
              onChanged: (value) {
                locationViewModel.placeAutoComplete(value);
              },
              style: const TextStyle(color: Colors.black),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.grey.shade100,
                filled: true,
                hintText: 'Search your location',
              ),
            ),
          ),
          const Divider(
            height: 2,
            thickness: 2,
            color: Colors.black12,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                // locationViewModel.getLatLong();
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.location_searching),
              label: const Text(
                'Use my Current Location',
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade200,
                foregroundColor: Colors.blue,
                elevation: 0,
                fixedSize: const Size(double.infinity, 40),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          const Divider(
            height: 2,
            thickness: 2,
            color: Colors.black12,
          ),
          if (locationViewModel.placePrediction.isNotEmpty &&
              controller.text.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: locationViewModel.placePrediction.length,
                itemBuilder: (context, index) {
                  return LocationTitle(
                    onTap: () {
                      // print(placePrediction[index].description!);
                      // print(placePrediction[index].placeId!);
                      locationViewModel.getNewPlaceDetail(
                        locationViewModel.placePrediction[index].placeId!,
                      );
                      Navigator.of(context).pop();
                    },
                    location:
                        locationViewModel.placePrediction[index].description!,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class LocationTitle extends StatelessWidget {
  const LocationTitle({
    Key? key,
    required this.location,
    required this.onTap,
  }) : super(key: key);

  final String location;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          ListTile(
            onTap: onTap,
            horizontalTitleGap: 0,
            leading:
                const Icon(Icons.location_on_outlined, color: Colors.black),
            title: Text(
              location,
              style: const TextStyle(color: Colors.black),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            color: Colors.black12,
          ),
        ],
      ),
    );
  }
}
