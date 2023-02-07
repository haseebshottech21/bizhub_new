import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@drawable/ic_stat_message');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'bizchannel',
        'biz channel',
        importance: Importance.max,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
      id,
      title,
      body,
      await notificationDetails(),
    );
  }
}

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
