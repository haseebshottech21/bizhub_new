import 'package:bizhub_new/model/chat_model.dart';
import 'package:bizhub_new/model/message_model.dart';
import 'package:bizhub_new/model/user_model.dart';
import 'package:bizhub_new/repo/chat_repo.dart';
import 'package:flutter/material.dart';

class ChatViewModel extends ChangeNotifier {
  final chatRepo = ChatRepository();
  List<ChatModel> leadChatList = [];
  List<ChatModel> servicesChatList = [];
  List<MessageModel> messageList = [];
  UserModel? oppositeUser;

  // List<MessageModel> posterMessageList = [];

  bool _loading = false;
  bool get loading => _loading;
  setLoad(bool status) {
    _loading = status;
    notifyListeners();
  }

  bool _messageLoading = false;
  bool get messageLoading => _messageLoading;
  setMessageLoad(bool status) {
    _messageLoading = status;
    notifyListeners();
  }

  // Leads Chats List
  Future<void> getMyLeadChatList(
    BuildContext context,
  ) async {
    leadChatList.clear();
    setLoad(true);
    Future.delayed(const Duration(seconds: 1)).then(
      (value) async {
        if (leadChatList.isEmpty) {
          leadChatList = await chatRepo.fetchMyLeadChatsList();
        }
        setLoad(false);
      },
    );
    notifyListeners();
  }

  // Messages List
  Future<void> getMessageList({
    required BuildContext context,
    required String chatId,
  }) async {
    messageList.clear();

    setLoad(true);

    Future.delayed(const Duration(seconds: 1)).then(
      (value) async {
        if (messageList.isEmpty) {
          final response = await chatRepo.fetchMessagesList(chatId: chatId);
          if (response.isNotEmpty) {
            messageList = response['messages'] as List<MessageModel>;
            oppositeUser = response['user'] as UserModel;
          }
        }

        setLoad(false);
      },
    );
    notifyListeners();
  }

  // Services Chats List
  Future<void> getMyServiceChatList(
    BuildContext context,
  ) async {
    servicesChatList.clear();
    setLoad(true);
    Future.delayed(const Duration(seconds: 1)).then(
      (value) async {
        if (servicesChatList.isEmpty) {
          servicesChatList = await chatRepo.fetchMyServiceChatsList();
        }
        setLoad(false);
      },
    );
    notifyListeners();
  }

  // Send Message
  Future<void> sendMessage({
    required dynamic data,
    required BuildContext context,
    required String chatId,
  }) async {
    setMessageLoad(true);
    final loadedData = await chatRepo.sendMessageApi(data);
    // print(loadedData);
    if (loadedData == null) {
      setMessageLoad(false);
    } else if (loadedData != null) {
      Future.delayed(Duration.zero).then((value) {
        // Navigator.of(context).pop();
        setMessageLoad(false);
        getMessageList(context: context, chatId: chatId);
        // Utils.toastMessage('Service delete Successfully!');
      });
    }
  }
}
