// import 'package:bizhub_new/services/local_notification.dart';
// import 'package:bizhub_new/utils/local_notification.dart';
import 'dart:io';
import 'package:bizhub_new/services/notifications_service.dart';
import 'package:bizhub_new/utils/dynamic_links.dart';
import 'package:bizhub_new/utils/mytheme.dart';
import 'package:bizhub_new/utils/routes/routes.dart';
import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:bizhub_new/view/splash_screen.dart';
import 'package:bizhub_new/view_model/all_services_view_model.dart';
import 'package:bizhub_new/view_model/auth_view_model.dart';
import 'package:bizhub_new/view_model/bottom_navigation_view_model.dart';
import 'package:bizhub_new/view_model/category_view_model.dart';
import 'package:bizhub_new/view_model/chat_view_model.dart';
import 'package:bizhub_new/view_model/location_view_model.dart';
import 'package:bizhub_new/view_model/my_service_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'language/language_constant.dart';

Future<void> _firebaseMessagingBackgroundHandler(message) async {
  await Firebase.initializeApp();
  // print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  if (Platform.isIOS) {
    //IOS check permission
    permission();
  }

  NotificationService().initLocalNotification();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(const MyApp());
}

void permission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized ||
      settings.authorizationStatus == AuthorizationStatus.provisional) {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // headsup notification in IOS
      badge: true,
      sound: true,
    );
  } else {
    //close the app
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print(message.notification!.title.toString());
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static String? notifyToken;

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale({
    required BuildContext context,
    required Locale newLocale,
  }) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // getToken();
    super.initState();

    DynamicLinkProvider().initDynamicLinks(context);
  }

  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => CategoryViewModel()),
        ChangeNotifierProvider(create: (_) => AllServicesViewModel()),
        ChangeNotifierProvider(create: (_) => MyServiceViewModel()),
        ChangeNotifierProvider(create: (_) => ChatViewModel()),
        ChangeNotifierProvider(create: (_) => LocationViewModel()),
        ChangeNotifierProvider(create: (_) => BottomNavigationViewModel()),
      ],
      child: MaterialApp(
        builder: ((context, child) => ResponsiveWrapper.builder(
              // BouncingScrollWrapper.builder(context, child!),
              ClampingScrollWrapper.builder(context, child!),
              maxWidth: 1200,
              minWidth: 450,
              defaultScale: true,
              breakpoints: [
                const ResponsiveBreakpoint.resize(450, name: MOBILE),
                const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
              ],
            )),
        title: 'BizHub',
        debugShowCheckedModeBanner: false,
        theme: MyTheme.myLightTheme,
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        // ),
        initialRoute: RouteName.splash,
        onGenerateRoute: RouteGenerator.generateRoute,
        home: const SplashScreen(),
        // supportedLocales: L10n.all,
        // localizationsDelegates: const [
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        // ],
        // supportedLocales: const [
        //   Locale('en', ''), // English, no country code
        //   Locale('es', ''), // Spanish, no country code
        // ],
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        // locale: const Locale('es', ''),
        locale: _locale,
      ),
    );
  }
}
