import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/custom_lodaer.dart';
import '../../utils/app_url.dart';
import '../../utils/mytheme.dart';
import '../../view_model/chat_view_model.dart';
import '../../widgets/common/cached_image.dart';
import 'component/messages_appbar.dart';
import 'component/offer_message_item.dart';

class MyMessages extends StatefulWidget {
  const MyMessages({Key? key}) : super(key: key);

  @override
  State<MyMessages> createState() => _MyMessagesState();
}

class _MyMessagesState extends State<MyMessages> {
  final messageController = TextEditingController();
  var img =
      'https://bestprofilepictures.com/wp-content/uploads/2021/04/Cool-Profile-Picture.jpg';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await setupInteracted();
      await setUpRequestNotification();
      await getMyMessages();
    });
    super.initState();
  }

  Future<void> getMyMessages() async {
    Map? chat = ModalRoute.of(context)!.settings.arguments as Map;
    final chatProvider = Provider.of<ChatViewModel>(context, listen: false);
    if (chat['unread'] > 0) {
      await chatProvider.getMyAllChatList(context: context);
      await chatProvider.getMessageList(
        context: context,
        chatId: chat['chat_id'],
        checkMessages: true,
      );
    }
    await chatProvider.getMessageList(
      context: context,
      chatId: chat['chat_id'],
      checkMessages: true,
    );
  }

  Future<void> getNewMessages() async {
    Map? chat = ModalRoute.of(context)!.settings.arguments as Map;
    final chatProvider = Provider.of<ChatViewModel>(context, listen: false);
    await chatProvider.getMessageList(
      context: context,
      chatId: chat['chat_id'],
      checkMessages: false,
    );
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
          getNewMessages();
        }
        // Fluttertoast.showToast(msg: '${chatView['userName']} sent message');
        // Fluttertoast.showToast(msg: 'message received');
      },
    );
  }

  // void _handleMessage(RemoteMessage message) {
  //   // print(message);
  //   // print('A new message send!');
  //   if (message.data['screen'] == 'send-message') {
  //     getMyMessages();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Map? chat = ModalRoute.of(context)!.settings.arguments as Map;
    // final message = context.watch<ChatViewModel>();
    final chatViewModel = Provider.of<ChatViewModel>(context, listen: true);

    // print(serviceId.toString());

    return Scaffold(
      // backgroundColor: Colors.grey.shade50,
      appBar: messageAppBar(
        context: context,
        userName: chat['userName'],
        // userImage: chat['userImage'] == null
        //     ? img
        //     : AppUrl.baseUrl + chat['userImage'],
        userImage: chat['userImage'] == null
            ? Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(
                  Icons.person,
                  color: MyTheme.greenColor,
                ),
              )
            : CachedImageWidget(
                height: 45,
                width: 45,
                radius: 50,
                imgUrl: AppUrl.baseUrl + chat['userImage'],
              ),
        userModel: chat['user']!,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return getMyMessages();
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  children: [
                    // Consumer<ChatViewModel>(
                    //   builder: (context, chatViewModel, _) {
                    //     if (chatViewModel.loading) {
                    //       return const Expanded(child: CustomLoader());
                    //     }
                    //     return
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        itemCount: chatViewModel.messageList.length,
                        itemBuilder: (context, index) {
                          // print(chatViewModel.messageList[index].message);
                          if (chatViewModel.messageList[index].isMe == true) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (chatViewModel.messageList[index].offer ==
                                    null)
                                  MessageItem(
                                    message: chatViewModel.messageList[index],
                                  ),
                                if (chatViewModel.messageList[index].message ==
                                    null)
                                  OfferMessageItem(
                                    message: chatViewModel.messageList[index],
                                  )
                              ],
                            );
                          } else {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (chatViewModel.messageList[index].offer ==
                                    null)
                                  MessageItem(
                                    message: chatViewModel.messageList[index],
                                    isMe: false,
                                  ),
                                if (chatViewModel.messageList[index].message ==
                                    null)
                                  OfferMessageItem(
                                    message: chatViewModel.messageList[index],
                                    isMe: false,
                                  )
                              ],
                            );
                          }
                        },
                      ),
                    ),
                    //   },
                    // ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Card(
                        margin: EdgeInsets.zero,
                        // color: Colors.amber,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: 8,
                            left: 8,
                            bottom: MediaQuery.of(context).viewInsets.bottom > 0
                                ? 12
                                : 16,
                            top: 8,
                          ),
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Icon(
                                          CupertinoIcons.chevron_forward,
                                          color: MyTheme.greenColor,
                                          size: 24,
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                              bottom: 6,
                                            ),
                                            child: TextField(
                                              controller: messageController,
                                              minLines: 1,
                                              maxLines: 5,
                                              cursorColor: Colors.black,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              decoration: InputDecoration(
                                                isDense: true,
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                  right: 16,
                                                  left: 20,
                                                  bottom: 12,
                                                  top: 12,
                                                ),
                                                hintStyle: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey.shade700,
                                                ),
                                                hintText: 'Type a message',
                                                border: InputBorder.none,
                                                filled: true,
                                                fillColor: Colors.grey.shade100,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                  gapPadding: 0,
                                                  borderSide: BorderSide(
                                                    color: Colors.grey.shade200,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  gapPadding: 0,
                                                  borderSide: BorderSide(
                                                    color: Colors.grey.shade300,
                                                  ),
                                                ),
                                              ),
                                              onChanged: (value) {
                                                // if (value.length > 0) {
                                                //   hideTheMic();
                                                // } else {
                                                //   showTheMic();
                                                // }
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Consumer<ChatViewModel>(
                                    builder: (context, messageViewModel, _) {
                                      return Container(
                                        width: 50,
                                        height: 50,
                                        // size: Size(50, 50),
                                        margin:
                                            const EdgeInsets.only(bottom: 6),
                                        child: ClipOval(
                                          child: Material(
                                            color: MyTheme.greenColor,
                                            child: InkWell(
                                              splashColor:
                                                  Colors.white.withOpacity(0.4),
                                              onTap: chatViewModel
                                                      .messageLoading
                                                  ? null
                                                  : () {
                                                      Map data = {
                                                        "service_id":
                                                            chat['service_id'],
                                                        "receiver_id":
                                                            messageViewModel
                                                                .oppositeUser!
                                                                .userId
                                                                .toString(),
                                                        "message":
                                                            messageController
                                                                .text,
                                                      };
                                                      // if (textController.text.length > 0) {
                                                      //   addToMessages(textController.text);
                                                      //   textController.clear();
                                                      //   showTheMic();
                                                      // }
                                                      // print(data);
                                                      if (messageController
                                                          .text.isNotEmpty) {
                                                        messageViewModel
                                                            .sendMessage(
                                                          data: data,
                                                          context: context,
                                                          chatId:
                                                              chat['chat_id'],
                                                          notificationId: chat[
                                                              'notification'],
                                                        );
                                                        messageController
                                                            .clear();
                                                      }
                                                    },
                                              child: const Icon(
                                                Icons.send,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Consumer<ChatViewModel>(
              builder: (context, chatViewModel, _) {
                if (chatViewModel.loadingTwo) {
                  return const Expanded(
                    child: CustomLoader(
                      height: 20,
                      width: 20,
                      strokeWidth: 2.0,
                    ),
                  );
                } else if (chatViewModel.messageLoading) {
                  return Container(
                    color: Colors.grey.shade50.withOpacity(0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Sending... ',
                          style: TextStyle(
                            letterSpacing: 1.0,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            color: MyTheme.greenColor,
                          ),
                        )
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
