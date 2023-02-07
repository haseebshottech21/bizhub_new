import 'package:bizhub_new/components/custom_loader.dart';
import 'package:bizhub_new/components/no_internet.dart';
import 'package:bizhub_new/utils/mytheme.dart';
import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:bizhub_new/view/home/components/all_services_items.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/local_notification.dart';
// import '../../utils/local_notification.dart';
import '../../utils/utils.dart';
import '../../view_model/all_services_view_model.dart';
import '../../view_model/bottom_navigation_view_model.dart';
import '../auth/without_auth_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String? notifyToken;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final phoneDevice = Utils.getDeviceType() == 'phone';

  // void getToken() async {
  //   await FirebaseMessaging.instance.getToken().then((token) {
  //     MyApp.notifyToken = token.toString();
  //     // print('token: $token');
  //   });
  //   print('app_token: ${MyApp.notifyToken}');
  // }

  storeNotificationToken() async {
    await FirebaseMessaging.instance.getToken().then((value) {
      setState(() {
        HomeScreen.notifyToken = value.toString();
        print('app_token: ${HomeScreen.notifyToken}');
      });
    });
  }

  // Future<void> setUpRequestNotification() async {
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;
  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );

  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     print('User granted permission');
  //   } else if (settings.authorizationStatus ==
  //       AuthorizationStatus.provisional) {
  //     print('User granted provisional permission');
  //   } else {
  //     print('User declined or has not accept permission');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // LocalNotificationService.requestPermissions();
    NotificationService().initNotification();
    // setUpRequestNotification();
    // await LocalNotifiaction().requestPermissions();
    // Provider.of<AuthViewModel>(context, listen: false).setPrefrenceValues();

    // FirebaseMessaging.onMessage.listen((event) {
    //   print('FCM received message');
    //   LocalNotificationService.display(event);
    // });
    storeNotificationToken();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkAuthServices();
      final provider =
          Provider.of<AllServicesViewModel>(context, listen: false);

      provider.page = 1;
      provider.hasNextPage = true;

      provider.controller = ScrollController()
        ..addListener(provider.getAllServiceMore);
    });
  }

  Future<void> checkAuthServices() async {
    await Provider.of<AllServicesViewModel>(context, listen: false)
        .checkAuth(context);
  }

  Future<void> refresh() async {
    await Provider.of<AllServicesViewModel>(context, listen: false)
        .refresh(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<AllServicesViewModel>(context);
    final bottomProvider = Provider.of<BottomNavigationViewModel>(context);

    return OrientationBuilder(
      builder: (context, orientation) {
        // final isPortrait = orientation == Orientation.portrait;
        return Scaffold(
          backgroundColor: Colors.grey[50],
          // resizeToAvoidBottomInset: true,,
          body: RefreshIndicator(
            onRefresh: refresh,
            child: CustomScrollView(
              controller: provider.controller,
              slivers: [
                SliverAppBar(
                  floating: false,
                  pinned: true,
                  snap: false,
                  elevation: 0,
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  titleTextStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                  centerTitle: false,
                  titleSpacing: 12.0,
                  title: GestureDetector(
                    onTap: () {
                      selectTypeBottom();
                    },
                    child: Container(
                      width: size.width * 0.26,
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        boxShadow: kElevationToShadow[1],
                        color: MyTheme.greenColor,
                        // border: Border.all(color: MyTheme.greenColor),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text(
                            'Find',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.0,
                              color: Colors.white,
                            ),
                          ),
                          // SizedBox(width: 8),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    bottomProvider.token == null || bottomProvider.token == ''
                        ? TextButton(
                            // style: ElevatedButton.styleFrom(
                            //   backgroundColor: MyTheme.greenColor,
                            // ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => const WithoutAuthScreen(),
                                  settings: const RouteSettings(
                                    arguments: true,
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'JOIN',
                              style: TextStyle(
                                color: MyTheme.greenColor,
                                fontSize: 16,
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(50.0),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 4,
                        left: 12,
                        right: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteName.searchPost);
                            },
                            child: Container(
                              width: size.width * 0.80,
                              height: size.height * 0.055,
                              margin: const EdgeInsets.only(bottom: 5),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                children: const [
                                  Icon(
                                    CupertinoIcons.search,
                                    size: 22,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Search',
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 18,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.045,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, RouteName.filter);
                              },
                              color: MyTheme.greenColor,
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                  CupertinoIcons.slider_horizontal_3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: provider.isInternetConnect
                      ? provider.isFirstLoadRunning
                          ? const Padding(
                              padding: EdgeInsets.only(top: 30, bottom: 40),
                              child: Center(child: CustomLoader()),
                            )
                          : provider.allServiceList.isEmpty
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 40),
                                    child: Text(
                                      provider.nearByJobs == false
                                          ? 'Service Not Found'
                                          : 'Jobs Not Found',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox()
                      : NoInternetWidget(
                          onPressed: () async {
                            provider.noInternetAndGetServices(context: context);
                          },
                        ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(
                    left: phoneDevice ? 8 : 12,
                    right: phoneDevice ? 8 : 12,
                    bottom: 30,
                    top: 16,
                  ),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: phoneDevice ? 2 : 3,
                      // childAspectRatio: 0.9,
                      mainAxisSpacing: phoneDevice ? 8 : 12,
                      crossAxisSpacing: phoneDevice ? 8 : 12,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      childCount: provider.allServiceList.length,
                      (context, index) => AllServiceIem(
                        serviceModel: provider.allServiceList[index],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 40),
                    child: Column(
                      children: [
                        if (provider.isLoadMoreRunning == true)
                          const Center(child: CupertinoActivityIndicator()),
                        if (provider.hasNextPage == false &&
                            provider.allServiceList.length > 10)
                          const Center(child: Text('No More Data')),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  selectTypeBottom() {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      // isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
      ),
      builder: (context) {
        // print(object)

        return SafeArea(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 6,
                    bottom: 12,
                    left: 12,
                    right: 12,
                  ),
                  child: Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[500],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                Consumer<AllServicesViewModel>(
                  builder: (context, allServiceViewModel, _) {
                    return Column(
                      children: [
                        type(
                          typeText: 'Jobs Near By',
                          typeIcon: CupertinoIcons.money_dollar_circle_fill,
                          isSelected: allServiceViewModel.nearByJobs == true
                              ? true
                              : false,
                          onTap: () =>
                              allServiceViewModel.selectType(true, context),
                        ),
                        type(
                          typeText: 'Services Near By',
                          typeIcon: CupertinoIcons.briefcase_fill,
                          isSelected: allServiceViewModel.nearByJobs == false
                              ? true
                              : false,
                          onTap: () =>
                              allServiceViewModel.selectType(false, context),
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    final provider = Provider.of<AllServicesViewModel>(context, listen: false);
    provider.controller.dispose();
    super.dispose();
  }

  InkWell type({
    required String typeText,
    required IconData typeIcon,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        child: Row(
          children: [
            Icon(
              typeIcon,
              size: 32,
            ),
            const SizedBox(width: 16),
            Text(
              typeText,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            Icon(
              isSelected
                  ? CupertinoIcons.checkmark_alt_circle_fill
                  : CupertinoIcons.circle,
              color: MyTheme.greenColor,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
