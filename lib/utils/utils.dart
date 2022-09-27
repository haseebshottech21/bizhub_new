import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Utils {
  // Change Focus Node
  // static fieldFocusChange(
  //   BuildContext context,
  //   FocusNode currentNode,
  //   FocusNode nextNode,
  // ) {
  //   currentNode.unfocus();
  //   FocusScope.of(context).requestFocus(nextNode);
  // }

  // TOAST
  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  // SNACKBAR
  static void snackBarMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // DATE FORMAT
  // String dateFormat(String date) {
  //   final inputDate = DateFormat('dd-MM-yy').parse(date);
  //   // print(inputDate);
  //   // return outputFormat.format(inputDate);
  //   return DateFormat('d MMM, yyyy').format(inputDate);
  // }

  // CROP IMAGE
  // Future<File?> cropImage({required File imageFile}) async {
  //   CroppedFile? croppedImage = await ImageCropper().cropImage(
  //     sourcePath: imageFile.path,
  //     aspectRatioPresets: [
  //       CropAspectRatioPreset.square,
  //       CropAspectRatioPreset.ratio3x2,
  //       CropAspectRatioPreset.original,
  //       CropAspectRatioPreset.ratio4x3,
  //       CropAspectRatioPreset.ratio16x9
  //     ],
  //   );
  //   if (croppedImage == null) return null;
  //   return File(croppedImage.path);
  // }

  // Future<dynamic> getImageFromSource(
  //   BuildContext context,
  //   ImageSource source,
  //   bool toCrop,
  // ) async {
  //   try {
  //     var image = await ImagePicker().pickImage(source: source);
  //     if (image == null) return null;
  //     if (toCrop) {
  //       var croppedImage = await cropImage(imageFile: File(image.path));
  //       return croppedImage;
  //     }
  //   } on PlatformException {
  //     Navigator.of(context).pop();
  //   }
  // }

  Future<dynamic> getImageFromSource(
    BuildContext context,
    ImageSource source,
  ) async {
    try {
      var image = await ImagePicker().pickImage(source: source);
      if (image == null) return null;
      // if (toCrop) {
      //   var croppedImage = await cropImage(imageFile: File(image.path));
      //   return croppedImage;
      // }
      return File(image.path);
    } on PlatformException {
      Navigator.of(context).pop();
    }
  }
}
