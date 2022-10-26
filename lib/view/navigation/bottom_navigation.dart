import 'package:animate_do/animate_do.dart';
import 'package:bizhub_new/utils/icons.dart';
import 'package:bizhub_new/utils/mytheme.dart';
import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:bizhub_new/view/account/more.dart';
import 'package:bizhub_new/view/chat/my_chats/my_chats.dart';
import 'package:bizhub_new/view/home/home_screen.dart';
import 'package:bizhub_new/view_model/bottom_navigation_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../posts/my_posts.dart';

class NavigatoionBarScreen extends StatefulWidget {
  const NavigatoionBarScreen({Key? key}) : super(key: key);

  @override
  State<NavigatoionBarScreen> createState() => _NavigatoionBarScreenState();
}

class _NavigatoionBarScreenState extends State<NavigatoionBarScreen> {
  PageController myPage = PageController(initialPage: 0);

  var currentTab = const [
    HomeScreen(),
    MyPosts(),
    MyChats(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var provider =
        Provider.of<BottomNavigationViewModel>(context, listen: true);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(systemNavigationBarColor: Colors.white),
    );

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0,
        child: FloatingActionButton(
          elevation: 2.0,
          // label: const Text('Add a task'),
          onPressed: () {
            Navigator.pushNamed(context, RouteName.selectService);
          },
          backgroundColor: MyTheme.greenColor,
          child: const Icon(Icons.add, size: 30),
        ),
      ),
      // body: currentTab[provider.currentIndex],
      body: PageView(
        controller: myPage,
        onPageChanged: (int int) {
          // print('Page Changes to index $int');
        },
        physics:
            const NeverScrollableScrollPhysics(), // Comment this if you need to use Swipe.
        children: currentTab,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon(Icons.home),
              // Icon(Icons.person),
              // Icon(Icons.settings),
              buildNavBarItem(
                context: context,
                icon: dashboadOutline,
                // activeIcon: dashboadSolid,
                index: 0,
                isActive: true,
                bottomNavigatorViewModel: provider,
              ),
              buildNavBarItem(
                context: context,
                icon: Icons.post_add,
                // activeIcon: Icons.post_add,
                index: 1,
                isActive: false,
                bottomNavigatorViewModel: provider,
              ),
              const SizedBox(width: 20),
              buildNavBarItem(
                context: context,
                icon: chat,
                // activeIcon: Icons.inbox,
                index: 2,
                isActive: false,
                bottomNavigatorViewModel: provider,
              ),
              buildNavBarItem(
                context: context,
                icon: profileOutline,
                // activeIcon: profileSolid,
                index: 3,
                isActive: false,
                bottomNavigatorViewModel: provider,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavBarItem({
    required IconData icon,
    // required IconData activeIcon,
    required int index,
    required bool isActive,
    required BottomNavigationViewModel bottomNavigatorViewModel,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: () {
        // setState(() {
        //   currentIndex = index;
        // });
        bottomNavigatorViewModel.toggleCurrentIndex(index);
        myPage.jumpToPage(index);
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.13,
        decoration: BoxDecoration(
          border: index == bottomNavigatorViewModel.currentIndex
              ? const Border(
                  top: BorderSide(
                    width: 3.0,
                    color: MyTheme.greenColor,
                  ),
                )
              : null,
        ),
        child: IconButton(
          icon: FadeInDown(
            from: index == bottomNavigatorViewModel.currentIndex ? 5 : 0,
            duration: const Duration(milliseconds: 500),
            child: Icon(
              icon,
              color: index == bottomNavigatorViewModel.currentIndex
                  ? MyTheme.greenColor
                  : Colors.grey,
              size: index == bottomNavigatorViewModel.currentIndex ? 30 : 28,
            ),
          ),
          onPressed: () {
            bottomNavigatorViewModel.toggleCurrentIndex(index);
            myPage.jumpToPage(index);
          },
        ),
      ),
    );
  }
}
