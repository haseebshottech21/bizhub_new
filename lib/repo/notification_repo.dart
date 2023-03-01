import 'dart:convert';
// import 'package:bizhub_new/language/language_constant.dart';
// import 'package:bizhub_new/language/language_constant.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class NotificationRepo {
  Future<void> sendNotification({
    required String requestId,
    required String title,
    required String body,
    // required String screen,
    required String token,
  }) async {
    final data = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': requestId,
      'title': title,
      'body': body,
      // 'screen': screen,
      'status': 'done',
    };

    try {
      http.Response response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAhI7xLuY:APA91bGyYBiVKHb8Ro5-HnCEperlrkxSDgSkpyqc74G3n3uVI8VzlQlhifSVTzKYByOSCCZTRn_QujhJbujyBG_oa-z_3u825brYtgbal9HCQdwDKlY0CUtlSY6Uzbe5RhQWKBfv1wH3'
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'title': title,
              'body': body,
            },
            'priority': 'high',
            'data': data,
            'to': token
          },
        ),
      );

      if (response.statusCode == 200) {
        // print("Yeh notificatin is sended");
      } else {
        // print("Error");
      }
    } catch (e) {
      // print(e.toString());
    }
  }

  // Future<void> sendNotification({
  //   required String title,
  //   required String body,
  //   required String dataOne,
  //   required String dataTwo,
  //   required String requestId,
  //   required String notifyToken,
  //   // bool showNoti = false,
  // }) async {
  //   // const String fcmUrl = 'https://fcm.googleapis.com/fcm/send';
  //   // const fcmKey =
  //   //     "AAAAhI7xLuY:APA91bGyYBiVKHb8Ro5-HnCEperlrkxSDgSkpyqc74G3n3uVI8VzlQlhifSVTzKYByOSCCZTRn_QujhJbujyBG_oa-z_3u825brYtgbal9HCQdwDKlY0CUtlSY6Uzbe5RhQWKBfv1wH3";
  //   // final headers = {
  //   //   'Content-Type': 'application/json',
  //   //   'Authorization': 'key=$fcmKey'
  //   // };

  //   // String tkn = notifyToken;
  //   // print("token noti: " + notifyToken);

  //   // final responseData =
  //   await http.post(
  //     Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //       'Authorization':
  //           'key=AAAAhI7xLuY:APA91bGyYBiVKHb8Ro5-HnCEperlrkxSDgSkpyqc74G3n3uVI8VzlQlhifSVTzKYByOSCCZTRn_QujhJbujyBG_oa-z_3u825brYtgbal9HCQdwDKlY0CUtlSY6Uzbe5RhQWKBfv1wH3',
  //     },
  //     body: jsonEncode(
  //       <String, dynamic>{
  //         'notification': <String, dynamic>{
  //           'title': title,
  //           'body': body,
  //         },
  //         'priority': 'high',
  //         'data': <String, dynamic>{
  //           'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  //           'screen_one': dataOne,
  //           'screen_two': dataTwo,
  //           // 'show_noti': showNoti,
  //           'id': requestId,
  //           'status': 'done'
  //         },
  //         "to": notifyToken,
  //       },
  //     ),
  //   );

  // http.post(url, headers: headers, body: json);
  // print(responseData.body);

  // responseData.body.headers.addAll(headers);

  // http.StreamedResponse response = await request.send();

  // if (response.statusCode == 200) {
  //   print(await response.stream.bytesToString());
  // } else {
  //   print(response.reasonPhrase);
  // }
  // }

  // Future<void> deleteFcmToken() async {
  //   return await FirebaseMessaging.instance.deleteToken();
  // }
}
