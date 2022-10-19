import 'package:bizhub_new/utils/app_url.dart';
import 'package:bizhub_new/utils/mytheme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_model/chat_view_model.dart';
import '../component/messages_appbar.dart';
import '../component/offer_message_item.dart';

class PosterMessages extends StatefulWidget {
  const PosterMessages({Key? key}) : super(key: key);

  @override
  State<PosterMessages> createState() => _PosterMessagesState();
}

class _PosterMessagesState extends State<PosterMessages> {
  final messageController = TextEditingController();
  var img =
      'https://bestprofilepictures.com/wp-content/uploads/2021/04/Cool-Profile-Picture.jpg';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getPosterChatsList();
    });
    super.initState();
  }

  Future<void> getPosterChatsList() async {
    Map? chat = ModalRoute.of(context)!.settings.arguments as Map;
    await Provider.of<ChatViewModel>(context, listen: false).getMessageList(
      context: context,
      chatId: chat['chat_id'],
    );
  }

  Future<void> setupInteractedMessage() async {
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
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {
      // Navigator.pushNamed(
      //   context,
      //   '/chat',
      //   arguments: ChatArguments(message),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    Map? chat = ModalRoute.of(context)!.settings.arguments as Map;

    // final message = context.watch<ChatViewModel>();

    // print(serviceId.toString());

    return Scaffold(
      // backgroundColor: Colors.grey.shade50,
      appBar: messageAppBar(
        context: context,
        userName: chat['userName'],
        userImage: chat['userImage'] == null
            ? img
            : AppUrl.baseUrl + chat['userImage'],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return getPosterChatsList();
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  children: [
                    Consumer<ChatViewModel>(
                      builder: (context, chatViewModel, _) {
                        if (chatViewModel.loading) {
                          return const Expanded(
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        return Expanded(
                          child: ListView.builder(
                            reverse: true,
                            itemCount: chatViewModel.messageList.length,
                            itemBuilder: (context, index) {
                              // print(chatViewModel.messageList[index].message);
                              if (chatViewModel.messageList[index].isMe ==
                                  true) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (chatViewModel
                                            .messageList[index].offer ==
                                        null)
                                      MessageItem(
                                        message:
                                            chatViewModel.messageList[index],
                                      ),
                                    if (chatViewModel
                                            .messageList[index].message ==
                                        null)
                                      OfferMessageItem(
                                        message:
                                            chatViewModel.messageList[index],
                                      )
                                  ],
                                );
                              } else {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    if (chatViewModel
                                            .messageList[index].offer ==
                                        null)
                                      MessageItem(
                                        message:
                                            chatViewModel.messageList[index],
                                        isMe: false,
                                      ),
                                    if (chatViewModel
                                            .messageList[index].message ==
                                        null)
                                      OfferMessageItem(
                                        message:
                                            chatViewModel.messageList[index],
                                        isMe: false,
                                      )
                                  ],
                                );
                              }
                            },
                          ),
                        );
                      },
                    ),
                    //  MessageBottom(),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Card(
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: 8,
                            left: 8,
                            bottom: MediaQuery.of(context).viewInsets.bottom > 0
                                ? 15
                                : 20,
                            top: 8,
                          ),
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
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
                                                bottom: 5),
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
                                                  bottom: 10,
                                                  top: 10,
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
                                                      BorderRadius.circular(20),
                                                  gapPadding: 0,
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.grey.shade200),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  gapPadding: 0,
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.grey.shade300),
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
                                  Consumer<ChatViewModel>(
                                    builder: (context, messageViewModel, _) {
                                      return
                                          // messageViewModel.messageLoading
                                          //     ? const Center(
                                          //         child:
                                          //             CircularProgressIndicator(),
                                          //       )
                                          //     :
                                          IconButton(
                                        splashRadius: 20,
                                        icon: Icon(
                                          Icons.send,
                                          // color: isVisible
                                          //     ? Colors.grey.shade700
                                          //     : Colors.blue,
                                          color: Colors.grey.shade600,
                                        ),
                                        onPressed: () {
                                          Map data = {
                                            "service_id": chat['service_id'],
                                            "receiver_id": messageViewModel
                                                .oppositeUser!.userId
                                                .toString(),
                                            "message": messageController.text,
                                          };
                                          // if (textController.text.length > 0) {
                                          //   addToMessages(textController.text);
                                          //   textController.clear();
                                          //   showTheMic();
                                          // }
                                          // print(data);
                                          if (messageController
                                              .text.isNotEmpty) {
                                            messageViewModel.sendMessage(
                                              data: data,
                                              context: context,
                                              chatId: chat['chat_id'],
                                            );
                                            messageController.clear();
                                          }
                                        },
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
                return chatViewModel.messageLoading
                    ? Container(
                        color: Colors.black.withOpacity(0.2),
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.40,
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Text(
                                  'Loading... ',
                                  style: TextStyle(letterSpacing: 1.0),
                                ),
                                SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    color: MyTheme.greenColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
