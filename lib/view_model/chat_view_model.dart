import 'package:bizhub_new/model/chat_model.dart';
import 'package:bizhub_new/model/message_model.dart';
import 'package:bizhub_new/repo/chat_repo.dart';
import 'package:flutter/material.dart';

class ChatViewModel extends ChangeNotifier {
  final chatRepo = ChatRepository();
  List<ChatModel> posterChatList = [];
  List<ChatModel> workerChatList = [];
  List<MessageModel> posterMessageList = [];

  bool _loading = false;
  bool get loading => _loading;
  setLoad(bool status) {
    _loading = status;
    notifyListeners();
  }

  // Poster Chats List
  Future<void> getMyPosterChatList(
    BuildContext context,
  ) async {
    setLoad(true);
    Future.delayed(const Duration(seconds: 1)).then(
      (value) async {
        if (posterChatList.isEmpty) {
          posterChatList = await chatRepo.fetchMyPosterChatsList();
        }
        setLoad(false);
      },
    );
    notifyListeners();
  }

  // Messages List
  Future<void> getMyPosterMessageList({
    required BuildContext context,
    required String chatId,
  }) async {
    setLoad(true);
    Future.delayed(const Duration(seconds: 1)).then(
      (value) async {
        if (posterMessageList.isEmpty) {
          posterMessageList =
              await chatRepo.fetchMyPosterMessagesList(chatId: chatId);
        }
        setLoad(false);
      },
    );
    notifyListeners();
  }

  // Worker Chats List
  Future<void> getMyWorkerChatList(
    BuildContext context,
  ) async {
    setLoad(true);
    Future.delayed(const Duration(seconds: 1)).then(
      (value) async {
        if (workerChatList.isEmpty) {
          workerChatList = await chatRepo.fetchMyWorkerChatsList();
        }
        setLoad(false);
      },
    );
    notifyListeners();
  }
}
