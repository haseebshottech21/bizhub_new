import 'package:bizhub_new/components/deafult_button.dart';
import 'package:bizhub_new/utils/mytheme.dart';
import 'package:bizhub_new/view_model/my_service_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/routes/routes_name.dart';
import '../../view_model/bottom_navigation_view_model.dart';
import '../../widgets/common/cached_image.dart';
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
        title: const Text(
          'What You Like To Post',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
      ),
      bottomSheet: post.isPoster != null
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  height: size.height * 0.09,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                    child: DeafultButton(
                      title: 'Continue',
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
        padding: const EdgeInsets.only(top: 80, left: 10, right: 10),
        // child: Column(
        //   children: [
        //     Container(
        //       height: 250,
        //       width: size.width,
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(12),
        //         color: Colors.grey.shade100,
        //         boxShadow: kElevationToShadow[4],
        //         //     categoryViewModel.categoryId == category.catId.toString()
        //         //         ? kElevationToShadow[2]
        //         //         : kElevationToShadow[8],
        //         // border:
        //         //     categoryViewModel.categoryId == category.catId.toString()
        //         //         ? Border.all(color: MyTheme.greenColor, width: 4)
        //         //         : null,
        //       ),
        //       child: Stack(
        //         children: [
        //           Stack(
        //             children: [
        //               CachedImageWidget(
        //                 height: size.height,
        //                 width: size.width,
        //                 radius: 8,
        //                 imgUrl:
        //                     'https://mydelivererblog.files.wordpress.com/2017/09/service.jpg',
        //               ),
        //               Container(
        //                 decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(8),
        //                   // gradient: LinearGradient(
        //                   //   begin: Alignment.topRight,
        //                   //   end: Alignment.bottomLeft,
        //                   //   stops: const [0.1, 0.9],
        //                   //   colors: [
        //                   //     // Colors.black.withOpacity(0.2),
        //                   //     // Colors.black.withOpacity(0.9),
        //                   //     MyTheme.greenColor.withOpacity(0.1),
        //                   //     MyTheme.greenColor.withOpacity(0.4),
        //                   //   ],
        //                   // ),
        //                 ),
        //               )
        //             ],
        //           ),
        //           Align(
        //             alignment: Alignment.bottomCenter,
        //             child: Container(
        //               height: 40,
        //               width: size.width,
        //               decoration: BoxDecoration(
        //                 color: Colors.grey.shade500.withOpacity(0.6),
        //                 borderRadius: const BorderRadius.only(
        //                   bottomLeft: Radius.circular(8),
        //                   bottomRight: Radius.circular(8),
        //                 ),
        //               ),
        //               child: const Center(
        //                 child: Text(
        //                   'Service',
        //                   style: TextStyle(
        //                     fontWeight: FontWeight.w500,
        //                     color: Colors.white,
        //                     letterSpacing: 0.2,
        //                     fontSize: 18,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ),
        //           // Positioned(
        //           //   top: 8,
        //           //   right: 8,
        //           //   child: Container(
        //           //     decoration: BoxDecoration(
        //           //       border: Border.all(color: Colors.white, width: 1.5),
        //           //       borderRadius: BorderRadius.circular(50),
        //           //     ),
        //           //     child: const Icon(
        //           //       CupertinoIcons.check_mark_circled_solid,
        //           //       color: Colors.white,
        //           //       size: 24,
        //           //     ),
        //           //   ),
        //           // )
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            selectType(
              size: size,
              mainAxisAlignment: MainAxisAlignment.start,
              serviceType: 'JOB',
              serviceImage: 'assets/images/worker.png',
              selectType: (post.isPoster != null && post.isPoster == true)
                  ? true
                  : false,
              onTap: () => post.selectServiceType(true),
            ),
            selectType(
              size: size,
              mainAxisAlignment: MainAxisAlignment.center,
              serviceType: 'SERVICE',
              serviceImage: 'assets/images/dollar.png',
              selectType: (post.isPoster != null && post.isPoster == false)
                  ? true
                  : false,
              onTap: () => post.selectServiceType(false),
            ),
          ],
        ),
      ),
    );
  }

  Widget selectType({
    required Size size,
    required MainAxisAlignment mainAxisAlignment,
    required String serviceType,
    required String serviceImage,
    required bool selectType,
    required Function onTap,
  }) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        GestureDetector(
          onTap: () => onTap(),
          child: Container(
            width: size.width * 0.45,
            height: size.height * 0.40,
            padding: const EdgeInsets.only(top: 6, bottom: 6),
            decoration: BoxDecoration(
              color: selectType ? MyTheme.greenColor : Colors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: kElevationToShadow[6],
              // border: Border.all(color: Colors.green),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                      child: Image.asset(
                        serviceImage,
                        fit: BoxFit.cover,
                        height: constraints.maxHeight * 0.80,
                        // width: constraints.maxWidth,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          serviceType,
                          style: TextStyle(
                            color: selectType ? Colors.white : Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
