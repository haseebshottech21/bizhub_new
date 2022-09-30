import 'package:bizhub_new/model/service_model.dart';
import 'package:bizhub_new/utils/app_url.dart';
import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:bizhub_new/view_model/my_service_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/mytheme.dart';
import '../../../widgets/common/dialog_box.dart';
import '../poster/my_job_detail.dart';
import 'bottom_modal_action.dart';

class JobPostItem extends StatelessWidget {
  final ServiceModel myPosterService;
  const JobPostItem({
    required this.myPosterService,
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
        height: size.height * 0.12,
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
                              builder: (context) => MyJobDetail(
                                serviceId: myPosterService.serviceId.toString(),
                              ),
                              // settings: RouteSettings(
                              //   arguments: {
                              //     'id': myPosterService.serviceId,
                              //   },
                              // ),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: size.maxHeight * 0.76,
                          width: size.maxWidth * 0.18,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              AppUrl.baseUrl +
                                  myPosterService.imagesList![0].image
                                      .toString(),
                              fit: BoxFit.fitHeight,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: SizedBox(
                                    width: size.maxWidth * 0.65,
                                    child: Text(
                                      myPosterService.serviceTitle.toString(),
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
                                                    Navigator.of(context).pop();
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          simpleDialog(
                                                        context: context,
                                                        title:
                                                            'Confirm Delete ?',
                                                        subTitle:
                                                            'Are you sure to delete job!',
                                                        onPressed: () {
                                                          context
                                                              .read<
                                                                  MyServiceViewModel>()
                                                              .deleteMyPosterService(
                                                                serviceId:
                                                                    myPosterService
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
                                                BottomModalAction(
                                                  text: 'Mark as complete',
                                                  onTap: () {
                                                    Navigator.of(context).pop();
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
                                                          Navigator.of(context)
                                                              .pop();
                                                          Navigator.pushNamed(
                                                              context,
                                                              RouteName
                                                                  .myJobComplete);
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
                                  '\$ ${myPosterService.serviceAmount}',
                                  style: const TextStyle(
                                    fontSize: 17,
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