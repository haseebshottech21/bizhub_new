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
    const String fcmUrl = 'https://fcm.googleapis.com/fcm/send';
    const fcmKey =
        "AAAAhI7xLuY:APA91bGyYBiVKHb8Ro5-HnCEperlrkxSDgSkpyqc74G3n3uVI8VzlQlhifSVTzKYByOSCCZTRn_QujhJbujyBG_oa-z_3u825brYtgbal9HCQdwDKlY0CUtlSY6Uzbe5RhQWKBfv1wH3";
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$fcmKey'
    };

    final request = http.Request('POST', Uri.parse(fcmUrl));
    request.body = jsonEncode({
      "to": notifyToken,
      "collapse_key": "New Message",
      "priority": "high",
      "notification": {
        "title": notiTitle,
        "body": notiBody,
      }
    }
        // {
        //   'notification': {
        //     'title': notiTitle,
        //     'body': notiBody,
        //     'sound': 'default',
        //   },
        //   'priority': 'high',
        //   'data': {
        //     'screen': data,
        //     'id': requestId,
        //     // 'user_id': userId,
        //     // 'user_name': userName,
        //     // if (serviceApplicationId.isNotEmpty)
        //     //   'application_id': serviceApplicationId,
        //   },
        //   'to': notifyToken,
        // },
        );

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    print(response.statusCode);
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
