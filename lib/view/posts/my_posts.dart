import 'package:bizhub_new/view/posts/my_services/my_services.dart';
import 'package:flutter/material.dart';
import '../../language/language_constant.dart';
import '../../utils/mytheme.dart';
import 'my_jobs/my_jobs.dart';

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
              title: Text(
                translation(context).myPostTitle,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
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
                      translation(context).jobsTitle.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      translation(context).servicesTitle.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
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
                  ServicePost(),
                ],
                // controller: _tabController,
              ),
            )
          ],
        ),
      ),
    );
  }
}
