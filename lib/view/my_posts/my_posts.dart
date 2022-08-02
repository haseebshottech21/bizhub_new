import 'package:bizhub_new/view/my_posts/jobs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/mytheme.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({Key? key}) : super(key: key);

  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // late TabController _tabController;
    final size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: CustomScrollView(
          // controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: <Widget>[
            SliverAppBar(
              floating: false,
              elevation: 10,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              pinned: true,
              centerTitle: true,
              title: const Text(
                "My Orders",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              bottom: TabBar(
                // controller: _tabController,
                indicatorColor: MyTheme.greenColor,
                indicatorWeight: 5,
                splashBorderRadius: BorderRadius.circular(5),
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 4.0,
                    color: MyTheme.greenColor,
                  ),
                  insets: EdgeInsets.symmetric(horizontal: 30.0),
                ),
                tabs: [
                  Tab(
                    child: Text(
                      'Jobs'.toUpperCase(),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Services'.toUpperCase(),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            // CupertinoSliverRefreshControl(
            //   onRefresh: () {
            //     if (_tabController.index == 0) {
            //       print('Refresh on going.');
            //     } else {
            //       print('Refresh completed.');
            //     }
            //     return Future.delayed(Duration(seconds: 2));
            //   },
            // ),
            SliverFillRemaining(
              fillOverscroll: true,
              hasScrollBody: true,
              child: TabBarView(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    // physics: const ClampingScrollPhysics(),
                    primary: false,
                    padding: const EdgeInsets.all(8.0),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Container(
                          width: size.width,
                          height: size.height * 0.22,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: const Border(
                              left: BorderSide(
                                color: MyTheme.greenColor,
                                width: 3,
                              ),
                            ),
                            boxShadow: kElevationToShadow[2],
                          ),
                          child: LayoutBuilder(
                            builder: (context, size) {
                              return Column(
                                children: [
                                  Container(
                                    width: size.maxWidth,
                                    height: size.maxHeight * 0.20,
                                    padding: const EdgeInsets.all(6.0),
                                    // color: Colors.grey,
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      // splashColor: Colors.transparent,
                                      onTap: () {},
                                      child: const Icon(
                                        CupertinoIcons.ellipsis_vertical,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: size.maxWidth,
                                    height: size.maxHeight * 0.55,
                                    padding: const EdgeInsets.all(6.0),
                                    // color: Colors.grey.shade200,
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: size.maxHeight,
                                          width: size.maxWidth * 0.20,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            child: Image.asset(
                                              'assets/images/job2.jpg',
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.maxWidth * 0.75,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const [
                                              Text(
                                                'I will create your bussiness webiste with new features',
                                              ),
                                              Spacer(),
                                              Text(
                                                '\$ 50',
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: size.maxWidth,
                                    height: size.maxHeight * 0.25,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text('Active'),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    },
                    // separatorBuilder: (c, i) => const Divider(
                    //   color: Colors.grey,
                    // ),
                    itemCount: 20,
                  ),
                  Text('SERVICE'),
                ],
                // controller: _tabController,
              ),
            )
          ],
        ),
      ),
    );

    // return DefaultTabController(
    //   length: 2,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       backgroundColor: Colors.white,
    //       automaticallyImplyLeading: false,
    //       elevation: 2,
    //       bottom: TabBar(
    //         indicatorColor: MyTheme.greenColor,
    //         indicatorWeight: 5,
    //         splashBorderRadius: BorderRadius.circular(5),
    //         indicator: const UnderlineTabIndicator(
    //           borderSide: BorderSide(
    //             width: 4.0,
    //             color: MyTheme.greenColor,
    //           ),
    //           insets: EdgeInsets.symmetric(horizontal: 30.0),
    //         ),
    //         tabs: [
    //           Tab(
    //             child: Text(
    //               'Jobs'.toUpperCase(),
    //               style: const TextStyle(color: Colors.black),
    //             ),
    //           ),
    //           Tab(
    //             child: Text(
    //               'Services'.toUpperCase(),
    //               style: const TextStyle(color: Colors.black),
    //             ),
    //           ),
    //         ],
    //       ),
    //       title: const Text('POSTS', style: TextStyle(color: Colors.black)),
    //     ),
    //     body: TabBarView(
    //       children: [
    //         SizedBox(
    //           height: size.height * 0.70,
    //           width: size.width,
    //           child: ListView(
    //             children: [
    //               LayoutBuilder(
    //                 builder: (context, constraints) {
    //                   return Container(
    //                     width: constraints.maxWidth,
    //                     height: constraints.maxHeight * 0.20,
    //                     // color: Colors.grey,
    //                     decoration: const BoxDecoration(
    //                       border: Border(
    //                         left: BorderSide(
    //                           color: Colors.black,
    //                           width: 4,
    //                         ),
    //                       ),
    //                     ),
    //                   );
    //                 },
    //               ),
    //             ],
    //           ),
    //         ),
    //         Text('SERVICE'),
    //       ],
    //     ),
    //   ),
    // );
  }
}
