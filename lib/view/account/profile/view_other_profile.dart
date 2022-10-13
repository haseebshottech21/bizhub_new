import 'package:bizhub_new/model/user_model.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_url.dart';
import '../../../utils/mytheme.dart';
import '../component/view_profile.dart';

class ViewOtherProfile extends StatelessWidget {
  const ViewOtherProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserModel profile =
        ModalRoute.of(context)!.settings.arguments as UserModel;

    // print(profile.firstName);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyTheme.greenColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ViewProfile(
            userName: '${profile.firstName} ${profile.lastName}',
            userImage: profile.image!.isEmpty
                ? 'https://i.pinimg.com/736x/25/78/61/25786134576ce0344893b33a051160b1.jpg'
                : AppUrl.baseUrl + profile.image!,
          ),
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
                GestureDetector(
                  child: const Text(
                    "www.google.com",
                    // viewProfile.response['url'] ?? '',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      // decoration: TextDecoration.underline,
                      color: Colors.blue,
                    ),
                  ),
                  onTap: () async {
                    // const url = 'https://www.google.com';
                    // var url =
                    //     'https://' + viewProfile.response['url'].toString();
                    // if (await canLaunch(url)) launch(url);
                  },
                ),
              ],
            ),
          ),
          // Text(
          //   '${authViewModel.user!.firstName}',
          //   textAlign: TextAlign.start,
          //   style: TextStyle(
          //     // decoration: TextDecoration.underline,
          //     color: Colors.blue,
          //   ),
          // ),
        ],
      ),
    );
  }
}
