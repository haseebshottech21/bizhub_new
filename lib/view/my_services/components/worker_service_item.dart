import 'package:bizhub_new/view/my_services/components/bottom_modal_action.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/service_model.dart';
import '../../../utils/app_url.dart';
import '../../../utils/mytheme.dart';
import '../../../view_model/my_service_view_model.dart';
import '../../../widgets/common/dialog_box.dart';
import '../worker/my_work_detail.dart';
import '../worker/service_complete.dart';

class WorkerServiceItem extends StatelessWidget {
  final ServiceModel myWorkerService;
  const WorkerServiceItem({
    required this.myWorkerService,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // print(myPosterService.serviceId);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        width: size.width,
        height: size.height * 0.13,
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(5),
          //   bottomLeft: Radius.circular(5),
          // ),
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
                      GestureDetector(
                        onTap: () {
                          // Navigator.pushNamed(context, RouteName.myJobDetail);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MyWorkDetail(
                                serviceId: myWorkerService.serviceId.toString(),
                              ),
                              // settings: RouteSettings(
                              //   arguments: {
                              //     'id': myPosterService.serviceId,
                              //   },
                              // ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: SizedBox(
                            height: size.maxHeight * 0.76,
                            width: size.maxWidth * 0.18,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: myWorkerService.imagesList!.isEmpty
                                  ? Container(color: Colors.grey)
                                  : Image.network(
                                      AppUrl.baseUrl +
                                          myWorkerService.imagesList![0].image
                                              .toString(),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.maxWidth * 0.72,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: size.maxWidth * 0.65,
                                  child: Text(
                                      myWorkerService.serviceTitle.toString()),
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
                                                    Navigator.of(context).pop();
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
                                                              .deleteMyService(
                                                                serviceId:
                                                                    myWorkerService
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
                                                if (myWorkerService
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
                                                              'Are you sure your job complete!',
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
                                                                    const ServiceComplete(),
                                                                settings:
                                                                    RouteSettings(
                                                                  arguments:
                                                                      myWorkerService
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$ ${myWorkerService.serviceAmount}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Text(
                                    'Active',
                                    style: TextStyle(color: Colors.white),
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
    );
  }
}
