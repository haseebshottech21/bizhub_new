import 'package:bizhub_new/utils/app_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../model/service_model.dart';
import '../../../utils/mytheme.dart';
import '../all_service_detail_screen.dart';

class AllServiceIem extends StatelessWidget {
  const AllServiceIem({Key? key, required this.serviceModel}) : super(key: key);

  final ServiceModel serviceModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => PostJobDetail(
        //       serviceId: serviceModel.serviceId.toString(),
        //     ),
        //   ),
        // );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => const AllServiceDetail(),
            settings: RouteSettings(
              arguments: serviceModel,
            ),
          ),
        );
      },
      child: Container(
        // color: Colors.black,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          // boxShadow: kElevationToShadow[2],
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
                  child: serviceModel.imagesList!.isEmpty
                      ? Container(
                          height: constraints.maxHeight * 0.55,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          color: Colors.black,
                          child: Image.asset(
                            'assets/images/bizhub_logo.png',
                            fit: BoxFit.contain,
                          ),
                        )
                      : CachedNetworkImage(
                          height: constraints.maxHeight * 0.55,
                          width: double.infinity,
                          fadeInDuration: const Duration(milliseconds: 300),
                          placeholder: (context, url) => Container(
                            // height: constraints.maxHeight * 0.55,
                            // width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            color: Colors.white,
                            child: Image.asset(
                              'assets/images/bizhub3.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          // errorWidget: (context, url, error) => Container(
                          //   color: Colors.black12,
                          //   child: Icon(
                          //     profileIcon,
                          //     color: Colors.white,
                          //   ),
                          // ),
                          imageUrl: AppUrl.baseUrl +
                              serviceModel.imagesList![0].image.toString(),
                          fit: BoxFit.cover,
                        ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                  // child: Container(
                  //   height: constraints.maxHeight * 0.40,
                  //   width: constraints.minWidth,
                  //   color: Colors.yellow,
                  // ),
                  child: SizedBox(
                    height: constraints.maxHeight * 0.45,
                    width: constraints.minWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: constraints.maxHeight,
                          width: constraints.minWidth * 0.03,
                          color: MyTheme.greenColor,
                        ),
                        Container(
                          height: constraints.maxHeight,
                          width: constraints.minWidth * 0.92,
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 5,
                            top: 5,
                            bottom: 5,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                serviceModel.serviceTitle.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              Text(
                                '\$ ${serviceModel.serviceAmount}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
