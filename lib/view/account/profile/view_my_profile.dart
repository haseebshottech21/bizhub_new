import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/mytheme.dart';
import '../../../widgets/common/cached_image.dart';

class ViewMyProfile extends StatelessWidget {
  const ViewMyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(statusBarColor: MyTheme.greenColor),
    // );

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyTheme.greenColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteName.editMyProfile);
            },
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ViewProfile(),
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              'About',
              style: TextStyle(
                // color: Theme.of(context).textTheme.bodyText1!.color,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'No description added yet.',
                  style: TextStyle(
                    // decoration: TextDecoration.underline,
                    color: Colors.grey.shade500,
                  ),
                ),
                const Text(
                  "www.google.com",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    // decoration: TextDecoration.underline,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ViewProfile extends StatelessWidget {
  const ViewProfile({
    Key? key,
  }) : super(key: key);

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
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedImageWidget(
                height: size.height * 0.18,
                width: size.width * 0.36,
                radius: 100,
                imgUrl:
                    'https://i.pinimg.com/736x/25/78/61/25786134576ce0344893b33a051160b1.jpg',
              ),
              const SizedBox(height: 12),
              const Text(
                'USER NAME',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
