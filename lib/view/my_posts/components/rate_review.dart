import 'package:bizhub_new/utils/mytheme.dart';
import 'package:flutter/material.dart';

import '../../../widgets/common/input_textfield.dart';

rateReviewDialog({
  // required String applicationId,
  // required String serviceId,
  required String status,
  // required String userId,
  required String userName,
  required BuildContext context,
  // required bool isPoster,
}) {
  final comment = TextEditingController();
  showGeneralDialog(
    context: context,
    pageBuilder: (ctx, a1, a2) {
      return Container();
    },
    transitionDuration: const Duration(milliseconds: 600),
    transitionBuilder: (context, a1, a2, child) {
      var curve = Curves.linearToEaseOut.transform(a1.value);
      return Transform.scale(
        scale: curve,
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          backgroundColor: Colors.white,
          titlePadding: EdgeInsets.zero,
          title: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: MyTheme.greenColor,
              boxShadow: kElevationToShadow[2],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: const Center(
              child: Text(
                "RATE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // profileEmpty(),
                  const SizedBox(height: 5),
                  // Center(
                  //   child: CircleAvatar(
                  //     radius: 30,
                  //     backgroundColor: Colors.white,
                  //     // child: Center(
                  //     //   child: FaIcon(
                  //     //     FontAwesomeIcons.solidUserCircle,
                  //     //     color: AppColors.primaryColor,
                  //     //     size: 60.0,
                  //     //   ),
                  //     // ),
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      userName,
                      style: const TextStyle(
                        color: MyTheme.greenColor,
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Center(
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(
                  //       horizontal: 12,
                  //       vertical: 5,
                  //     ),
                  //     decoration: BoxDecoration(
                  //       color: Colors.grey[50],
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     child: Text(
                  //       status == '1' ? 'POSTER' : 'WORKER',
                  //       style: TextStyle(
                  //         // color: AppColors.lightColor,
                  //         fontWeight: FontWeight.w400,
                  //         fontSize: 13,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  // Consumer<ServiceViewModel>(
                  //   builder: (ctx, userViewModel, neverBuildChild) {
                  //     return
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     GestureDetector(
                  //       onTap: () {
                  //         // userViewModel.updateRating(1);
                  //       },
                  //       child: Icon(
                  //         Icons.star,
                  //         color:  Colors.grey,
                  //         size: 45,
                  //       ),
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         // userViewModel.updateRating(2);
                  //       },
                  //       child: Icon(
                  //         Icons.star,
                  //         color: userViewModel.rating >= 2
                  //             ? AppColors.primaryColor
                  //             : Colors.grey,
                  //         size: 45,
                  //       ),
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         userViewModel.updateRating(3);
                  //       },
                  //       child: Icon(
                  //         Icons.star,
                  //         color: userViewModel.rating >= 3
                  //             ? AppColors.primaryColor
                  //             : Colors.grey,
                  //         size: 45,
                  //       ),
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         userViewModel.updateRating(4);
                  //       },
                  //       child: Icon(
                  //         Icons.star,
                  //         color: userViewModel.rating >= 4
                  //             ? AppColors.primaryColor
                  //             : Colors.grey,
                  //         size: 45,
                  //       ),
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         userViewModel.updateRating(5);
                  //       },
                  //       child: Icon(
                  //         Icons.star,
                  //         color: userViewModel.rating >= 5
                  //             ? AppColors.primaryColor
                  //             : Colors.grey,
                  //         size: 45,
                  //       ),
                  //     ),
                  //   ],
                  // );
                  //   },
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) => GestureDetector(
                        onTap: () {
                          // userViewModel.updateRating(1);
                        },
                        child: const Icon(
                          Icons.star,
                          color: Colors.grey,
                          size: 45,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: FormTextAreaField(
                      controller: comment,
                      hintText: 'Review',
                      validator: (va) {},
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          actionsPadding: const EdgeInsets.only(bottom: 10, right: 15),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'LATER',
                style: TextStyle(
                    // color: AppColors.primaryColor,
                    ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: MyTheme.greenColor),
              child: const Text('SUBMIT'),
            ),
            // ElevatedButton(
            //   onPressed: () async {
            //     final provider =
            //         Provider.of<ServiceViewModel>(context, listen: false);
            //     await provider.ratingService(
            //       comment: comment.text.trim(),
            //       context: context,
            //       rating: provider.rating.toString(),
            //       serviceId: serviceId,
            //       applicationId: applicationId,
            //       status: status,
            //       userId: userId,
            //       isPoster: isPoster,
            //     );
            //     // Navigator.of(context).pop();
            //   },
            //   style: ElevatedButton.styleFrom(primary: AppColors.primaryColor),
            //   child: const Text('SUBMIT'),
            // ),
          ],
        ),
      );
    },
  );
}


// class RatingDialog extends StatefulWidget {
//   @override
//   _RatingDialogState createState() => _RatingDialogState();
// }

// class _RatingDialogState extends State<RatingDialog> {
//   int _stars = 0;

//   Widget _buildStar(int starCount) {
//     return InkWell(
//       child: Icon(
//         Icons.star,
//         // size: 30.0,
//         color: _stars >= starCount ? Colors.orange : Colors.grey,
//       ),
//       onTap: () {
//         setState(() {
//           _stars = starCount;
//         });
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Transform.scale(
//       child: AlertDialog(
//         title: Center(
//           child: Text('Rate this post'),
//         ),
//         content: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             _buildStar(1),
//             _buildStar(2),
//             _buildStar(3),
//             _buildStar(4),
//             _buildStar(5),
//           ],
//         ),
//         actions: <Widget>[
//           ElevatedButton(
//             onPressed: Navigator.of(context).pop,
//             child: Text('CANCEL'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.of(context).pop(_stars);
//             },
//             child: Text('OK'),
//           )
//         ],
//       ),
//     );
//   }
// }
