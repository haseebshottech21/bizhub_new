import 'package:bizhub_new/utils/mytheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_model/location_view_model.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({Key? key}) : super(key: key);

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final locationViewModel =
        Provider.of<LocationViewModel>(context, listen: true);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Search Location',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.clear,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(CupertinoIcons.location_fill),
              onPressed: null,
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
          // const Divider(
          //   height: 2,
          //   thickness: 2,
          //   color: Colors.black12,
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
            child: ElevatedButton.icon(
              onPressed: () {
                locationViewModel.getLatLong(context);
                Navigator.of(context).pop();
              },
              icon: const Icon(CupertinoIcons.location_fill),
              label: const Text(
                'My Current Location',
                // style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: MyTheme.greenColor,
                foregroundColor: Colors.white,
                elevation: 1,
                fixedSize: Size(size.width, 45),
                // shape: const RoundedRectangleBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(4)),
                // ),
              ),
            ),
          ),
          const Divider(
            height: 1.5,
            thickness: 1.5,
            color: Colors.black26,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Column(
          children: [
            ListTile(
              onTap: onTap,
              horizontalTitleGap: 0,
              leading: const Icon(
                CupertinoIcons.location_solid,
                color: MyTheme.greenColor,
              ),
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
      ),
    );
  }
}
