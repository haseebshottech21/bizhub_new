import 'package:bizhub_new/model/user_model.dart';
import 'package:flutter/material.dart';

import '../../account/profile/view_other_profile.dart';

messageAppBar({
  required BuildContext context,
  required String userName,
  required String userImage,
  required UserModel userModel,
}) {
  return AppBar(
    leading: const BackButton(color: Colors.black),
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: false,
    titleSpacing: 0,
    title: ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ViewOtherProfile(),
            settings: RouteSettings(
              // arguments: {
              //   'first_name': user!.firstName,
              // },
              arguments: userModel,
            ),
          ),
        );
      },
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          // chat['userImage'] == null ? img : AppUrl.baseUrl + chat['userImage'],
          userImage,
        ),
      ),
      title: Text(
        // chat['userName'],
        userName,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  );
}
