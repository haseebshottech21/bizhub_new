import 'package:bizhub_new/model/chat_model.dart';
import 'package:bizhub_new/model/message_model.dart';
import 'package:bizhub_new/model/user_model.dart';
import 'package:bizhub_new/repo/chat_repo.dart';
import 'package:bizhub_new/repo/notification_repo.dart';
import 'package:flutter/material.dart';
import '../utils/shared_prefrences.dart';

class ChatViewModel extends ChangeNotifier {
  final chatRepo = ChatRepository();
  final notification = NotificationRepo();
  List<ChatModel> leadChatList = [];
  List<ChatModel> servicesChatList = [];
  List<ChatModel> allChatList = [];
  List<MessageModel> messageList = [];
  UserModel? oppositeUser;
  final prefrences = Prefrences();

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

  // My All Chats List
  Future<void> getMyAllChatList(
    BuildContext context,
  ) async {
    allChatList.clear();
    setLoad(true);
    Future.delayed(const Duration(seconds: 1)).then(
      (value) async {
        if (allChatList.isEmpty) {
          allChatList = await chatRepo.fetchMyAllChatsList();
        }
        setLoad(false);
      },
    );
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
    Future.delayed(Duration.zero).then(
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
    required String notificationId,
  }) async {
    setMessageLoad(true);
    final loadedData = await chatRepo.sendMessageApi(data);
    // print(loadedData);
    if (loadedData == null) {
      setMessageLoad(false);
    } else if (loadedData != null) {
      Future.delayed(Duration.zero).then(
        (value) async {
          // Navigator.of(context).pop();
          // setMessageLoad(false);
          // getMessageList(context: context, chatId: chatId);
          // Future.delayed(const Duration(seconds: 1)).then(
          //   (value) async {
          // if (messageList.isEmpty) {
          final response = await chatRepo.fetchMessagesList(chatId: chatId);
          // if (response.isNotEmpty) {
          messageList = response['messages'] as List<MessageModel>;

          // commentsWebService.sendNotification(
          //   'Comment',
          //   '${await Utilities().getSharedPreferenceValue('name')} Commented on your ${isPoster ? 'Post' : 'Service'}',
          //   deviceId,
          //   isPoster ? commentKey : userCommentKey,
          //   serviceId,
          // );

          notification.sendNotification(
            notiTitle: 'Message',
            notiBody:
                '${await prefrences.getSharedPreferenceValue('firstname')} send you new message',
            notifyToken: notificationId,
            data: 'send-message',
            requestId: chatId,
          );
          // oppositeUser = response['user'] as UserModel;
          // }
          // }

          setMessageLoad(false);
        },
      );
      // Utils.toastMessage('Service delete Successfully!');
      // });

      // notification.sendNotification(
      //   notiTitle: 'Message',
      //   notiBody: '',
      // );
    }
  }
}
