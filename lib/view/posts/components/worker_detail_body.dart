// import 'package:flutter/material.dart';
// import '../../../utils/app_url.dart';
// // import '../../../utils/dummy_data.dart';
// import '../../../view_model/my_service_view_model.dart';
// import 'my_google_map.dart';

// class MyWorkerDetailBody extends StatelessWidget {
//   const MyWorkerDetailBody({
//     Key? key,
//     required this.myServiceViewModel,
//   }) : super(key: key);

//   final MyServiceViewModel myServiceViewModel;

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Stack(
//       children: [
//         SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               SizedBox(
//                 height: size.height * 0.28,
//                 child: myServiceViewModel.serviceModel!.imagesList!.isEmpty
//                     ? Container(
//                         color: Colors.black,
//                         child: Image.asset('assets/images/bizhub_logo.png'),
//                       )
//                     : ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount:
//                             myServiceViewModel.serviceModel!.imagesList!.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           // final games = game[index];
//                           final serviceImages = myServiceViewModel
//                               .serviceModel!.imagesList![index];
//                           return Stack(
//                             children: [
//                               Container(
//                                 // margin: const EdgeInsets.only(right: 2.0),
//                                 height: size.height,
//                                 width: size.width,
//                                 decoration: BoxDecoration(
//                                   // color: Colors.amber,
//                                   // borderRadius: BorderRadius.circular(8),
//                                   image: DecorationImage(
//                                     image: NetworkImage(
//                                       AppUrl.baseUrl +
//                                           serviceImages.image.toString(),
//                                     ),
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                 right: 8,
//                                 bottom: 8,
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: 4,
//                                     horizontal: 10,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: Colors.black.withOpacity(0.3),
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   child: Center(
//                                     child: Text(
//                                       '${index + 1}/${myServiceViewModel.serviceModel!.imagesList!.length}',
//                                       style: const TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w400,
//                                         letterSpacing: 2,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '\$ ${myServiceViewModel.serviceModel!.serviceAmount.toString()}',
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       myServiceViewModel.serviceModel!.serviceTitle.toString(),
//                       style: const TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     const Divider(),
//                     const SizedBox(height: 5),
//                     const Text(
//                       'Description',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       myServiceViewModel.serviceModel!.serviceDesc.toString(),
//                       style: const TextStyle(
//                         fontSize: 16,
//                         color: Colors.black54,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     const Divider(),
//                     const SizedBox(height: 5),
//                     const Text(
//                       'Location',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     MyGoogleMap(myServiceViewModel: myServiceViewModel),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
