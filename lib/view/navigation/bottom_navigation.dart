import 'package:animate_do/animate_do.dart';
import 'package:bizhub_new/utils/icons.dart';
import 'package:bizhub_new/utils/mytheme.dart';
import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:bizhub_new/view/account/more.dart';
import 'package:bizhub_new/view/chat/my_chats.dart';
import 'package:bizhub_new/view/home/home_screen.dart';
import 'package:bizhub_new/view_model/bottom_navigation_view_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../utils/utils.dart';
// import '../../view_model/chat_view_model.dart';
// import '../chat/my_chats/my_messages.dart';
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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await setupInteracted();
      await setUpRequestNotification();
    });
    super.initState();
  }

  Future<void> setUpRequestNotification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future<void> setupInteracted() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        // final serviceViewModel =
        //     Provider.of<ServiceViewModel>(context, listen: false);

        // if (message.data['screen'] == 'send-message') {
        //   getMyMessages();
        // }

        // Worker Module
        if (message.data['screen'] == 'send-message') {
          // Utils.snackBarMessage(message.notification!.body!, context);
        }

        // if (message.data['screen'] == workerAcceptOfferdKey) {
        //   Utilities().showSnackBar(message.notification!.body!, context, () {
        //     Navigator.of(context).pushNamed(
        //       MyHiredWorkerDetail.routeName,
        //       arguments: {
        //         'service_id': message.data['id'],
        //         'application_id': message.data['application_id']
        //       },
        //     );
        //   });
        // }

        // if (message.data['screen'] == workerDeclineOfferdKey) {
        //   Utilities().showSnackBar(message.notification!.body!, context, () {
        //     Navigator.of(context).pushNamed(
        //       MyHiredWorkerDetail.routeName,
        //       arguments: {
        //         'service_id': message.data['id'],
        //         'application_id': message.data['application_id']
        //       },
        //     );
        //   });
        // }

        // if (message.data['screen'] == workerConfirmHiredKey) {
        //   Utilities().showSnackBar(message.notification!.body!, context, () {
        //     Navigator.of(context).pushNamed(
        //       MyWorksDetail.routeName,
        //       arguments: message.data['id'],
        //     );
        //   });
        // }

        // if (message.data['screen'] == userCommentKey) {
        //   // Fluttertoast.showToast(msg: message);
        //   Utilities().showSnackBar(message.notification!.body!, context, () {
        //     Navigator.of(context).pushNamed(
        //       MyWorksDetail.routeName,
        //       arguments: message.data['id'],
        //     );
        //   });
        // }

        // if (message.data['screen'] == workerReplyKey) {
        //   // Fluttertoast.showToast(msg: message);

        //   Utilities().showSnackBar(message.notification!.body!, context, () {
        //     Navigator.of(context).pushNamed(
        //       MyHiredWorkerDetail.routeName,
        //       arguments: {
        //         'service_id': message.data['id'],
        //         'application_id': message.data['application_id']
        //       },
        //     );
        //   });
        // }

        // if (message.data['screen'] == serviceCompleteKey) {
        //   // clearLists();

        //   // print(message.data['user_id']);
        //   // Fluttertoast.showToast(msg: message);
        //   Utilities().showSnackBar(message.notification!.body!, context, () {
        //     Navigator.of(context).pushNamed(
        //       MyWorksDetail.routeName,
        //       arguments: message.data['id'],
        //     );
        //   });
        // }

        // if (message.data['screen'] == serviceCancelKey) {
        //   // clearLists();

        //   // print(message.data['user_id']);
        //   // Fluttertoast.showToast(msg: message);
        //   Utilities().showSnackBar(message.notification!.body!, context, () {
        //     Navigator.of(context).pushNamed(
        //       MyWorksDetail.routeName,
        //       arguments: message.data['id'],
        //     );
        //   });
        // }

        // // Job Poster Module
        // if (message.data['screen'] == commentReplyKey) {
        //   // Fluttertoast.showToast(msg: message);

        //   Utilities().showSnackBar(message.notification!.body!, context, () {
        //     // Navigator.of(context).pushNamed(
        //     //   MyServicesDetail.routeName,
        //     //   arguments: {
        //     //     'service_id': message.data['id'],
        //     //     'application_id': message.data['application_id']
        //     //   },
        //     // );
        //   });
        // }

        // if (message.data['screen'] == commentReplyKey) {
        //   // if (!MyServicesDetail.inServiceScreen) {
        //   // Fluttertoast.showToast(msg: message);
        //   Utilities().showSnackBar(message.notification!.body!, context, () {
        //     // MyServicesDetail.inServiceScreen = true;
        //     // serviceViewModel.serviceTabIndex = 0;
        //     // Navigator.of(context)
        //     //     .pushNamed(MyServicesDetail.routeName,
        //     //         arguments: message.data['id'])
        //     //     .then((value) {
        //     //   MyServicesDetail.inServiceScreen = false;
        //     //   serviceViewModel.serviceTabIndex = 0;
        //     // });
        //     Utilities().showSnackBar(
        //       message.notification!.body!,
        //       context,
        //       () {
        //         MyServicesDetail.inServiceScreen = true;
        //         Navigator.of(context).pushNamed(
        //           MyServicesDetail.routeName,
        //           arguments: {
        //             'service_id': message.data['id'],
        //             'application_id': message.data['application_id']
        //           },
        //         ).then(
        //           (value) {
        //             MyServicesDetail.inServiceScreen = false;
        //           },
        //         );
        //       },
        //     );
        //   });
        //   // }
        // }

        // if (message.data['screen'] == commentKey) {
        //   // Fluttertoast.showToast(msg: message);
        //   if (!MyJobDetail.inMyPostScreen) {
        //     Utilities().showSnackBar(
        //       message.notification!.body!,
        //       context,
        //       () {
        //         serviceViewModel.serviceTabIndex = 1;
        //         MyJobDetail.inMyPostScreen = true;
        //         Navigator.of(context)
        //             .pushNamed(MyJobDetail.routeName,
        //                 arguments: message.data['id'])
        //             .then((value) {
        //           MyJobDetail.inMyPostScreen = false;
        //           serviceViewModel.serviceTabIndex = 0;
        //         });
        //       },
        //     );
        //   }
        // }
        // if (message.data['screen'] == jobApplyOfferKey) {
        //   // clearLists();

        //   Utilities().showSnackBar(message.notification!.body!, context, () {
        //     MyJobDetail.inMyPostScreen = true;
        //     Navigator.of(context)
        //         .pushNamed(MyJobDetail.routeName, arguments: message.data['id'])
        //         .then((value) {
        //       MyJobDetail.inMyPostScreen = false;
        //     });
        //   });
        // }
        // if (message.data['screen'] == jobAcceptedKey) {
        //   // Fluttertoast.showToast(msg: 'Job accept you hired');
        //   // clearLists();
        //   Utilities().showSnackBar(
        //     message.notification!.body!,
        //     context,
        //     () {
        //       MyServicesDetail.inServiceScreen = true;
        //       Navigator.of(context).pushNamed(
        //         MyServicesDetail.routeName,
        //         arguments: {
        //           'service_id': message.data['id'],
        //           'application_id': message.data['application_id']
        //         },
        //       ).then(
        //         (value) {
        //           MyServicesDetail.inServiceScreen = false;
        //         },
        //       );
        //     },
        //   );
        // }
        // if (message.data['screen'] == jobCancelKey) {
        //   // Fluttertoast.showToast(msg: message);

        //   // clearLists();
        //   Utilities().showSnackBar(
        //     message.notification!.body!,
        //     context,
        //     () {
        //       MyServicesDetail.inServiceScreen = true;
        //       Navigator.of(context).pushNamed(
        //         MyServicesDetail.routeName,
        //         arguments: {
        //           'service_id': message.data['id'],
        //           'application_id': message.data['application_id']
        //         },
        //       ).then(
        //         (value) {
        //           MyServicesDetail.inServiceScreen = false;
        //         },
        //       );
        //     },
        //   );
        // }
        // if (message.data['screen'] == jobCompletedKey) {
        //   // clearLists();

        //   // print(message.data['user_id']);
        //   // Fluttertoast.showToast(msg: message);
        //   Utilities().showSnackBar(
        //     message.notification!.body!,
        //     context,
        //     () {
        //       // Navigator.of(context).pushNamed(MyServicesDetail.routeName,
        //       //     arguments: message.data['id']);
        //     },
        //   );
        //   rateReviewDialog(
        //     applicationId: message.data['id'],
        //     serviceId: '',
        //     status: '1',
        //     userId: message.data['user_id'],
        //     context: context,
        //     userName: message.data['user_name'],
        //     isPoster: true,
        //   );
        // }
      },
    );
  }

  // void _handleMessage(RemoteMessage message) {
  //   // Fluttertoast.showToast(msg: message.data.toString());
  //   if (message.data['screen'] == commentKey ||
  //       message.data['screen'] == jobApplyOfferKey) {
  //     // Fluttertoast.showToast(msg: message);
  //     Navigator.of(context)
  //         .pushNamed(MyJobDetail.routeName, arguments: message.data['id']);
  //   }
  //   if (message.data['screen'] == commentReplyKey ||
  //       message.data['screen'] == jobRejectKey ||
  //       message.data['screen'] == jobAcceptedKey ||
  //       message.data['screen'] == jobCancelKey ||
  //       message.data['screen'] == jobCompletedKey) {
  //     // if (message.data['screen'] == jobCompletedKey) {
  //     //   rateReviewDialog(
  //     //     applicationId: message.data['id'],
  //     //     serviceId: '',
  //     //     status: '1',
  //     //     userId: message.data['user_id'],
  //     //     context: context,
  //     //     userName: message.data['user_name'],
  //     //     isPoster: true,
  //     //   );
  //     // }
  //     // Fluttertoast.showToast(msg: message);
  //     Navigator.of(context).pushNamed(
  //       MyServicesDetail.routeName,
  //       arguments: message.data['id'],
  //     );
  //   }
  // }

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
