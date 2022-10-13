import 'package:flutter/material.dart';
import '../../../utils/mytheme.dart';
import '../../../widgets/common/cached_image.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({
    required this.userName,
    required this.userImage,
    Key? key,
  }) : super(key: key);

  final String userName;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: const EdgeInsets.only(bottom: 15),
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
            CachedImageWidget(
              height: size.height * 0.20,
              width: size.width * 0.40,
              radius: 100,
              imgUrl: userImage,
            ),
            const SizedBox(height: 12),
            Text(
              userName,
              style: const TextStyle(
                fontSize: 24,
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
