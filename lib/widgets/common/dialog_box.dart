import 'package:flutter/material.dart';

AlertDialog simpleDialog({
  required BuildContext context,
  required String title,
  required String subTitle,
  required void Function() onPressed,
}) {
  return AlertDialog(
    titlePadding: const EdgeInsets.only(top: 16, left: 24),
    contentPadding:
        const EdgeInsets.only(top: 2, bottom: 12, left: 24, right: 24),
    title: Text(title),
    content: Text(
      subTitle,
      style: const TextStyle(
        color: Colors.black87,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
    actions: <Widget>[
      TextButton(
        child: const Text(
          'Cancel',
          style: TextStyle(
            color: Colors.black,
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
            color: Colors.black,
          ),
        ),
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
        titlePadding: const EdgeInsets.only(top: 16, left: 24),
        contentPadding:
            const EdgeInsets.only(top: 2, bottom: 12, left: 24, right: 24),
        title: Text(title),
        content: Text(
          subTitle,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.black,
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
                color: Colors.black,
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

// Future<void> simpleDialog({
//   required BuildContext context,
//   required String title,
//   required String subTitle,
//   required void Function()? onPressed,
// }) {
//   return showDialog(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         titlePadding: const EdgeInsets.only(top: 16, left: 24),
//         contentPadding:
//             const EdgeInsets.only(top: 2, bottom: 12, left: 24, right: 24),
//         title: Text(title),
//         content: Text(
//           subTitle,
//           style: const TextStyle(
//             color: Colors.black87,
//             fontSize: 14,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: const Text(
//               'Cancel',
//               style: TextStyle(
//                 color: Colors.black,
//               ),
//             ),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           TextButton(
//             onPressed: onPressed,
//             child: const Text(
//               'Confirm',
//               style: TextStyle(
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }
