import 'dart:convert';
import 'package:bizhub_new/model/chat_model.dart';
import 'package:bizhub_new/model/message_model.dart';
import 'package:http/http.dart' as http;
import '../utils/app_url.dart';
import '../utils/utils.dart';

class ChatRepository {
  Future<dynamic> sendOfferApi(dynamic data) async {
    try {
      http.Response response = await http.post(
        Uri.parse(AppUrl.sendOfferEndPoint),
        body: data,
        headers: await AppUrl().headerWithAuth(),
      );

      final responseLoaded = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return responseLoaded;
      } else {
        Utils.toastMessage(responseLoaded['message']);
      }
    } catch (e) {
      // print(e.toString());
      Utils.toastMessage(e.toString());
      // Fluttertoast.showToast(msg: e.toString());
    }
  }

  // Poster Chats List
  Future<List<ChatModel>> fetchMyPosterChatsList() async {
    try {
      final response = await http.get(
        Uri.parse(AppUrl.posterChatListEndPoint),
        headers: await AppUrl().headerWithAuth(),
      );
      // print(response.body);
      final loadedData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<ChatModel> myPosterChatList = (loadedData['data'] as List)
            .map((e) => ChatModel.fromJson(e))
            .toList();
        return myPosterChatList;
      } else {
        // print(loadedData['message']);
        Utils.toastMessage(loadedData['message']);
      }
    } catch (e) {
      // print(e.toString());
      Utils.toastMessage(e.toString());
    }
    return [];
  }

  // Poster Messages List
  Future<List<MessageModel>> fetchMyPosterMessagesList({
    required String chatId,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('${AppUrl.messagesListEndPoint}/$chatId'),
        headers: await AppUrl().headerWithAuth(),
      );
      // print(response.body);
      final loadedData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<MessageModel> myMessagesList = (loadedData['data'] as List)
            .map((e) => MessageModel.fromJson(e))
            .toList();
        return myMessagesList;
      } else {
        // print(loadedData['message']);
        Utils.toastMessage(loadedData['message']);
      }
    } catch (e) {
      // print(e.toString());
      Utils.toastMessage(e.toString());
    }
    return [];
  }

  // Worker Chats List
  Future<List<ChatModel>> fetchMyWorkerChatsList() async {
    try {
      final response = await http.get(
        Uri.parse(AppUrl.workerChatListEndPoint),
        headers: await AppUrl().headerWithAuth(),
      );
      // print(response.body);
      final loadedData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<ChatModel> myPosterServiceList = (loadedData['data'] as List)
            .map((e) => ChatModel.fromJson(e))
            .toList();
        return myPosterServiceList;
      } else {
        // print(loadedData['message']);
        Utils.toastMessage(loadedData['message']);
      }
    } catch (e) {
      // print(e.toString());
      Utils.toastMessage(e.toString());
    }
    return [];
  }
}
