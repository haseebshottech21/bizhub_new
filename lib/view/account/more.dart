import 'package:bizhub_new/utils/icons.dart';
import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:bizhub_new/widgets/common/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/mytheme.dart';
import '../../view_model/auth_view_model.dart';
import '../../widgets/common/cached_image.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(statusBarColor: MyTheme.greenColor),
    // );

    // AuthViewModel authViewModel =
    //     Provider.of<AuthViewModel>(context, listen: false);

    final authViewModel = context.watch<AuthViewModel>();

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
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ViewProfile(),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    'General',
                    style: TextStyle(
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
                  text: 'Setting',
                  iconData: dashboadOutline,
                  onTap: () {},
                ),
                moreItem(
                  context: context,
                  text: 'Setting',
                  iconData: dashboadOutline,
                  onTap: () {},
                ),
                moreItem(
                  context: context,
                  text: 'Setting',
                  iconData: dashboadOutline,
                  onTap: () {},
                ),
                moreItem(
                  context: context,
                  text: 'Setting',
                  iconData: dashboadOutline,
                  onTap: () {},
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 14,
                    bottom: 14,
                    left: 16,
                    right: 16,
                  ),
                  child:
                      // Consumer<AuthViewModel>(
                      //   builder: (context, authViewModel, _) {
                      //     return
                      ElevatedButton(
                    onPressed: () {
                      simpleDialog(
                        context: context,
                        title: 'Confirm Logout',
                        subTitle: 'You are about to logout',
                        onPressed: () {
                          Navigator.of(context).pop();
                          // authViewModel.logout(context);
                         
                          context.read<AuthViewModel>().logout(context);
                        },
                      );
                    },
                    child: const Text('Logout'),
                  ),
                  // },
                ),
                // )
              ],
            ),
            // context.read<AuthViewModel>().loading
            authViewModel.loading
                ? const Center(child: CircularProgressIndicator())
                : const SizedBox()
            // Consumer<AuthViewModel>(
            //   builder: (context, authViewModel, _) {
            //     return authViewModel.loading
            //         ? const Center(child: CircularProgressIndicator())
            //         : const SizedBox();
            //   },
            // ),
          ],
        ),
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
    Key? key,
  }) : super(key: key);

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
                height: size.height * 0.10,
                width: size.width * 0.20,
                radius: 100,
                imgUrl:
                    'https://i.pinimg.com/736x/25/78/61/25786134576ce0344893b33a051160b1.jpg',
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'USER NAME',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'VIEW YOUR PROFILE',
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
