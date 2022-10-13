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

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static String notifyToken = '';

  @override
  State<MyApp> createState() => _MyAppState();
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
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: MyTheme.myLightTheme,
        initialRoute: RouteName.splash,
        onGenerateRoute: RouteGenerator.generateRoute,
        home: const SplashScreen(),
      ),
    );
  }
}
