import 'package:bizhub_new/view/my_posts/jobs/jobs.dart';
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
    // final size = MediaQuery.of(context).size;

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
            const SliverFillRemaining(
              fillOverscroll: true,
              hasScrollBody: true,
              child: TabBarView(
                children: [
                  JobsPost(),
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
