import 'package:flutter/material.dart';

messageAppBar({
  required BuildContext context,
  required String userName,
  required String userImage,
}) {
  return AppBar(
    leading: const BackButton(color: Colors.black),
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: false,
    titleSpacing: 0,
    title: ListTile(
      onTap: () {},
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
