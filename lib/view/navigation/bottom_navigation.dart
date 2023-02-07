import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'package:bizhub_new/utils/icons.dart';
import 'package:bizhub_new/utils/mytheme.dart';
import 'package:bizhub_new/view/account/more.dart';
import 'package:bizhub_new/view/chat/my_chats.dart';
import 'package:bizhub_new/view/home/home_screen.dart';
import 'package:bizhub_new/view_model/bottom_navigation_view_model.dart';

import '../../view_model/chat_view_model.dart';
import '../auth/without_auth_screen.dart';
import '../posts/my_posts.dart';

class NavigatoionBarScreen extends StatefulWidget {
  const NavigatoionBarScreen({Key? key}) : super(key: key);

  @override
  State<NavigatoionBarScreen> createState() => _NavigatoionBarScreenState();
}

class _NavigatoionBarScreenState extends State<NavigatoionBarScreen> {
  PageController myPage = PageController(initialPage: 0);

  checkToken() async {
    final bottom = context.read<BottomNavigationViewModel>();
    final chatProvider = context.read<ChatViewModel>();
    chatProvider.onMessagesScreen = true;
    await bottom.checkToken();
  }

  @override
  void initState() {
    checkToken();

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   await setUpRequestNotification();
    // });
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   await setupInteracted();
    //   // await localNotifiaction.initialize();
    // });
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await setupInteracted();
    });
  }

  Future<void> setupInteracted() async {
    final chatProvider = Provider.of<ChatViewModel>(context, listen: false);
    final bottomProvider =
        Provider.of<BottomNavigationViewModel>(context, listen: false);
    await FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.onMessageOpenedApp.listen(
      (event) async {
        await chatProvider.getMyAllChatListSecond(context: context);
        myPage.jumpToPage(2);
        bottomProvider.toggleCurrentIndex(2);

        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => MyChats()));
      },
    );

    // FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    // FirebaseMessaging.onMessage.listen(
    //   (RemoteMessage message) async {
    //     if (message.data['screen_two'] == 'rec-message') {
    //       // getMyAllChatsListTwo();
    //       if (chatProvider.onMessagesScreen) {
    //         NotificationService().showNotificationWithSound(
    //           title: message.notification!.title.toString(),
    //           body: message.notification!.body.toString(),
    //         );
    //       }
    //       print('Data:  ${message.data}');
    //     }
    //   },
    // );
  }

  List<Widget> currentTab = const [
    HomeScreen(),
    MyPosts(),
    MyChats(),
    MoreScreen(),
  ];

  int initailPage = 0;

  // Future<void> setUpRequestNotification() async {
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;

  //   await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );
  // }

  // Future<void> setupInteracted() async {
  //   RemoteMessage? initialMessage =
  //       await FirebaseMessaging.instance.getInitialMessage();

  //   // FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  //   FirebaseMessaging.onMessage.listen(
  //     (RemoteMessage message) {
  //       // final serviceViewModel =
  //       //     Provider.of<ServiceViewModel>(context, listen: false);

  //       // if (message.data['screen'] == 'send-message') {
  //       //   getMyMessages();
  //       // }

  //       // Worker Module
  //       if (message.data['screen'] == 'send-message') {
  //         // Utils.snackBarMessage(message.notification!.body!, context);
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final bottomProvider =
        Provider.of<BottomNavigationViewModel>(context, listen: true);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(systemNavigationBarColor: Colors.white),
    );

    // print(bottomProvider.bottomIndex);

    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     TextButton(
      //       onPressed: () {
      //         myPage.jumpToPage(2);
      //         bottomProvider.toggleCurrentIndex(2);
      //       },
      //       child: Text('Go to chat'),
      //     )
      //   ],
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0,
        child: FloatingActionButton(
          elevation: 2.0,
          // label: const Text('Add a task'),
          onPressed: () {
            bottomProvider.cerateNewPost(context);
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
          // setState(() {
          //   initailPage = int;
          // });

          // print('Initial Page $initailPage');
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
                bottomNavigatorViewModel: bottomProvider,
                // token: bottomProvider.token,
              ),
              buildNavBarItem(
                context: context,
                icon: Icons.post_add,
                // activeIcon: Icons.post_add,
                index: 1,
                isActive: false,
                bottomNavigatorViewModel: bottomProvider,
                // token: bottomProvider.token,
              ),
              const SizedBox(width: 20),
              buildNavBarItem(
                context: context,
                icon: chat,
                // activeIcon: Icons.inbox,
                index: 2,
                isActive: false,
                bottomNavigatorViewModel: bottomProvider,
                // token: bottomProvider.token,
              ),
              buildNavBarItem(
                context: context,
                icon: profileOutline,
                // activeIcon: profileSolid,
                index: 3,
                isActive: false,
                bottomNavigatorViewModel: bottomProvider,
                // token: bottomProvider.token,
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
    // String? token,
  }) {
    return InkWell(
      onTap: bottomNavigatorViewModel.token == null ||
              bottomNavigatorViewModel.token == ''
          ? () {
              // print('null token');
              // if (token == null || token == '') {
              if (index == 1 || index == 2) {
                Timer(
                  Duration.zero,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const WithoutAuthScreen(),
                      settings: const RouteSettings(
                        arguments: true,
                      ),
                    ),
                  ),
                );
              } else if (bottomNavigatorViewModel.currentIndex == 0 ||
                  bottomNavigatorViewModel.currentIndex == 3) {
                myPage.jumpToPage(index);
                bottomNavigatorViewModel.toggleCurrentIndex(index);
              }
            }
          : () {
              // print('not null token');
              myPage.jumpToPage(index);
              bottomNavigatorViewModel.toggleCurrentIndex(index);
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
            onPressed: bottomNavigatorViewModel.token == null ||
                    bottomNavigatorViewModel.token == ''
                ? () {
                    if (index == 1 || index == 2) {
                      Timer(
                        Duration.zero,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => const WithoutAuthScreen(),
                            settings: const RouteSettings(
                              arguments: true,
                            ),
                          ),
                        ),
                      );
                    } else if (bottomNavigatorViewModel.currentIndex == 0 ||
                        bottomNavigatorViewModel.currentIndex == 3) {
                      myPage.jumpToPage(index);
                      bottomNavigatorViewModel.toggleCurrentIndex(index);
                    }
                  }
                : () {
                    // print('not null token');
                    // print(index);
                    myPage.jumpToPage(index);
                    bottomNavigatorViewModel.toggleCurrentIndex(index);
                  }),
      ),
    );
  }
}

// class BottomNavigation extends StatefulWidget {
//   const BottomNavigation({Key? key}) : super(key: key);

//   @override
//   State<BottomNavigation> createState() => _BottomNavigationState();
// }

// class _BottomNavigationState extends State<BottomNavigation> {
//   // int bottomSelectedIndex = 0;

//   List<Widget> buildBottomNavBarItems(BottomController bottomController) {
//     return [
//       BottomIcon(
//         padding: const EdgeInsets.all(0),
//         icon: Icons.home,
//         iconText: "Home",
//         index: 0,
//         bottomController: bottomController,
//       ),
//       BottomIcon(
//         padding: EdgeInsets.only(right: 30),
//         icon: Icons.mail,
//         iconText: "Mail",
//         index: 1,
//         bottomController: bottomController,
//       ),
//       BottomIcon(
//         padding: EdgeInsets.only(left: 30),
//         icon: Icons.map,
//         iconText: "Map",
//         index: 2,
//         bottomController: bottomController,
//       ),
//       BottomIcon(
//         padding: EdgeInsets.all(0),
//         icon: Icons.settings,
//         iconText: "Settings",
//         index: 3,
//         bottomController: bottomController,
//       ),
//     ];
//   }

//   // PageController pageController = PageController(
//   //   initialPage: 0,
//   //   keepPage: true,
//   // );

//   Widget buildPageView(BottomController bottomController) {
//     return PageView(
//       controller: bottomController.pageController,
//       onPageChanged: (index) {
//         bottomController.pageChanged(index);
//         // print(index);
//       },
//       children: const <Widget>[
//         HomeScreen(),
//         MyPosts(),
//         MyChats(),
//         MoreScreen(),
//       ],
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<BottomController>(context, listen: false);
//     return Scaffold(
//       body: buildPageView(provider),
//       // bottomNavigationBar: BottomNavigationBar(
//       //   currentIndex: provider.bottomSelectedIndex,
//       //   onTap: (index) {
//       //     provider.bottomTapped(index);
//       //   },
//       //   items: buildBottomNavBarItems(),
//       // ),
//       bottomNavigationBar: BottomAppBar(
//         color: Colors.grey,
//         elevation: 0,
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 5,
//         child: SizedBox(
//           height: 60,
//           child: Padding(
//             padding: const EdgeInsets.only(bottom: 5),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: buildBottomNavBarItems(provider),
//             ),
//           ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: Visibility(
//         visible: MediaQuery.of(context).viewInsets.bottom == 0,
//         child: FloatingActionButton(
//           elevation: 2.0,
//           // label: const Text('Add a task'),
//           onPressed: () {
//             // bottomProvider.cerateNewPost(context);
//           },
//           backgroundColor: MyTheme.greenColor,
//           child: const Icon(Icons.add, size: 30),
//         ),
//       ),
//     );
//   }
// }

// class BottomIcon extends StatelessWidget {
//   final String iconText;
//   final IconData icon;
//   final EdgeInsetsGeometry padding;
//   final int index;
//   final BottomController bottomController;
//   const BottomIcon({
//     required this.iconText,
//     required this.icon,
//     required this.padding,
//     required this.index,
//     required this.bottomController,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: padding,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           IconButton(
//             onPressed: () {
//               bottomController.bottomTapped(index);
//               bottomController.pageChanged(index);
//             },
//             padding: const EdgeInsets.all(0),
//             icon: Icon(
//               icon,
//               size: 30,
//               color: Colors.white,
//             ),
//           ),
//           // Text(
//           //   iconText,
//           //   style: const TextStyle(fontSize: 10, color: Colors.white),
//           // )
//         ],
//       ),
//     );
//   }
// }
