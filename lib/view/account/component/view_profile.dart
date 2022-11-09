// import 'package:bizhub_new/components/empty_icon.dart';
import 'package:bizhub_new/utils/app_url.dart';
import 'package:bizhub_new/widgets/common/empty_profile.dart';
import 'package:flutter/material.dart';
import '../../../utils/mytheme.dart';
import '../../../widgets/common/cached_image.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({
    required this.userName,
    required this.image,
    Key? key,
  }) : super(key: key);

  final String userName;
  final Widget image;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // print('img: ' + userImage.toString());

    return Container(
      width: size.width,
      padding: const EdgeInsets.only(bottom: 12, top: 12),
      decoration: const BoxDecoration(
        color: MyTheme.greenColor,
        // borderRadius: BorderRadius.only(
        //   bottomLeft: Radius.circular(6),
        //   bottomRight: Radius.circular(6),
        // ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            image,
            const SizedBox(height: 16),
            Text(
              userName,
              style: const TextStyle(
                fontSize: 24,
                letterSpacing: 0.5,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
