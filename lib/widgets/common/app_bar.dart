import 'package:flutter/material.dart';
import '../../utils/mytheme.dart';

myAppBar({
  required BuildContext context,
  required String appBarTitle,
}) {
  return AppBar(
    backgroundColor: MyTheme.whiteColor,
    elevation: 3,
    automaticallyImplyLeading: false,
    // leading: IconButton(
    //   onPressed: () {
    //     Navigator.of(context).pop();
    //   },
    //   icon: const Icon(
    //     Icons.arrow_back,
    //     color: MyTheme.greenColor,
    //     size: 22.0,
    //   ),
    // ),
    centerTitle: true,
    title: Text(
      appBarTitle,
      style: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.w400,
        fontSize: 17,
      ),
    ),
  );
}

mainAppBar({
  required BuildContext context,
  required String appBarTitle,
}) {
  return AppBar(
    backgroundColor: MyTheme.whiteColor,
    elevation: 3,
    leading: IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(
        Icons.arrow_back,
        color: MyTheme.greenColor,
        size: 22.0,
      ),
    ),
    centerTitle: false,
    title: Text(
      appBarTitle,
      style: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.w400,
        fontSize: 17,
      ),
    ),
  );
}

actionAppBar({
  required BuildContext context,
  required String appBarTitle,
  required String btnText,
  required VoidCallback onPressed,
}) {
  return AppBar(
    backgroundColor: MyTheme.whiteColor,
    automaticallyImplyLeading: false,
    elevation: 3,
    // leading: IconButton(
    //   onPressed: () {
    //     Navigator.of(context).pop();
    //   },
    //   icon: const Icon(
    //     Icons.arrow_back,
    //     color: MyTheme.greenColor,
    //     size: 22.0,
    //   ),
    // ),
    centerTitle: false,
    title: Text(
      appBarTitle,
      style: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.w400,
        fontSize: 17,
      ),
    ),
    actions: [
      TextButton(
        onPressed: onPressed,
        child: Text(btnText),
      ),
    ],
  );
}
