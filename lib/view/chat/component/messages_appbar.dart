import 'package:bizhub_new/model/user_model.dart';
import 'package:flutter/material.dart';
import '../../account/profile/view_other_profile.dart';

messageAppBar({
  required BuildContext context,
  required String userName,
  required Widget userImage,
  required UserModel? userModel,
  required Function() backPressed,
}) {
  return AppBar(
    leading: IconButton(
      padding: EdgeInsets.zero,
      onPressed: backPressed,
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: false,
    titleSpacing: 0,
    title: ListTile(
      leading: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ViewOtherProfile(),
              settings: RouteSettings(arguments: userModel),
            ),
          );
        },
        child: userImage,
      ),
      title: Text(
        userName,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
    ),
  );
}
