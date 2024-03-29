import 'package:bizhub_new/components/custom_loader.dart';
import 'package:bizhub_new/components/no_internet.dart';
// import 'package:bizhub_new/utils/dynamic_links.dart';
import 'package:bizhub_new/utils/mytheme.dart';
import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:bizhub_new/utils/shared_prefrences.dart';
import 'package:bizhub_new/view/home/components/all_services_items.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import '../../language/language_constant.dart';
import '../../utils/utils.dart';
import '../../view_model/all_services_view_model.dart';
import '../../view_model/bottom_navigation_view_model.dart';
import '../../view_model/chat_view_model.dart';
import '../../view_model/location_view_model.dart';
import '../auth/without_auth_screen.dart';
import '../location/other_location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String? notifyToken;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final prefrences = Prefrences();
  final phoneDevice = Utils.getDeviceType() == 'phone';

  storeNotificationToken() async {
    FirebaseMessaging.instance.requestPermission();
    await FirebaseMessaging.instance.getToken().then((value) {
      setState(() {
        HomeScreen.notifyToken = value.toString();
        // print('app_token: ${HomeScreen.notifyToken}');
      });
    });
  }

  @override
  void initState() {
    super.initState();

    storeNotificationToken();
    setupInteractedMessage();
    // NotificationService().initNotification();
    getLocation();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      checkAndGetServices();
      final provider =
          Provider.of<AllServicesViewModel>(context, listen: false);

      provider.page = 1;
      provider.hasNextPage = true;

      provider.controller = ScrollController()
        ..addListener(provider.getAllServiceMore);
    });
  }

  Future<void> setupInteractedMessage() async {
    final chatProvider = Provider.of<ChatViewModel>(context, listen: false);

    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'bizchannel',
      'biz channel',
      importance: Importance.max,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      await chatProvider.getMyAllChatListSecond(context: context);

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (chatProvider.onMessagesScreen) {
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                icon: android.smallIcon,
                // other properties...
              ),
              iOS: const DarwinNotificationDetails(),
            ),
          );
        }
      }
    });
  }

  void _handleMessage(RemoteMessage message) {}

  // init() async {
  //   String deviceToken = await getDeviceToken();
  //   print("###### PRINT DEVICE TOKEN TO USE FOR PUSH NOTIFCIATION ######");
  //   print(deviceToken);
  //   print("############################################################");

  //   // listen for user to click on notification
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
  //     String? title = remoteMessage.notification!.title;
  //     String? description = remoteMessage.notification!.body;

  //     //im gonna have an alertdialog when clicking from push notification
  //     // Alert(
  //     //   context: context,
  //     //   type: AlertType.error,
  //     //   title: title, // title from push notification data
  //     //   desc: description, // description from push notifcation data
  //     //   buttons: [
  //     //     DialogButton(
  //     //       child: Text(
  //     //         "COOL",
  //     //         style: TextStyle(color: Colors.white, fontSize: 20),
  //     //       ),
  //     //       onPressed: () => Navigator.pop(context),
  //     //       width: 120,
  //     //     )
  //     //   ],
  //     // ).show();
  //   });
  // }

  Future<void> getLocation() async {
    await Provider.of<LocationViewModel>(context, listen: false)
        .getMyCurrentLocation();
  }

  Future<void> checkAndGetServices() async {
    final provider = Provider.of<AllServicesViewModel>(context, listen: false);
    await provider.getLatLongAndMiles();
    await provider.checkAuth();
    await provider.checkAppUpdateValue(context);
  }

  Future<void> refresh() async {
    await Provider.of<AllServicesViewModel>(context, listen: false)
        .refresh(context);
  }

  @override
  Widget build(BuildContext context) {
    // final auth = context.watch<AuthViewModel>();

    final size = MediaQuery.of(context).size;
    final provider = Provider.of<AllServicesViewModel>(context);
    // final locationViewModel =
    //     Provider.of<LocationViewModel>(context, listen: true);
    final bottomProvider = Provider.of<BottomNavigationViewModel>(context);

    // print(locationViewModel.mylocationAddress);

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
                      width: size.width * 0.30,
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
                        children: [
                          Text(
                            translation(context).findText,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                              color: Colors.white,
                            ),
                          ),
                          // SizedBox(width: 8),
                          const Icon(
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
                        ? Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: TextButton(
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
                              child: Text(
                                translation(context).joinText,
                                style: const TextStyle(
                                  color: MyTheme.greenColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(100.0),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 4,
                        left: 12,
                        right: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => const MyOtherLocation(),
                                  settings: const RouteSettings(
                                    arguments: false,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  const Icon(Icons.location_pin, size: 20),
                                  const SizedBox(width: 6),
                                  // Text(
                                  //   locationViewModel.mylocationAddress.isEmpty
                                  //       ? 'Choose'
                                  //       : locationViewModel.mylocationAddress,
                                  //   style: const TextStyle(
                                  //     fontSize: 17,
                                  //     fontWeight: FontWeight.w500,
                                  //   ),
                                  // ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Consumer<LocationViewModel>(
                                        builder:
                                            (context, locationViewModel, _) {
                                          return Text(
                                            locationViewModel
                                                    .mylocationAddress.isEmpty
                                                ? 'Choose'
                                                : locationViewModel
                                                    .mylocationAddress,
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // const Icon(CupertinoIcons.chevron_down,
                                  //     size: 17),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RouteName.searchPost);
                                },
                                child: Container(
                                  // color: Colors.green,
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
                                    children: [
                                      const Icon(
                                        CupertinoIcons.search,
                                        size: 22,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        translation(context).searchText,
                                        style: const TextStyle(
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
                                    Navigator.pushNamed(
                                        context, RouteName.filter);
                                  },
                                  color: MyTheme.greenColor,
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(
                                      CupertinoIcons.slider_horizontal_3),
                                ),
                              ),
                            ],
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
                                          ? translation(context)
                                              .servicesNotFoundText
                                          : translation(context)
                                              .jobsNotFoundText,
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
                            provider.allServiceList.length >= 10)
                          Center(
                            child: Text(translation(context).noMoreDataText),
                          ),
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
                          typeText: translation(context).servicesNearByText,
                          typeIcon: CupertinoIcons.briefcase_fill,
                          isSelected: allServiceViewModel.nearByJobs == false
                              ? true
                              : false,
                          onTap: () =>
                              allServiceViewModel.selectType(false, context),
                        ),
                        type(
                          typeText: translation(context).jobsNearByText,
                          typeIcon: CupertinoIcons.money_dollar_circle_fill,
                          isSelected: allServiceViewModel.nearByJobs == true
                              ? true
                              : false,
                          onTap: () =>
                              allServiceViewModel.selectType(true, context),
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

  // @override
  // void dispose() {
  //   final provider = Provider.of<AllServicesViewModel>(context, listen: false);
  //   provider.controller.dispose();
  //   super.dispose();
  // }

  //get device token to use for push notification
  // Future getDeviceToken() async {
  //   //request user permission for push notification
  //   FirebaseMessaging.instance.requestPermission();
  //   FirebaseMessaging _firebaseMessage = FirebaseMessaging.instance;
  //   String? deviceToken = await _firebaseMessage.getToken();
  //   return (deviceToken == null) ? "" : deviceToken;
  // }

  @override
  void dispose() {
    // final provider = Provider.of<AllServicesViewModel>(context, listen: false);
    // provider.controller.removeListener(() {
    //   provider.getAllServiceMore;
    // });
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
