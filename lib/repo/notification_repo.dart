import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationRepo {
  Future<void> sendNotification({
    required String notiTitle,
    required String notiBody,
    required String data,
    required String requestId,
    required String notifyToken,
  }) async {
    // const String fcmUrl = 'https://fcm.googleapis.com/fcm/send';
    // const fcmKey =
    //     "AAAAhI7xLuY:APA91bGyYBiVKHb8Ro5-HnCEperlrkxSDgSkpyqc74G3n3uVI8VzlQlhifSVTzKYByOSCCZTRn_QujhJbujyBG_oa-z_3u825brYtgbal9HCQdwDKlY0CUtlSY6Uzbe5RhQWKBfv1wH3";
    // final headers = {
    //   'Content-Type': 'application/json',
    //   'Authorization': 'key=$fcmKey'
    // };

    // String tkn = notifyToken;
    // print("token noti: " + notifyToken);

    final responseData = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAAhI7xLuY:APA91bGyYBiVKHb8Ro5-HnCEperlrkxSDgSkpyqc74G3n3uVI8VzlQlhifSVTzKYByOSCCZTRn_QujhJbujyBG_oa-z_3u825brYtgbal9HCQdwDKlY0CUtlSY6Uzbe5RhQWKBfv1wH3',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': notiBody,
            'title': notiTitle,
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'screen': data,
            'id': requestId,
            'status': 'done'
          },
          "to": notifyToken,
        },
      ),
    );

    // http.post(url, headers: headers, body: json);
    // print(responseData.body);

    // responseData.body.headers.addAll(headers);

    // http.StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    //   print(await response.stream.bytesToString());
    // } else {
    //   print(response.reasonPhrase);
    // }
  }
}
