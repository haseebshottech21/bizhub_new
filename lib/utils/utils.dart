import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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

  // Device Type
  static String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 550 ? 'phone' : 'tablet';
  }

  // TOAST
  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  // SNACKBAR
  static void snackBarMessage({
    required String message,
    required IconData icons,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icons, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              message,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        backgroundColor: Colors.black87,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(12),
        elevation: 2,
        duration: const Duration(milliseconds: 1500),
        // action: SnackBarAction(
        //   label: 'Open',
        //   onPressed: () => onPress(),
        // ),
      ),
    );
  }

  // DATE FORMAT
  String dateFormat(String date) {
    final parsedDate = DateTime.parse(date.toUpperCase());

    // final inputDate = DateFormat.parse(date);
    // return DateFormat('d MMM, yyyy').format(parsedDate);
    return DateFormat('dd MMM').format(parsedDate).toUpperCase();
  }

  // DATE FORMAT
  // String dateFormat(String date) {
  //   final inputDate = DateFormat('dd-MM-yy').parse(date);
  //   // print(inputDate);
  //   // return outputFormat.format(inputDate);
  //   return DateFormat('d MMM').format(inputDate);
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

  Future<List<Map<String, dynamic>>> selectImages() async {
    final images = await ImagePicker().pickMultiImage();
    List<Map<String, dynamic>> imageDetails = [];
    if (images != null) {
      for (var image in images) {
        Map<String, dynamic> imageDetail = {};
        imageDetail['extension'] = image.path.split('.').last;
        imageDetail['imagePath'] = image.path;
        imageDetail['image'] =
            base64Encode(await File(image.path).readAsBytes());
        imageDetails.add(imageDetail);
      }
    }
    return imageDetails;
  }
}
