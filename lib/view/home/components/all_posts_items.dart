import 'package:flutter/material.dart';
import '../../../model/service_model.dart';
import '../../../utils/mytheme.dart';
import '../../../utils/routes/routes_name.dart';

class AllPostsItem extends StatelessWidget {
  const AllPostsItem({Key? key, required this.serviceModel}) : super(key: key);

  final ServiceModel serviceModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteName.postDetail);
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
                  child: Image.asset(
                    'assets/images/job2.jpg',
                    fit: BoxFit.cover,
                    height: constraints.maxHeight * 0.50,
                    width: double.infinity,
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
                    height: constraints.maxHeight * 0.50,
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
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$ ${serviceModel.serviceAmount}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Text(
                                    '30 JUN',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              )
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
