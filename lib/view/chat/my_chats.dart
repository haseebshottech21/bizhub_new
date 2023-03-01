import 'package:bizhub_new/components/custom_loader.dart';
import 'package:bizhub_new/components/no_internet.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import '../../language/language_constant.dart';
import '../../view_model/chat_view_model.dart';
import 'component/chat_item.dart';
import 'my_messages.dart';

class MyChats extends StatefulWidget {
  const MyChats({Key? key}) : super(key: key);

  @override
  State<MyChats> createState() => _MyChatsState();
}

class _MyChatsState extends State<MyChats> {
  Future<void> getMyAllChatsList() async {
    final chatProvider = Provider.of<ChatViewModel>(context, listen: false);
    await chatProvider.getMyAllChatList(context: context);
    chatProvider.onMessagesScreen = true;
    // print('INNER:  ${chatProvider.onMessagesScreen}');
  }

  Future<void> getNewMessages() async {
    Map? chat = ModalRoute.of(context)!.settings.arguments as Map;
    final chatProvider = Provider.of<ChatViewModel>(context, listen: false);
    await chatProvider.getMessageListSecond(
      context: context,
      chatId: chat['chat_id'],
      checkMessages: false,
    );
  }

  @override
  void initState() {
    super.initState();
    // LocalNotificationService.initialize();
    setupInteractedMessage();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getMyAllChatsList();
      // await setupInteracted();
    });
  }

  Future<void> setupInteractedMessage() async {
    final chatProvider = Provider.of<ChatViewModel>(context, listen: false);

    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    // FirebaseMessaging.onMessage.listen((event) async {
    //   // print('FCM received message');
    //   await chatProvider.getMyAllChatListSecond(context: context);
    //   if (chatProvider.onMessagesScreen) {
    //     await NotificationService().showNotification(
    //       title: event.notification!.title,
    //       body: event.notification!.body,
    //     );
    //   }
    // });

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'bizchannel',
      'biz channel',
      importance: Importance.max,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      await chatProvider.getMyAllChatListSecond(context: context);

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (chatProvider.onMessagesScreen) {
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                icon: android.smallIcon,
                // other properties...
              ),
              iOS: const DarwinNotificationDetails(),
            ),
          );
        }
      }
    });
  }

  void _handleMessage(RemoteMessage message) {}

  // Future<void> setupInteracted() async {
  //   final chatProvider = Provider.of<ChatViewModel>(context, listen: false);

  //   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //   FirebaseMessaging.onMessage.listen((event) async {
  //     // print('FCM received message');
  //     await chatProvider.getMyAllChatListSecond(context: context);
  //     if (chatProvider.onMessagesScreen) {
  //       await NotificationService().showNotification(
  //         title: event.notification!.title,
  //         body: event.notification!.body,
  //       );
  //     }
  //   });
  // }

  // Future<void> _firebaseMessagingBackgroundHandler(
  //     RemoteMessage message) async {
  //   // If you're going to use other Firebase services in the background, such as Firestore,
  //   // make sure you call `initializeApp` before using other Firebase services.
  //   // await Firebase.initializeApp();
  //   // print("Handling a background message: ${message.messageId}");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 1,
        title: Text(
          translation(context).chatTitle,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Consumer<ChatViewModel>(
        builder: (context, myChats, _) {
          // print(leadsChats.leadChatList.length);
          if (myChats.isInternetConnect) {
            if (myChats.chatloading) {
              return const CustomLoader();
            } else if (myChats.allChatList.isEmpty) {
              return const Center(
                child: Text(
                  'No Chat Available',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            } else {
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider(color: Colors.black38);
                },
                shrinkWrap: true,
                // physics: const BouncingScrollPhysics(),
                primary: false,
                padding: const EdgeInsets.all(8.0),
                itemCount: myChats.allChatList.length,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    chat: myChats.allChatList[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => const MyMessages(),
                          settings: RouteSettings(
                            arguments: {
                              'chat_id': myChats.allChatList[index].chatId,
                              'service_id':
                                  myChats.allChatList[index].serviceId,
                              'userName':
                                  '${myChats.allChatList[index].user!.firstName!} ${myChats.allChatList[index].user!.lastName}',
                              'userImage':
                                  myChats.allChatList[index].user!.image,
                              'user': myChats.allChatList[index].user!,
                              'notification': myChats
                                  .allChatList[index].user!.notificationId,
                              'unread':
                                  myChats.allChatList[index].unreadMessage,
                              'inner': myChats.onMessagesScreen,
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }
          } else {
            return Center(
              child: NoInternetWidget(
                onPressed: () {
                  myChats.noInternetAndGetChats(context: context);
                },
              ),
            );
          }
        },
      ),
    );
  }
}
