import 'package:bizhub_new/components/custom_lodaer.dart';
import 'package:bizhub_new/components/no_internet.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../view_model/chat_view_model.dart';
import 'component/chat_item.dart';
import 'my_messages.dart';

class MyChats extends StatefulWidget {
  const MyChats({Key? key}) : super(key: key);

  @override
  State<MyChats> createState() => _MyChatsState();
}

class _MyChatsState extends State<MyChats> {
  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     getMyAllChatsList();
  //   });
  //   super.initState();
  // }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await setupInteracted();
      await setUpRequestNotification();
      await getMyAllChatsList();
    });
    super.initState();
  }

  Future<void> getMyAllChatsList() async {
    await Provider.of<ChatViewModel>(context, listen: false)
        .getMyAllChatList(context: context);
  }

  Future<void> getMyAllChatsListTwo() async {
    await Provider.of<ChatViewModel>(context, listen: false)
        .getMyAllChatListSecond(context: context);
  }

  Future<void> setUpRequestNotification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future<void> setupInteracted() async {
    // Map? chatView = ModalRoute.of(context)!.settings.arguments as Map;

    await FirebaseMessaging.instance.getInitialMessage();

    // FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        // print('A new message received');
        if (message.data['screen'] == 'send-message') {
          getMyAllChatsListTwo();
        }
        Fluttertoast.showToast(msg: 'New message received');
        // Fluttertoast.showToast(msg: 'message received');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 1,
        title: const Text(
          'Messages',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Consumer<ChatViewModel>(
        builder: (context, myChats, _) {
          // print(leadsChats.leadChatList.length);
          if (myChats.isInternetConnect) {
            if (myChats.loading) {
              return const CustomLoader();
            }
            // else if (myChats.loadingTwo) {
            //   return const Text('Loading....');
            // }
            else if (myChats.allChatList.isEmpty) {
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
