import 'dart:convert';
import 'package:bizhub_new/model/chat_model.dart';
import 'package:bizhub_new/model/message_model.dart';
import 'package:bizhub_new/model/user_model.dart';
import 'package:http/http.dart' as http;
import '../utils/app_url.dart';
import '../utils/utils.dart';

class ChatRepository {
  // Send Offer
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

  // Send Message
  Future<dynamic> sendMessageApi(dynamic data) async {
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

  // All Chats List
  Future<List<ChatModel>> fetchMyAllChatsList() async {
    try {
      final response = await http.get(
        Uri.parse(AppUrl.allChatListEndPoint),
        headers: await AppUrl().headerWithAuth(),
      );
      // print(response.body);
      final loadedData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<ChatModel> myallChatList = (loadedData['data'] as List)
            .map((e) => ChatModel.fromJson(e))
            .toList();
        return myallChatList;
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

  // Poster Chats List
  Future<List<ChatModel>> fetchMyLeadChatsList() async {
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
  Future<Map<String, dynamic>> fetchMessagesList({
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
        List<MessageModel> myMessagesList =
            (loadedData['data']["messages"] as List)
                .map((e) => MessageModel.fromJson(e))
                .toList();
        return {
          "messages": myMessagesList,
          "user": UserModel.fromJson(loadedData['data']["user"]),
        };
      } else {
        // print(loadedData['message']);
        Utils.toastMessage(loadedData['message']);
      }
    } catch (e) {
      // print(e.toString());
      Utils.toastMessage(e.toString());
    }
    return {};
  }

  // Worker Chats List
  Future<List<ChatModel>> fetchMyServiceChatsList() async {
    try {
      final response = await http.get(
        Uri.parse(AppUrl.workerChatListEndPoint),
        headers: await AppUrl().headerWithAuth(),
      );
      // print(response.body);
      final loadedData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<ChatModel> myServiceChatList = (loadedData['data'] as List)
            .map((e) => ChatModel.fromJson(e))
            .toList();
        return myServiceChatList;
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
