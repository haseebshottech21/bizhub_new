import 'package:bizhub_new/utils/mytheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_model/location_view_model.dart';

// class SearchLocation extends StatefulWidget {
//   const SearchLocation({Key? key}) : super(key: key);

//   @override
//   State<SearchLocation> createState() => _SearchLocationState();
// }

// class _SearchLocationState extends State<SearchLocation> {
//   final textSearchController = TextEditingController();

//   bool init = true;
//   @override
//   void didChangeDependencies() {
//     if (init) {
//       final placeProvider = Provider.of<LocationViewModel>(
//         context,
//       );
//       // placeProvider.placeDetailModel = PlaceDetailModel.fromEmptyJson();
//       placeProvider.placesList.clear();
//       init = false;
//     }
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size.width;

//     // final placeViewModel =
//     //     Provider.of<LocationViewModel>(context, listen: true);

//     final placeViewModel = context.watch<LocationViewModel>();

//     return Scaffold(
//       backgroundColor: Colors.white,
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         title: const Text(
//           'Search Location',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//         leading: IconButton(
//           icon: const Icon(
//             Icons.clear,
//             color: Colors.black,
//           ),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         actions: const [
//           IconButton(
//             icon: Icon(
//               Icons.location_pin,
//               color: MyTheme.greenColor,
//             ),
//             onPressed: null,
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             LocationSearchBox(
//               searchController: textSearchController,
//               onChange: placeViewModel.getPlaces,
//             ),
//             if (placeViewModel.placesList.isNotEmpty &&
//                 textSearchController.text.isNotEmpty)
//               Expanded(
//                 child: ListView.builder(
//                   physics: const ClampingScrollPhysics(),
//                   padding: const EdgeInsets.symmetric(vertical: 10),
//                   shrinkWrap: true,
//                   itemCount: placeViewModel.placesList.length,
//                   itemBuilder: (context, index) {
//                     return InkWell(
//                       onTap: () {
//                         textSearchController.clear();
//                         placeViewModel.getPlaceDetail(
//                           placeViewModel.placesList[index].placeId,
//                         );
//                         placeViewModel.updateMyLocation();
//                         Navigator.of(context).pop();
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8),
//                         child: Container(
//                           padding: const EdgeInsets.all(6),
//                           margin: const EdgeInsets.only(bottom: 8),
//                           decoration: const BoxDecoration(
//                             border: Border(
//                               bottom: BorderSide(
//                                 color: Colors.black26,
//                                 width: 0.5,
//                               ),
//                             ),
//                           ),
//                           child: Row(
//                             children: [
//                               const Icon(
//                                 Icons.location_pin,
//                                 color: MyTheme.greenColor,
//                                 size: 25,
//                               ),
//                               const SizedBox(width: 8),
//                               SizedBox(
//                                 width: size * 0.7,
//                                 child: Text(
//                                   placeViewModel.placesList[index].description,
//                                   style: const TextStyle(
//                                     fontSize: 15,
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class LocationSearchBox extends StatelessWidget {
//   final TextEditingController searchController;
//   final Function onChange;
//   const LocationSearchBox({
//     required this.searchController,
//     required this.onChange,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.grey.shade50,
//       width: MediaQuery.of(context).size.width,
//       padding: const EdgeInsets.only(left: 8, right: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Icon(Icons.search, color: Colors.grey.shade700),
//           SizedBox(
//             width: MediaQuery.of(context).size.width * 0.80,
//             child: TextField(
//               controller: searchController,
//               onChanged: (val) => onChange(val),
//               style: const TextStyle(color: Colors.black),
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.grey.shade50,
//                 hintText: 'Enter Your Location',
//                 hintStyle: TextStyle(color: Colors.grey.shade700),
//                 contentPadding:
//                     const EdgeInsets.only(left: 10, bottom: 5, right: 5),
//                 focusedBorder: const OutlineInputBorder(
//                   // borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide.none,
//                 ),
//                 enabledBorder: const OutlineInputBorder(
//                   // borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ),
//           searchController.text.isNotEmpty
//               ? InkWell(
//                   onTap: () {
//                     searchController.clear();
//                   },
//                   child: Icon(Icons.clear, color: Colors.grey.shade700),
//                 )
//               : Icon(Icons.clear, color: Colors.grey.shade50),
//         ],
//       ),
//     );
//   }
// }

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
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   leading: Padding(
      //     padding: const EdgeInsets.only(left: 8.0),
      //     child: CircleAvatar(
      //       backgroundColor: Colors.grey.shade100,
      //       child: const Icon(Icons.location_on_sharp, color: Colors.black54),
      //     ),
      //   ),
      //   title: const Text(
      //     'Search Location',
      //     style: TextStyle(color: Colors.black),
      //   ),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 8.0),
      //       child: CircleAvatar(
      //         backgroundColor: Colors.grey.shade100,
      //         child: const Icon(Icons.clear, color: Colors.black54),
      //       ),
      //     ),
      //   ],
      // ),
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
                locationViewModel.getLatLong();
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
