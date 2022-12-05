// import 'package:bizhub_new/utils/mytheme.dart';
import 'package:flutter/material.dart';

class EmptyProfile extends StatelessWidget {
  const EmptyProfile({
    Key? key,
    this.height = 130,
    this.width = 130,
    this.iconSize = 120,
    this.radius = 5,
  }) : super(key: key);

  final double? height, width, iconSize, radius;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius!),
        ),
        child: Icon(
          Icons.person,
          size: iconSize,
          color: Colors.black54,
        ),
      ),
    );
  }
}

class UploadedProfile extends StatelessWidget {
  const UploadedProfile({Key? key, required this.fileImage}) : super(key: key);

  final FileImage fileImage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 130,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: fileImage,
          ),
        ),
      ),
    );
  }
}
