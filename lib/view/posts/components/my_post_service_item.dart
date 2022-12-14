import 'package:bizhub_new/view/posts/components/post_complete.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/service_model.dart';
import '../../../utils/app_url.dart';
import '../../../utils/mytheme.dart';
import '../../../utils/utils.dart';
import '../../../view_model/my_service_view_model.dart';
import '../../../widgets/common/dialog_box.dart';
import '../my_services/my_service_detail.dart';
import 'bottom_modal_action.dart';

class MyPostServiceItem extends StatelessWidget {
  const MyPostServiceItem({
    Key? key,
    required this.serviceModel,
  }) : super(key: key);

  final ServiceModel serviceModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final phoneDevice = Utils.getDeviceType() == 'phone';

    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: 6, horizontal: phoneDevice ? 0 : 4),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MyWorkDetail(
                serviceId: serviceModel.serviceId.toString(),
              ),
            ),
          );
        },
        child: Container(
          width: size.width,
          height: size.height * 0.12,
          decoration: BoxDecoration(
            color: Colors.white,
            border: const Border(
              left: BorderSide(
                color: MyTheme.greenColor,
                width: 3,
              ),
            ),
            boxShadow: kElevationToShadow[1],
          ),
          child: LayoutBuilder(
            builder: (context, size) {
              return Column(
                children: [
                  Container(
                    width: size.maxWidth,
                    height: size.maxHeight,
                    padding: const EdgeInsets.only(
                      top: 8,
                      left: 8,
                      right: 8,
                      bottom: 8,
                    ),
                    // color: Colors.grey.shade200,
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 6.0),
                        //   child: SizedBox(
                        //     height: size.maxHeight,
                        //     width: phoneDevice
                        //         ? size.maxWidth * 0.18
                        //         : size.maxWidth * 0.08,
                        //     child: ClipRRect(
                        //       borderRadius: BorderRadius.circular(6),
                        //       child: serviceModel.imagesList!.isEmpty
                        //           ? Container(
                        //               color: Colors.grey.shade50,
                        //               child: Icon(
                        //                 Icons.photo_library,
                        //                 color: Colors.grey.shade400,
                        //                 size: 40,
                        //               ),
                        //             )
                        //           : CachedNetworkImage(
                        //               // height: constraints.maxHeight * 0.55,
                        //               // width: double.infinity,
                        //               fadeInDuration:
                        //                   const Duration(milliseconds: 300),
                        //               placeholder: (context, url) => const Icon(
                        //                 Icons.photo_library,
                        //                 color: MyTheme.greenColor,
                        //                 size: 30,
                        //               ),
                        //               imageUrl: AppUrl.baseUrl +
                        //                   serviceModel.imagesList![0].image
                        //                       .toString(),
                        //               fit: BoxFit.cover,
                        //             ),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: SizedBox(
                            height: size.maxHeight,
                            width: phoneDevice
                                ? size.maxWidth * 0.18
                                : size.maxWidth * 0.14,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: serviceModel.imagesList!.isEmpty
                                  ? Container(
                                      color: Colors.grey.shade50,
                                      child: Icon(
                                        Icons.photo_library,
                                        color: Colors.grey.shade400,
                                        size: 40,
                                      ),
                                    )
                                  : CachedNetworkImage(
                                      // height: constraints.maxHeight * 0.55,
                                      // width: double.infinity,
                                      fadeInDuration:
                                          const Duration(milliseconds: 300),
                                      placeholder: (context, url) => const Icon(
                                        Icons.photo_library,
                                        color: MyTheme.greenColor,
                                        size: 30,
                                      ),
                                      imageUrl: AppUrl.baseUrl +
                                          serviceModel.imagesList![0].image
                                              .toString(),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: phoneDevice
                              ? size.maxWidth * 0.74
                              : size.maxWidth * 0.80,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: SizedBox(
                                      width: size.maxWidth * 0.67,
                                      child: Text(
                                        serviceModel.serviceTitle.toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SafeArea(
                                            child: Container(
                                              // height: 200,
                                              width: size.maxWidth,
                                              color: Colors.white,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const SizedBox(height: 10),
                                                  BottomModalAction(
                                                    text: 'Delete',
                                                    color: Colors.red,
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            simpleDialog(
                                                          context: context,
                                                          title:
                                                              'Confirm Delete ?',
                                                          subTitle:
                                                              'Are you sure you want to delete service ?',
                                                          onPressed: () {
                                                            // Navigator.of(
                                                            //         context)
                                                            //     .pop();
                                                            context
                                                                .read<
                                                                    MyServiceViewModel>()
                                                                .deleteMyService(
                                                                  serviceId: serviceModel
                                                                      .serviceId
                                                                      .toString(),
                                                                  context:
                                                                      context,
                                                                );
                                                          },
                                                        ),
                                                      );
                                                      // if (myServices) {
                                                      //   showDialog(
                                                      //     context: context,
                                                      //     builder: (context) =>
                                                      //         simpleDialog(
                                                      //       context: context,
                                                      //       title:
                                                      //           'Confirm Delete ?',
                                                      //       subTitle:
                                                      //           'Are you sure you want to delete service ?',
                                                      //       onPressed: () {
                                                      //         // Navigator.of(
                                                      //         //         context)
                                                      //         //     .pop();
                                                      //         context
                                                      //             .read<
                                                      //                 MyServiceViewModel>()
                                                      //             .deleteMyService(
                                                      //               serviceId: serviceModel
                                                      //                   .serviceId
                                                      //                   .toString(),
                                                      //               context:
                                                      //                   context,
                                                      //             );
                                                      //       },
                                                      //     ),
                                                      //   );
                                                      // } else {
                                                      //   showDialog(
                                                      //     context: context,
                                                      //     builder: (context) =>
                                                      //         simpleDialog(
                                                      //       context: context,
                                                      //       title:
                                                      //           'Confirm Delete ?',
                                                      //       subTitle:
                                                      //           'Are you sure you want to delete job ?',
                                                      //       onPressed: () {
                                                      //         // Navigator.of(
                                                      //         //         context)
                                                      //         //     .pop();
                                                      //         context
                                                      //             .read<
                                                      //                 MyServiceViewModel>()
                                                      //             .deleteMyPost(
                                                      //               serviceId: serviceModel
                                                      //                   .serviceId
                                                      //                   .toString(),
                                                      //               context:
                                                      //                   context,
                                                      //             );
                                                      //       },
                                                      //     ),
                                                      //   );
                                                      // }
                                                    },
                                                  ),
                                                  if (serviceModel
                                                          .serviceStatus ==
                                                      '0')
                                                    BottomModalAction(
                                                      text: 'Mark as complete',
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              simpleDialog(
                                                            context: context,
                                                            title:
                                                                'Confirm Completed ?',
                                                            subTitle:
                                                                'Are you sure this job completed ?',
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (ctx) =>
                                                                      const PostComplete(),
                                                                  settings:
                                                                      RouteSettings(
                                                                    arguments: {
                                                                      'service_id':
                                                                          serviceModel
                                                                              .serviceId,
                                                                      'lead':
                                                                          false,
                                                                    },
                                                                  ),
                                                                ),
                                                              );
                                                              // Navigator.pushNamed(
                                                              //     context,
                                                              //     RouteName
                                                              //         .myJobComplete);
                                                              // if (myServices) {
                                                              //   Navigator.push(
                                                              //     context,
                                                              //     MaterialPageRoute(
                                                              //       builder:
                                                              //           (ctx) =>
                                                              //               const PostComplete(),
                                                              //       settings:
                                                              //           RouteSettings(
                                                              //         arguments: {
                                                              //           'service_id':
                                                              //               serviceModel.serviceId,
                                                              //           'lead':
                                                              //               false,
                                                              //         },
                                                              //       ),
                                                              //     ),
                                                              //   );
                                                              // } else {
                                                              //   Navigator.push(
                                                              //     context,
                                                              //     MaterialPageRoute(
                                                              //       builder:
                                                              //           (ctx) =>
                                                              //               const PostComplete(),
                                                              //       settings:
                                                              //           RouteSettings(
                                                              //         arguments: {
                                                              //           'service_id':
                                                              //               serviceModel.serviceId,
                                                              //           'lead':
                                                              //               true,
                                                              //         },
                                                              //       ),
                                                              //     ),
                                                              //   );
                                                              // }
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  BottomModalAction(
                                                    text: 'Cancel',
                                                    onTap: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                  ),
                                                  const SizedBox(height: 15),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: const Icon(
                                      CupertinoIcons.ellipsis_vertical,
                                      size: 18,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$ ${serviceModel.serviceAmount}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: phoneDevice ? 10 : 12,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: serviceModel.serviceStatus == '0'
                                          ? Colors.blue
                                          : Colors.green,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      serviceModel.serviceStatus == '0'
                                          ? 'Active'
                                          : 'Complete',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
