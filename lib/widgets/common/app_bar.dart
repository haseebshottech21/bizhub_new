import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:bizhub_new/widgets/common/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/mytheme.dart';
import '../../view_model/bottom_navigation_view_model.dart';
import '../../view_model/my_service_view_model.dart';

myAppBar({
  required BuildContext context,
  required String appBarTitle,
}) {
  return AppBar(
    backgroundColor: MyTheme.whiteColor,
    elevation: 3,
    automaticallyImplyLeading: false,
    // leading: IconButton(
    //   onPressed: () {
    //     Navigator.of(context).pop();
    //   },
    //   icon: const Icon(
    //     Icons.arrow_back,
    //     color: MyTheme.greenColor,
    //     size: 22.0,
    //   ),
    // ),
    centerTitle: true,
    title: Text(
      appBarTitle,
      style: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
    ),
  );
}

mainAppBar({
  required BuildContext context,
  required String appBarTitle,
}) {
  return AppBar(
    backgroundColor: MyTheme.whiteColor,
    elevation: 3,
    leading: IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(
        Icons.arrow_back,
        color: MyTheme.greenColor,
        size: 24,
      ),
    ),
    centerTitle: false,
    title: Text(
      appBarTitle,
      style: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
    ),
  );
}

actionAppBar({
  required BuildContext context,
  required String appBarTitle,
  required String btnText,
  required VoidCallback onPressed,
}) {
  return AppBar(
    backgroundColor: MyTheme.whiteColor,
    automaticallyImplyLeading: false,
    elevation: 3,
    // leading: IconButton(
    //   onPressed: () {
    //     Navigator.of(context).pop();
    //   },
    //   icon: const Icon(
    //     Icons.arrow_back,
    //     color: MyTheme.greenColor,
    //     size: 22.0,
    //   ),
    // ),
    centerTitle: false,
    title: Text(
      appBarTitle,
      style: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
    ),
    actions: [
      TextButton(
        onPressed: onPressed,
        child: Text(btnText),
      ),
    ],
  );
}

cancelAppBar({
  required BuildContext context,
  required String appBarTitle,
  required int index,
  // required VoidCallback cancelPressed,
}) {
  return AppBar(
    backgroundColor: MyTheme.whiteColor,
    automaticallyImplyLeading: false,
    elevation: 3,
    leading: IconButton(
      onPressed: () {
        Provider.of<BottomNavigationViewModel>(context, listen: false)
            .toggleCurrentIndex(index);
        final post = Provider.of<MyServiceViewModel>(context, listen: false);
        showDialog(
          context: context,
          builder: (_) => simpleDialog(
            context: context,
            title: 'Confirm Cancel',
            subTitle: 'You are sure to cancel ?',
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                RouteName.home,
                (route) => false,
              );
              post.isPoster = null;
            },
          ),
        );
      },
      icon: const Icon(
        Icons.clear,
        color: Colors.black,
        size: 22.0,
      ),
    ),
    centerTitle: true,
    title: Text(
      appBarTitle,
      style: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.w400,
        fontSize: 17,
      ),
    ),
    // actions: [
    //   TextButton(
    //     onPressed: onPressed,
    //     child: Text(btnText),
    //   ),
    // ],
  );
}
