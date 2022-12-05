import 'package:bizhub_new/language/language_constant.dart';
import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:bizhub_new/widgets/common/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/app_url.dart';
import '../../utils/mytheme.dart';
import '../../view_model/auth_view_model.dart';
import '../../widgets/common/cached_image.dart';
import '../../widgets/common/empty_profile.dart';

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
                  image: auth.getPrefrenceValue('image') == null.toString()
                      ? EmptyProfile(
                          height: size.height * 0.10,
                          width: size.width * 0.20,
                          iconSize: 60,
                          radius: 100,
                        )
                      : CachedImageWidget(
                          height: size.height * 0.10,
                          width: size.width * 0.20,
                          imgUrl:
                              AppUrl.baseUrl + auth.getPrefrenceValue('image'),
                        ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    translation(context).general,
                    style: const TextStyle(
                      // color: Theme.of(context).textTheme.bodyText1!.color,
                      fontSize: 22,
                      color: Colors.black87,
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
                // moreItem(
                //   context: context,
                //   text: translation(context).selectLanguage,
                //   iconData: CupertinoIcons.globe,
                //   onTap: () {
                //     Navigator.pushNamed(context, RouteName.selectLanguage);
                //   },
                // ),
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
                //   text: 'Location',
                //   iconData: Icons.pin_drop,
                //   onTap: () {
                //     Navigator.pushNamed(context, RouteName.testLocation);
                //   },
                // ),
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
                        title: 'Logout',
                        subTitle: 'Are you sure, do you want to logout ?',
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
                        const EdgeInsets.fromLTRB(32.0, 6.0, 32.0, 6.0),
                      ),
                    ),
                    child: Text(
                      translation(context).logout,
                      style: const TextStyle(
                        color: MyTheme.redBorder,
                        fontSize: 17,
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
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: MyTheme.greenColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                iconData,
                color: MyTheme.greenColor,
                size: 24,
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
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: Theme.of(context).iconTheme.color,
              size: 17,
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
    this.image,
    Key? key,
  }) : super(key: key);

  final String userName;
  final Widget? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 25,
        bottom: 20,
      ),
      color: MyTheme.greenColor,
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
              image!,
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 24,
                      letterSpacing: 0.5,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    translation(context).viewYourProfile,
                    style: TextStyle(
                      color: Colors.grey.shade50,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
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
