import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/service_model.dart';
import '../../../utils/app_url.dart';
import '../../../utils/mytheme.dart';
import '../../../view_model/my_service_view_model.dart';
import '../../../widgets/common/dialog_box.dart';
import '../my_jobs/lead_complete.dart';
import '../my_jobs/my_job_detail.dart';
import '../my_services/my_work_detail.dart';
import 'bottom_modal_action.dart';

class MyPostItem extends StatelessWidget {
  const MyPostItem({
    Key? key,
    required this.serviceModel,
    this.myServices = false,
  }) : super(key: key);

  final ServiceModel serviceModel;
  final bool myServices;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: GestureDetector(
        onTap: () {
          if (myServices) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MyWorkDetail(
                  serviceId: serviceModel.serviceId.toString(),
                ),
              ),
            );
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MyJobDetail(
                  serviceId: serviceModel.serviceId.toString(),
                ),
              ),
            );
          }
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
                      top: 10,
                      left: 8,
                      right: 8,
                      bottom: 8,
                    ),
                    // color: Colors.grey.shade200,
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: SizedBox(
                            height: size.maxHeight,
                            width: size.maxWidth * 0.18,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: serviceModel.imagesList!.isEmpty
                                  ? Container(color: Colors.grey)
                                  : Image.network(
                                      AppUrl.baseUrl +
                                          serviceModel.imagesList![0].image
                                              .toString(),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.maxWidth * 0.74,
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
                                      width: size.maxWidth * 0.65,
                                      child: Text(
                                        serviceModel.serviceTitle.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
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
                                                              'Are you sure you want to delete job ?',
                                                          onPressed: () {
                                                            context
                                                                .read<
                                                                    MyServiceViewModel>()
                                                                .deleteMyLead(
                                                                  serviceId: serviceModel
                                                                      .serviceId
                                                                      .toString(),
                                                                  context:
                                                                      context,
                                                                );
                                                          },
                                                        ),
                                                      );
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
                                                              // Navigator.pushNamed(
                                                              //     context,
                                                              //     RouteName
                                                              //         .myJobComplete);
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (ctx) =>
                                                                      const LeadComplete(),
                                                                  settings:
                                                                      RouteSettings(
                                                                    arguments:
                                                                        serviceModel
                                                                            .serviceId,
                                                                  ),
                                                                ),
                                                              );
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
                                      size: 15,
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
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
