import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../utils/mytheme.dart';

class JobsPost extends StatelessWidget {
  const JobsPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return jobItem();

    // return ListView.separated(
    //   padding: const EdgeInsets.all(12.0),
    //   itemCount: 8,
    //   itemBuilder: (context, index) {
    //     return const NewCardSkelton();
    //   },
    //   separatorBuilder: (context, index) {
    //     return const SizedBox(height: 16);
    //   },
    // );

    return ListView.builder(
      shrinkWrap: true,
      // physics: const ClampingScrollPhysics(),
      primary: false,
      padding: const EdgeInsets.all(8.0),
      itemCount: 5,
      itemBuilder: (context, index) {
        return const JobPostItem();
      },
    );
  }
}

class NewCardSkelton extends StatelessWidget {
  const NewCardSkelton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Skelton(
          height: 80,
          width: 80,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Skelton(),
              const SizedBox(height: 8),
              const Skelton(width: 160),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Skelton(width: 50),
                  Skelton(width: 80, height: 30),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class Skelton extends StatelessWidget {
  final double? height, width;
  const Skelton({
    this.height,
    this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class JobPostItem extends StatelessWidget {
  const JobPostItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        width: size.width,
        height: size.height * 0.16,
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
                  height: size.maxHeight * 0.15,
                  padding: const EdgeInsets.all(6.0),
                  // color: Colors.grey,
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    // splashColor: Colors.transparent,
                    onTap: () {},
                    child: const Icon(
                      CupertinoIcons.ellipsis_vertical,
                      size: 15,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.myJobDetail);
                  },
                  child: Container(
                    width: size.maxWidth,
                    height: size.maxHeight * 0.80,
                    padding: const EdgeInsets.all(8.0),
                    // color: Colors.grey.shade200,
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: size.maxHeight * 0.60,
                          width: size.maxWidth * 0.20,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.asset(
                              'assets/images/job2.jpg',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.maxWidth * 0.72,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'I will create your bussiness webiste with new features',
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    '\$ 50',
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20),
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
                        )
                      ],
                    ),
                  ),
                ),
                // Container(
                //   width: size.maxWidth,
                //   height: size.maxHeight * 0.25,
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 12,
                //   ),
                //   alignment: Alignment.topRight,
                //   child: Container(
                //     padding: const EdgeInsets.symmetric(
                //       horizontal: 12,
                //       vertical: 4,
                //     ),
                //     decoration: BoxDecoration(
                //       color: Colors.green,
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //     child: const Text('Active'),
                //   ),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
