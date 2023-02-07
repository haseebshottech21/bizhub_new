import 'package:bizhub_new/model/chat_model.dart';
import 'package:bizhub_new/model/message_model.dart';
import 'package:bizhub_new/model/user_model.dart';
import 'package:bizhub_new/repo/chat_repo.dart';
import 'package:bizhub_new/repo/notification_repo.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../utils/shared_prefrences.dart';
import '../utils/utils.dart';
// import '../view/chat/my_messages.dart';

class ChatViewModel extends ChangeNotifier {
  final chatRepo = ChatRepository();
  final notification = NotificationRepo();

  List<ChatModel> allChatList = [];
  List<MessageModel> messageList = [];
  UserModel? oppositeUser;
  final prefrences = Prefrences();
  bool isInternetConnect = true;

  bool _chatloading = false;
  bool get chatloading => _chatloading;
  setChatLoad(bool status) {
    _chatloading = status;
    notifyListeners();
  }

  bool _loadingTwo = false;
  bool get loadingTwo => _loadingTwo;
  setLoadTwo(bool status) {
    _loadingTwo = status;
    notifyListeners();
  }

  bool _messageLoading = false;
  bool get messageLoading => _messageLoading;
  setMessageLoad(bool status) {
    _messageLoading = status;
    notifyListeners();
  }

  bool _messagListLoading = false;
  bool get messagListLoading => _messagListLoading;
  setMessageListLoad(bool status) {
    _messagListLoading = status;
    notifyListeners();
  }

  // My All Chats List
  Future<void> getMyAllChatList({required BuildContext context}) async {
    checkInternet();
    allChatList.clear();
    setChatLoad(true);
    Future.delayed(Duration.zero).then(
      (value) async {
        if (allChatList.isEmpty) {
          allChatList = await chatRepo.fetchMyAllChatsList();
        }
        setChatLoad(false);
      },
    );
    notifyListeners();
  }

  Future<void> getMyAllChatListSecond({required BuildContext context}) async {
    checkInternet();
    // allChatList.clear();
    setLoadTwo(true);
    Future.delayed(Duration.zero).then(
      (value) async {
        // if (allChatList.isEmpty) {
        allChatList = await chatRepo.fetchMyAllChatsList();

        // getMessageListSecond(
        //   context: context,
        //   chatId: chatId,
        //   checkMessages: false,
        // );
        // }
        setLoadTwo(false);
      },
    );
    notifyListeners();
  }

  noInternetAndGetChats({required BuildContext context}) async {
    if (await InternetConnectionChecker().hasConnection == true) {
      // getAllServices();
      getMyAllChatList(context: context);

      Utils.snackBarMessage(
        message: 'Internet Conneted',
        icons: CupertinoIcons.wifi,
        context: context,
      );
    } else {
      Utils.snackBarMessage(
        message: 'Internet Conneted',
        icons: CupertinoIcons.wifi_slash,
        context: context,
      );
    }
  }

  // Future<void> updateChatList({
  //   required bool messageOuter,
  //   required BuildContext context,
  // }) async {
  //   if (messageOuter) {
  //     getMyAllChatListSecond(context: context);
  //   }
  //   notifyListeners();
  // }

  // Messages List
  Future<void> getMessageList({
    required BuildContext context,
    required String chatId,
    required bool checkMessages,
  }) async {
    if (checkMessages) {
      messageList.clear();
    }
    setMessageListLoad(true);
    Future.delayed(Duration.zero).then(
      (value) async {
        final response = await chatRepo.fetchMessagesList(chatId: chatId);
        if (response.isNotEmpty) {
          messageList = response['messages'] as List<MessageModel>;
          oppositeUser = response['user'] as UserModel;
        }
        setMessageListLoad(false);
      },
    );
    notifyListeners();
  }

  Future<void> getMessageListSecond({
    required BuildContext context,
    required String chatId,
    required bool checkMessages,
  }) async {
    checkInternet();
    // allChatList.clear();
    setLoadTwo(true);
    Future.delayed(Duration.zero).then(
      (value) async {
        // if (allChatList.isEmpty) {
        final response = await chatRepo.fetchMessagesList(chatId: chatId);
        if (response.isNotEmpty) {
          messageList = response['messages'] as List<MessageModel>;
          oppositeUser = response['user'] as UserModel;
        }
        // allChatList = await chatRepo.fetchMessagesList(chatId: chatId);
        // }
        setLoadTwo(false);
      },
    );
    notifyListeners();
  }

  // CHECK INTERNET
  checkInternet() async {
    isInternetConnect = await InternetConnectionChecker().hasConnection;
    notifyListeners();
  }

  bool onMessagesScreen = true;

  onMessageScreen(bool onMessageOrChat) {
    onMessagesScreen = onMessageOrChat;
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
          // Future.delayed(const Duration(seconds: 1)).then(
          //   (value) async {
          // if (messageList.isEmpty) {
          final response = await chatRepo.fetchMessagesList(chatId: chatId);
          // if (response.isNotEmpty) {
          messageList = response['messages'] as List<MessageModel>;

          // await NotificationRepo.sendNotification(title, token);
          await notification.sendNotification(
            requestId: chatId,
            title:
                '${await prefrences.getSharedPreferenceValue('firstname')} ${await prefrences.getSharedPreferenceValue('lastname')}',
            body: data['message'],
            token: notificationId,
          );

          // if (notificationId != '') {
          // await notification.sendNotification(
          //   title:
          //       '${await prefrences.getSharedPreferenceValue('firstname')} ${await prefrences.getSharedPreferenceValue('lastname')}',
          //   body: data['message'],
          //   dataOne: 'send-message',
          //   dataTwo: 'rec-message',
          //   notifyToken: notificationId,
          //   requestId: chatId,
          // );
          // }

          getMyAllChatList(context: context);
          // _showNotificationWithSound(notificationId);
          setMessageLoad(false);
        },
      );
    }
  }

  // final FlutterLocalNotificationsPlugin localNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  // Future _showNotificationWithSound(String notificationId) async {
  //   AndroidNotificationDetails androidDetails =
  //       const AndroidNotificationDetails(
  //     'notification-bizhub', 'Bizhub Notifications',
  //     // channelDescription: 'your channel description',
  //     // sound: 'slow_spring_board',
  //     importance: Importance.max,
  //     priority: Priority.max,
  //   );
  //   // var iOSPlatformChannelSpecifics =
  //   //     new IOSNotificationDetails(sound: "slow_spring_board.aiff");
  //   // final initializationSettingsDarwin =
  //   //     DarwinInitializationSettings(defaultPresentSound: true);

  //   DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
  //     presentAlert: true,
  //     presentBadge: true,
  //     presentSound: true,
  //   );
  //   NotificationDetails notiDetails = NotificationDetails(
  //     android: androidDetails,
  //     iOS: iosDetails,
  //   );

  //   await localNotificationsPlugin.show(
  //     0,
  //     'Sample Notification',
  //     'This is a notification',
  //     notiDetails,
  //     // payload: 'Custom_Sound',
  //   );
  //   // print('object');
  // }
}
