import 'package:bizhub_new/components/deafult_button.dart';
import 'package:bizhub_new/utils/mytheme.dart';
import 'package:bizhub_new/view_model/my_service_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/routes/routes_name.dart';
import '../../view_model/bottom_navigation_view_model.dart';
// import '../../widgets/common/cached_image.dart';
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
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // serviceItem(context),
            // serviceItem(context),
            ServiceTypeItem(
              serviceTypeText: 'JOB',
              serviceTypeImage:
                  'https://media.istockphoto.com/photos/businessman-sitting-at-his-desk-and-using-laptop-in-the-office-picture-id1152447561?k=20&m=1152447561&s=170667a&w=0&h=v6FL8PdUu3b_fruvKtZJ6bETLkNMXYJ3J6bmfsqfurI=',
              // selectType: true,
              // onTap: (){},
              selectType: (post.isPoster != null && post.isPoster == true)
                  ? true
                  : false,
              onTap: () => post.selectServiceType(true),
            ),
            ServiceTypeItem(
              serviceTypeText: 'SERVICE',
              serviceTypeImage:
                  'https://as1.ftcdn.net/v2/jpg/01/92/07/76/1000_F_192077668_hLewzaqBcb2RVB0iiHmjYjnbZAUGJgOq.jpg',
              selectType: (post.isPoster != null && post.isPoster == false)
                  ? true
                  : false,
              onTap: () => post.selectServiceType(false),
            )
          ],
        ),
        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     selectType(
        //       size: size,
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       serviceType: 'JOB',
        //       serviceImage: 'assets/images/worker.png',
        //       selectType: (post.isPoster != null && post.isPoster == true)
        //           ? true
        //           : false,
        //       onTap: () => post.selectServiceType(true),
        //     ),
        //     selectType(
        //       size: size,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       serviceType: 'SERVICE',
        //       serviceImage: 'assets/images/dollar.png',
        //       selectType: (post.isPoster != null && post.isPoster == false)
        //           ? true
        //           : false,
        //       onTap: () => post.selectServiceType(false),
        //     ),
        //   ],
        // ),
      ),
    );
  }

  // Widget serviceItem(BuildContext context) {
  //   final size = MediaQuery.of(context).size;

  //   return SizedBox(
  //     height: size.height * 0.32,
  //     width: size.width * 0.46,
  //     child: Stack(
  //       children: [
  //         Center(
  //           child: Container(
  //             height: size.height,
  //             width: size.width * 0.42,
  //             alignment: Alignment.bottomCenter,
  //             padding: const EdgeInsets.symmetric(vertical: 8),
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               boxShadow: kElevationToShadow[6],
  //               borderRadius: const BorderRadius.only(
  //                 bottomLeft: Radius.circular(4),
  //                 bottomRight: Radius.circular(4),
  //               ),
  //             ),
  //             child: const Text(
  //               'SERVICE',
  //               style: TextStyle(
  //                 // color: selectType ? Colors.white : Colors.black,
  //                 fontSize: 24,
  //                 fontWeight: FontWeight.w500,
  //                 letterSpacing: 1.0,
  //               ),
  //             ),
  //           ),
  //         ),
  //         Positioned(
  //           top: 0,
  //           left: 0,
  //           right: 0,
  //           child: Container(
  //             height: size.height * 0.26,
  //             // width: size.width,
  //             decoration: BoxDecoration(
  //               boxShadow: kElevationToShadow[8],
  //               // borderRadius: BorderRadius.circular(4),
  //             ),
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(6),
  //               child: Image.network(
  //                 'https://thumbs.dreamstime.com/b/image-confident-businessman-working-office-looking-computer-s-wearing-suit-142697534.jpg',
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget selectType({
  //   required Size size,
  //   required MainAxisAlignment mainAxisAlignment,
  //   required String serviceType,
  //   required String serviceImage,
  //   required bool selectType,
  //   required Function onTap,
  // }) {
  //   return Column(
  //     mainAxisAlignment: mainAxisAlignment,
  //     children: [
  //       GestureDetector(
  //         onTap: () => onTap(),
  //         child: Container(
  //           width: size.width * 0.45,
  //           height: size.height * 0.40,
  //           padding: const EdgeInsets.only(top: 6, bottom: 6),
  //           decoration: BoxDecoration(
  //             color: selectType ? MyTheme.greenColor : Colors.white,
  //             borderRadius: BorderRadius.circular(6),
  //             boxShadow: kElevationToShadow[6],
  //             // border: Border.all(color: Colors.green),
  //           ),
  //           child: LayoutBuilder(
  //             builder: (context, constraints) {
  //               return Column(
  //                 children: [
  //                   ClipRRect(
  //                     borderRadius: const BorderRadius.only(
  //                       topLeft: Radius.circular(6),
  //                       topRight: Radius.circular(6),
  //                     ),
  //                     child: Image.asset(
  //                       serviceImage,
  //                       fit: BoxFit.cover,
  //                       height: constraints.maxHeight * 0.80,
  //                       // width: constraints.maxWidth,
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Center(
  //                       child: Text(
  //                         serviceType,
  //                         style: TextStyle(
  //                           color: selectType ? Colors.white : Colors.black,
  //                           fontSize: 22,
  //                           fontWeight: FontWeight.w500,
  //                           letterSpacing: 1.0,
  //                         ),
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               );
  //             },
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
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
        width: size.width * 0.46,
        child: Stack(
          children: [
            Center(
              child: Container(
                height: size.height,
                width: size.width * 0.42,
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
                    // width: size.width,
                    decoration: BoxDecoration(
                      // boxShadow: kElevationToShadow[8],
                      boxShadow: selectType
                          ? kElevationToShadow[8]
                          : kElevationToShadow[4],
                      // borderRadius: BorderRadius.circular(4),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(
                        serviceTypeImage,
                        fit: BoxFit.cover,
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
