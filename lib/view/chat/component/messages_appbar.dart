import 'package:bizhub_new/model/user_model.dart';
import 'package:flutter/material.dart';
import '../../../widgets/common/cached_image.dart';
import '../../account/profile/view_other_profile.dart';

messageAppBar({
  required BuildContext context,
  required String userName,
  required String userImage,
  required UserModel? userModel,
}) {
  return AppBar(
    leading: const BackButton(color: Colors.black),
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: false,
    titleSpacing: 0,
    title: ListTile(
      leading: GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const ViewOtherProfile(),
          //     settings: RouteSettings(arguments: userModel!),
          //   ),
          // );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ViewOtherProfile(),
              settings: RouteSettings(
                arguments: userModel,
              ),
            ),
          );
        },
        child: CachedImageWidget(
          height: 45,
          width: 45,
          radius: 50,
          imgUrl: userImage,
        ),
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
