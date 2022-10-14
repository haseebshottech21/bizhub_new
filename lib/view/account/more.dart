import 'package:bizhub_new/language/language_constant.dart';
import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:bizhub_new/widgets/common/dialog_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/app_url.dart';
import '../../utils/mytheme.dart';
import '../../view_model/auth_view_model.dart';
import '../../widgets/common/cached_image.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  getData() {
    final auth = context.read<AuthViewModel>();
    auth.setPrefrenceValues();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthViewModel>();

    // print(authViewModel.user!.firstName.toString());

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          color: MyTheme.greenColor,
          width: size.width,
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ViewProfile(
                  userName:
                      '${auth.getPrefrenceValue('firstName')} ${auth.getPrefrenceValue('lastName')}',
                  userImage: auth.getPrefrenceValue('image').isEmpty
                      ? 'https://i.pinimg.com/736x/25/78/61/25786134576ce0344893b33a051160b1.jpg'
                      : AppUrl.baseUrl + auth.getPrefrenceValue('image'),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    translation(context).general,
                    style: const TextStyle(
                      // color: Theme.of(context).textTheme.bodyText1!.color,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                moreItem(
                  context: context,
                  text: translation(context).changePassword,
                  iconData: Icons.lock,
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.changePassword);
                  },
                ),
                moreItem(
                  context: context,
                  text: translation(context).selectLanguage,
                  iconData: CupertinoIcons.globe,
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.selectLanguage);
                  },
                ),
                moreItem(
                  context: context,
                  text: translation(context).aboutUs,
                  iconData: Icons.perm_device_info,
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.aboutUs);
                  },
                ),
                // moreItem(
                //   context: context,
                //   text: 'Contact Us',
                //   iconData: Icons.phone,
                //   onTap: () {
                //     Navigator.pushNamed(context, RouteName.contactUs);
                //   },
                // ),
                moreItem(
                  context: context,
                  text: translation(context).termAndCondition,
                  iconData: Icons.bookmark_add_rounded,
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.termAndCondition);
                  },
                ),
                moreItem(
                  context: context,
                  text: translation(context).privacyPolicy,
                  iconData: Icons.privacy_tip,
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.privacyPolicy);
                  },
                ),
                // moreItem(
                //   context: context,
                //   text: 'Logout',
                //   iconData: dashboadOutline,
                //   onTap: () {
                //     simpleDialog(
                //       context: context,
                //       title: 'Confirm Logout',
                //       subTitle: 'You are about to logout',
                //       onPressed: () {
                //         Navigator.of(context).pop();
                //         // authViewModel.logout(context);

                //         context.read<AuthViewModel>().logout(context);
                //       },
                //     );
                //   },
                // ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 12.0, 14.0, 14.0),
                  child: TextButton(
                    onPressed: () {
                      simpleShowDialog(
                        context: context,
                        title: 'Confirm Logout',
                        subTitle: 'You are about to logout',
                        press: () {
                          Navigator.of(context).pop();
                          // authViewModel.logout(context);

                          context.read<AuthViewModel>().logout(context);
                        },
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.red.withOpacity(0.1),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.fromLTRB(30.0, 6.0, 30.0, 6.0),
                      ),
                    ),
                    child: Text(
                      translation(context).logout,
                      style: const TextStyle(
                        color: MyTheme.redBorder,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          auth.loading
              ? Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: 65,
                    width: MediaQuery.of(context).size.width * 0.42,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: kElevationToShadow[6],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.grey[200],
                            valueColor: const AlwaysStoppedAnimation(
                                MyTheme.greenColor),
                            strokeWidth: 2.5,
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Text(
                          "Please Wait...",
                          style: TextStyle(
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  Widget moreItem({
    required BuildContext context,
    required String text,
    required IconData iconData,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 14,
          bottom: 14,
          left: 16,
          right: 16,
        ),
        child: Row(
          children: [
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: MyTheme.greenColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                iconData,
                color: MyTheme.greenColor,
                size: 23,
              ),
            ),
            const SizedBox(width: 15),
            Text(
              text,
              style: const TextStyle(
                // color: profile[index]['title'] == 'Logout'
                //     ? Color(0xFF3c7cbc)
                //     : Theme.of(context).textTheme.bodyText1!.color,
                // color: Color(0xFF50182c),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: Theme.of(context).iconTheme.color,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

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
      padding: const EdgeInsets.only(
        top: 25,
        bottom: 20,
      ),
      decoration: const BoxDecoration(
        color: MyTheme.greenColor,
        // borderRadius: BorderRadius.only(
        //   bottomLeft: Radius.circular(6),
        //   bottomRight: Radius.circular(6),
        // ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RouteName.viewMyProfile);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CachedImageWidget(
                height: size.height * 0.09,
                width: size.width * 0.18,
                imgUrl: userImage,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.70,
                    child: Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    translation(context).viewYourProfile,
                    style: TextStyle(
                      color: Colors.grey.shade50,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
