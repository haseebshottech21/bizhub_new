import 'package:flutter/material.dart';
import '../../utils/mytheme.dart';

class JobsPost extends StatelessWidget {
  const JobsPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return jobItem();

    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Column(
      //       children: List.generate(5, (index) {
      //         return jobItem(size);
      //       }),
      //     )
      //   ],
      // ),
      // child: ListView.builder(
      //   physics: const ClampingScrollPhysics(),
      //   shrinkWrap: true,
      //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      //   itemCount: 10,
      //   itemBuilder: (context, index) {
      //     return Padding(
      //       padding: const EdgeInsets.only(bottom: 4),
      //       child: jobItem(size),
      //     );
      //   },
      // ),
      child: Container(
        width: size.width,
        height: size.height,
        child: jobItem(size),
      ),
    );
  }

  Widget jobItem(Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: size.height * 0.20,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          border: const Border(
            left: BorderSide(
              color: Colors.black,
              width: 4,
            ),
          ),
        ),
        // child: Column(
        //   children: [
        //     Container(
        //       height: size.height,
        //       width: size.width,
        //       color: Colors.grey,
        //     ),
        //   ],
        // ),
      ),
    );
  }

  // Widget jobItem(Size size) {
  //   return Container(
  //     height: size.height * 0.17,
  //     width: size.width,
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: const BorderRadius.only(
  //         topLeft: Radius.circular(2),
  //         bottomLeft: Radius.circular(2),
  //       ),
  //       boxShadow: kElevationToShadow[1],
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         Container(
  //           height: size.height,
  //           width: size.width * 0.01,
  //           decoration: const BoxDecoration(
  //             color: MyTheme.greenColor,
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(2),
  //               bottomLeft: Radius.circular(2),
  //             ),
  //           ),
  //         ),
  //         Container(
  //           height: size.height * 0.12,
  //           width: size.width * 0.18,
  //           padding: const EdgeInsets.symmetric(
  //             horizontal: 5,
  //             vertical: 5,
  //           ),
  //           child: ClipRRect(
  //             borderRadius: const BorderRadius.only(
  //               topLeft: Radius.circular(6),
  //               topRight: Radius.circular(6),
  //             ),
  //             child: Image.asset(
  //               'assets/images/job2.jpg',
  //               fit: BoxFit.cover,
  //               // height: constraints.maxHeight * 0.50,
  //               // width: double.infinity,
  //             ),
  //           ),
  //         ),
  //         Container(
  //           height: size.height,
  //           width: size.width * 0.75,
  //           padding: const EdgeInsets.only(
  //             left: 8,
  //             right: 5,
  //             top: 5,
  //             bottom: 8,
  //           ),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               const Text(
  //                 'I will create your bussiness webiste with new features',
  //                 style: TextStyle(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.w400,
  //                 ),
  //                 maxLines: 2,
  //                 overflow: TextOverflow.ellipsis,
  //               ),
  //               const Spacer(),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   const Text(
  //                     '\$ 50',
  //                     style: TextStyle(
  //                       fontSize: 16,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                   Container(
  //                     padding: const EdgeInsets.symmetric(
  //                       horizontal: 16,
  //                       vertical: 4,
  //                     ),
  //                     decoration: BoxDecoration(
  //                       color: Colors.green.shade100,
  //                       borderRadius: BorderRadius.circular(15),
  //                     ),
  //                     child: const Center(
  //                       child: Text('Active'),
  //                     ),
  //                   )
  //                 ],
  //               )
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
