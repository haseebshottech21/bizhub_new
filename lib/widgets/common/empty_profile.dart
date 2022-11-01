// import 'package:bizhub_new/utils/mytheme.dart';
import 'package:flutter/material.dart';

class EmptyProfile extends StatelessWidget {
  const EmptyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 130,
        height: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Icon(
          Icons.person,
          size: 120,
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
