import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImageWidget extends StatelessWidget {
  final String imgUrl;
  final double? height;
  final double? width;
  final double radius;
  const CachedImageWidget({
    required this.imgUrl,
    this.height,
    this.width,
    this.radius = 50.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        height: height,
        width: width,
        fadeInDuration: const Duration(seconds: 1),
        // placeholder: (context, url) => Container(
        //   color: Colors.black12,
        //   child: Icon(profileIcon, color: Colors.white.withOpacity(0.5)),
        // ),
        // errorWidget: (context, url, error) => Container(
        //   color: Colors.black12,
        //   child: Icon(
        //     profileIcon,
        //     color: Colors.white,
        //   ),
        // ),
        imageUrl: imgUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
