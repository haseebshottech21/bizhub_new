import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// final FlutterLocalNotificationsPlugin localNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// class LocalNotifiaction {
//   Future initialize() async {
//     AndroidInitializationSettings androidSetting =
//         const AndroidInitializationSettings(
//       '@drawable/ic_stat_message',
//     );
//     // var iOSInitialize = new IOSInitializationSettings();
//     DarwinInitializationSettings iosSetting =
//         const DarwinInitializationSettings(
//       requestSoundPermission: false,
//       requestBadgePermission: false,
//       requestAlertPermission: false,
//     );

//     InitializationSettings initializationsSettings = InitializationSettings(
//       android: androidSetting,
//       iOS: iosSetting,
//     );
//     // bool? initialized =
//     //     await localNotificationsPlugin.initialize(initializationsSettings);

//     await localNotificationsPlugin.initialize(initializationsSettings);
//     // }

//     // log('Notifications: $initialized');
//   }

//   Future showNotificationWithSound({
//     required String title,
//     required String body,
//   }) async {
//     AndroidNotificationDetails androidDetails =
//         const AndroidNotificationDetails(
//       'channel_id_1', 'bizhub',
//       // channelDescription: 'your channel description',
//       // sound: 'slow_spring_board',
//       // playSound: true,
//       // timeoutAfter: 5000,
//       // styleInformation: DefaultStyleInformation(true, true),
//       // importance: Importance.high,
//       // priority: Priority.high,
//       // playSound: true,
//       // sound: RawResourceAndroidNotificationSound('sound_new'),
//       playSound: true,
//       // sound: RawResourceAndroidNotificationSound('bell'),
//       importance: Importance.high,
//       priority: Priority.high,
//       // styleInformation: bigPictureStyleInformation
//       // showWhen: false,
//       // visibility: NotificationVisibility.secret,
//     );
//     // var iOSPlatformChannelSpecifics =
//     //     new IOSNotificationDetails(sound: "slow_spring_board.aiff");
//     // final initializationSettingsDarwin =
//     //     DarwinInitializationSettings(defaultPresentSound: true);

//     // DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
//     //   presentAlert: true,
//     //   presentBadge: true,
//     //   presentSound: true,
//     // );

//     const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );

//     NotificationDetails notiDetails = NotificationDetails(
//       android: androidDetails,
//       iOS: iosDetails,
//     );

//     await localNotificationsPlugin.show(
//       0,
//       title,
//       body,
//       notiDetails,
//     );
//     // print('object');
//   }

//   Future cancelAllNotifications() async {
//     await localNotificationsPlugin.cancel(0);
//   }

//   Future<void> requestPermissions() async {
//     await localNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//   }
// }

// class LocalNotificationService {
//   static final FlutterLocalNotificationsPlugin
//       _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   static void initialize() {
//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: AndroidInitializationSettings('@drawable/ic_stat_message'),
//       iOS: DarwinInitializationSettings(
//         requestSoundPermission: false,
//         requestBadgePermission: false,
//         requestAlertPermission: false,
//       ),
//     );

//     _flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   static void requestPermissions() async {
//     await _flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//   }

//   static void display(RemoteMessage message) async {
//     try {
//       print('In Notification method');

//       // Random random = Random();
//       // int id = random.nextInt(1000);

//       AndroidNotificationDetails androidDetails =
//           const AndroidNotificationDetails(
//         'bizchannel',
//         'biz channel',
//         playSound: true,
//         // sound: RawResourceAndroidNotificationSound('bell'),
//         importance: Importance.max,
//         priority: Priority.high,
//       );

//       const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
//         presentAlert: true,
//         presentBadge: true,
//         presentSound: true,
//       );

//       NotificationDetails notiDetails = NotificationDetails(
//         android: androidDetails,
//         iOS: iosDetails,
//       );
//       // if (message.data['screen'] == 'outer') {
//       print('notification show');
//       await _flutterLocalNotificationsPlugin.show(
//         0,
//         message.notification!.title,
//         message.notification!.body,
//         notiDetails,
//       );
//       // }
//     } on Exception catch (e) {
//       print('Error>>> $e');
//     }
//   }
// }
