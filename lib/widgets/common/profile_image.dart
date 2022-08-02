// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utils/mytheme.dart';

// class CachedImageWidget extends StatelessWidget {
//   final String imgUrl;
//   final double? height;
//   final double? width;
//   final double radius;
//   const CachedImageWidget({
//     required this.imgUrl,
//     this.height,
//     this.width,
//     this.radius = 50.0,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(radius),
//       child: CachedNetworkImage(
//         height: height,
//         width: width,
//         fadeInDuration: const Duration(seconds: 1),
//         placeholder: (context, url) => Container(
//           color: Colors.black12,
//           child: Icon(Icons.person, color: Colors.white.withOpacity(0.1)),
//         ),
//         // errorWidget: (context, url, error) => Container(
//         //   color: Colors.black12,
//         //   child: const Icon(
//         //     Icons.person,
//         //     color: Colors.white,
//         //   ),
//         // ),
//         imageUrl: imgUrl,
//         fit: BoxFit.cover,
//       ),
//     );
//   }
// }

class ProfileImage extends StatelessWidget {
  const ProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 150,
      child: Stack(
        children: [
          Center(
            child: Container(
              width: 125,
              height: 125,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(
                Icons.person,
                size: 115,
                color: Colors.black38,
              ),
            ),
          ),
          Positioned(
            right: 5,
            bottom: 5,
            child: Container(
              // width: 32,
              // height: 32,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: MyTheme.greenColor,
                borderRadius: BorderRadius.circular(6),
                // border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Center(
                child: Icon(
                  Icons.add,
                  color: MyTheme.whiteColor,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
