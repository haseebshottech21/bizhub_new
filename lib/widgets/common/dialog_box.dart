import 'package:bizhub_new/utils/icons.dart';
import 'package:bizhub_new/utils/mytheme.dart';
import 'package:bizhub_new/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

AlertDialog confirmDeleteDialog({
  required BuildContext context,
  required String title,
  required TextEditingController controller,
  required void Function() onPressed,
}) {
  return AlertDialog(
    actionsPadding: EdgeInsets.zero,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    content: Builder(
      builder: (context) {
        // Get available height and width of the build area of this widget. Make a choice depending on the size.
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;

        return SizedBox(
          height: height * 0.20,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18, color: Colors.black87),
              ),
              const SizedBox(height: 12),
              Form(
                // key: _formKey,
                child: Consumer<AuthViewModel>(
                  builder: (context, authViewModel, _) {
                    return TextFormField(
                      style: const TextStyle(color: Colors.black87),
                      controller: controller,
                      obscureText: authViewModel.passwordHide,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        hintText: 'your password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () => authViewModel.togglePassword(),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Icon(
                              authViewModel.passwordHide
                                  ? hidePassword
                                  : showPassword,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: width,
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: MyTheme.redBorder,
                  ),
                  child: const Text(
                    'CONFIRM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    ),
  );
}
