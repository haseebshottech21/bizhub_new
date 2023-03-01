import 'dart:io';
import 'package:bizhub_new/components/deafult_button.dart';
import 'package:bizhub_new/utils/mytheme.dart';
import 'package:bizhub_new/view_model/my_service_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../language/language_constant.dart';
import '../../utils/routes/routes_name.dart';
import '../../view_model/bottom_navigation_view_model.dart';
import '../../widgets/common/dialog_box.dart';

class SelectService extends StatelessWidget {
  const SelectService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final post = Provider.of<MyServiceViewModel>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: MyTheme.whiteColor,
        automaticallyImplyLeading: false,
        elevation: 3,
        leading: IconButton(
          onPressed: () {
            Provider.of<BottomNavigationViewModel>(context, listen: false)
                .toggleCurrentIndex(0);
            final post =
                Provider.of<MyServiceViewModel>(context, listen: false);
            showDialog(
              context: context,
              builder: (_) => cancelDialog(
                context: context,
                title: 'Leave',
                subTitle: 'Are you sure you want to leave ?',
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteName.home,
                    (route) => false,
                  );
                  post.initailValue(context);
                },
              ),
            );
          },
          icon: const Icon(
            Icons.clear,
            color: Colors.black,
            size: 24,
          ),
        ),
        centerTitle: true,
        title: Text(
          translation(context).selectServiceTitle,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
      ),
      bottomSheet: post.isPoster != null
          ? SafeArea(
              child: Padding(
                padding: EdgeInsets.only(bottom: Platform.isIOS ? 20 : 10),
                child: SizedBox(
                  height: size.height * 0.09,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                    child: DeafultButton(
                      title: translation(context).continueTxt,
                      onPress: () {
                        Navigator.pushNamed(context, RouteName.selectCategory);
                        // print(post.isPoster);
                      },
                      // onPress: null,
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox(),
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // serviceItem(context),
            // serviceItem(context),
            ServiceTypeItem(
              serviceTypeText: 'JOB',
              serviceTypeImage: 'assets/images/service_one.png',
              // selectType: true,
              // onTap: (){},
              selectType: (post.isPoster != null && post.isPoster == true)
                  ? true
                  : false,
              onTap: () => post.selectServiceType(true),
            ),
            ServiceTypeItem(
              serviceTypeText: 'SERVICE',
              serviceTypeImage: 'assets/images/service_two.png',
              selectType: (post.isPoster != null && post.isPoster == false)
                  ? true
                  : false,
              onTap: () => post.selectServiceType(false),
            )
          ],
        ),
      ),
    );
  }
}

class ServiceTypeItem extends StatelessWidget {
  const ServiceTypeItem({
    Key? key,
    required this.serviceTypeText,
    required this.serviceTypeImage,
    required this.selectType,
    required this.onTap,
  }) : super(key: key);

  final String serviceTypeText, serviceTypeImage;
  final bool selectType;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: size.height * 0.31,
        width: size.width * 0.44,
        child: Stack(
          children: [
            Center(
              child: Container(
                height: size.height,
                width: size.width * 0.40,
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: selectType ? MyTheme.greenColor : Colors.white,
                  boxShadow: selectType
                      ? kElevationToShadow[6]
                      : kElevationToShadow[1],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
                child: Text(
                  serviceTypeText,
                  style: TextStyle(
                    color: selectType ? Colors.white : MyTheme.greenColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Stack(
                children: [
                  Container(
                    height: size.height * 0.26,
                    width: size.width,
                    decoration: BoxDecoration(
                      // boxShadow: kElevationToShadow[8],
                      boxShadow: selectType
                          ? kElevationToShadow[8]
                          : kElevationToShadow[4],
                      // borderRadius: BorderRadius.circular(4),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset(
                        serviceTypeImage,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  selectType
                      ? Container(
                          height: size.height * 0.26,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              stops: const [0.1, 0.8],
                              colors: [
                                // Colors.black.withOpacity(0.2),
                                // Colors.black.withOpacity(0.9),
                                MyTheme.greenColor.withOpacity(0.2),
                                MyTheme.greenColor.withOpacity(0.4),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
