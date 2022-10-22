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
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'language/language_constant.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  // print('User granted permission: ${settings.authorizationStatus}');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static String notifyToken = '';

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
    super.initState();
    getToken();
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      MyApp.notifyToken = token.toString();
      // print('token: $token');
    });
    // print('app_token: ' + MyApp.notifyToken);
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
        title: 'BizHub',
        debugShowCheckedModeBanner: false,
        theme: MyTheme.myLightTheme,
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
