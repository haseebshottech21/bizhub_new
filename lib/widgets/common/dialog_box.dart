import 'package:bizhub_new/utils/mytheme.dart';
import 'package:flutter/material.dart';

AlertDialog simpleDialog({
  required BuildContext context,
  required String title,
  required String subTitle,
  required void Function() onPressed,
}) {
  return AlertDialog(
    titlePadding: const EdgeInsets.only(top: 16, left: 24, bottom: 6),
    contentPadding:
        const EdgeInsets.only(top: 2, bottom: 12, left: 24, right: 24),
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
    content: Text(
      subTitle,
      style: const TextStyle(
        color: Colors.black87,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
    ),
    actions: <Widget>[
      TextButton(
        child: const Text(
          'Cancel',
          style: TextStyle(
            color: Colors.black45,
            fontSize: 17,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      TextButton(
        onPressed: () => onPressed(),
        child: const Text(
          'Confirm',
          style: TextStyle(
            color: MyTheme.greenColor,
            fontSize: 17,
          ),
        ),
      ),
    ],
  );
}

AlertDialog cancelDialog({
  required BuildContext context,
  required String title,
  required String subTitle,
  required void Function() onPressed,
}) {
  return AlertDialog(
    titlePadding: const EdgeInsets.only(top: 16, left: 24, bottom: 6),
    contentPadding:
        const EdgeInsets.only(top: 2, bottom: 12, left: 24, right: 24),
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
    ),
    content: Text(
      subTitle,
      style: const TextStyle(
        color: Colors.black87,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () => onPressed(),
        child: const Text(
          'Exit',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
      ),
      TextButton(
        child: const Text(
          'Continue',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}

simpleShowDialog({
  required BuildContext context,
  required String title,
  required String subTitle,
  required Function press,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: const EdgeInsets.only(top: 16, left: 24, bottom: 6),
        contentPadding:
            const EdgeInsets.only(top: 2, bottom: 12, left: 24, right: 24),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: Text(
          subTitle,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text(
              'Confirm',
              style: TextStyle(
                color: MyTheme.greenColor,
                fontSize: 17,
              ),
            ),
            onPressed: () {
              press();
            },
          ),
        ],
      );
    },
  );
}
