import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_model/chat_view_model.dart';
import '../component/offer_message_item.dart';

class PosterMessages extends StatefulWidget {
  const PosterMessages({Key? key}) : super(key: key);

  @override
  State<PosterMessages> createState() => _PosterMessagesState();
}

class _PosterMessagesState extends State<PosterMessages> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getPosterChatsList();
    });
    super.initState();
  }

  Future<void> getPosterChatsList() async {
    await Provider.of<ChatViewModel>(context, listen: false)
        .getMyPosterMessageList(
      context: context,
      chatId: '5',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        title: ListTile(
          onTap: () {},
          leading: const CircleAvatar(
            backgroundImage: NetworkImage(
              'https://bestprofilepictures.com/wp-content/uploads/2021/04/Cool-Profile-Picture.jpg',
            ),
          ),
          title: const Text(
            'Username',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Stack(
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
                    child: chatViewModel.posterMessageList.isNotEmpty
                        ? ListView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            // controller: _scrollController,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemCount: chatViewModel.posterMessageList.length,
                            itemBuilder: (context, index) {
                              var message =
                                  chatViewModel.posterMessageList[index];
                              // return MessageWidget(
                              //   message: chat.messages[index],
                              // );
                              // print(chatViewModel.posterMessageList[index].offer
                              //     .toString());
                              if (message.offer.toString() != 'null') {
                                return OfferMessageItem(message: message);
                              } else {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      constraints:
                                          const BoxConstraints(maxWidth: 250),
                                      padding: const EdgeInsets.all(8),
                                      margin: const EdgeInsets.only(
                                        right: 8,
                                        bottom: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: const Color(0xff1972F5),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: const [
                                          Text(
                                            'Hello, How are you ?',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                            // style: theme.textTheme.bodyText2
                                            //     ?.copyWith(color: Colors.white),
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            '2 : 40 am',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11,
                                            ),
                                            // style: theme.textTheme.bodySmall
                                            //     ?.copyWith(color: Colors.grey.shade300),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }

                              // if (chatViewModel.posterMessageList[index].isMe) {
                              //   return Row(
                              //     mainAxisAlignment: MainAxisAlignment.end,
                              //     children: [
                              //       Container(
                              //         constraints:
                              //             const BoxConstraints(maxWidth: 250),
                              //         padding: const EdgeInsets.all(8),
                              //         margin: const EdgeInsets.only(
                              //           right: 8,
                              //           bottom: 8,
                              //         ),
                              //         decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(8),
                              //           color: const Color(0xff1972F5),
                              //         ),
                              //         child: Column(
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.end,
                              //           children: [
                              //             Text(
                              //               message[index].text!,
                              //               style: const TextStyle(
                              //                 color: Colors.white,
                              //               ),
                              //               // style: theme.textTheme.bodyText2
                              //               //     ?.copyWith(color: Colors.white),
                              //             ),
                              //             const SizedBox(height: 6),
                              //             Text(
                              //               message[index].createdAt,
                              //               style: const TextStyle(
                              //                 color: Colors.white,
                              //                 fontSize: 11,
                              //               ),

                              //               // style: theme.textTheme.bodySmall
                              //               //     ?.copyWith(color: Colors.grey.shade300),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ],
                              //   );
                              // } else {
                              //   return Row(
                              //     children: [
                              //       Container(
                              //         constraints:
                              //             const BoxConstraints(maxWidth: 250),
                              //         padding: const EdgeInsets.all(8),
                              //         margin: const EdgeInsets.only(
                              //             left: 8, bottom: 8),
                              //         decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(8),
                              //           color: const Color.fromARGB(
                              //               255, 225, 231, 236),
                              //         ),
                              //         child: Column(
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.start,
                              //           children: [
                              //             Text(
                              //               message[index].text!,
                              //               // style: theme.textTheme.bodyText2,
                              //             ),
                              //             const SizedBox(height: 4),
                              //             Text(
                              //               message[index].createdAt,
                              //               // style: theme.textTheme.bodySmall,
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ],
                              //   );
                              //   }
                            },
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.chat,
                                    size: 80,
                                    color: Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    'No messages yet',
                                    // style: theme.textTheme.bodyText2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                  );
                },
              ),
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
                                  IconButton(
                                    splashRadius: 20,
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.grey.shade700,
                                      size: 28,
                                    ),
                                    onPressed: () {},
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 5),
                                      child: TextField(
                                        // controller: textController,
                                        minLines: 1,
                                        maxLines: 5,
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: const EdgeInsets.only(
                                            right: 16,
                                            left: 20,
                                            bottom: 10,
                                            top: 10,
                                          ),
                                          hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade700),
                                          hintText: 'Type a message',
                                          border: InputBorder.none,
                                          filled: true,
                                          fillColor: Colors.grey.shade100,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            gapPadding: 0,
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade200),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            gapPadding: 0,
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade300),
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
                            IconButton(
                              splashRadius: 20,
                              icon: Icon(
                                Icons.send,
                                // color: isVisible
                                //     ? Colors.grey.shade700
                                //     : Colors.blue,
                                color: Colors.grey.shade700,
                              ),
                              onPressed: () {
                                // if (textController.text.length > 0) {
                                //   addToMessages(textController.text);
                                //   textController.clear();
                                //   showTheMic();
                                // }
                              },
                            ),
                            // Row(
                            //   children: [
                            //     Visibility(
                            //       visible: isVisible,
                            //       child: IconButton(
                            //         splashRadius: 20,
                            //         icon: Icon(
                            //           Icons.mic,
                            //           color: Colors.grey.shade700,
                            //         ),
                            //         onPressed: () {
                            //           // slideInputController.play();
                            //         },
                            //       ),
                            //     ),
                            //     IconButton(
                            //       splashRadius: 20,
                            //       icon: Icon(
                            //         Icons.send,
                            //         color: isVisible
                            //             ? Colors.grey.shade700
                            //             : Colors.blue,
                            //       ),
                            //       onPressed: () {
                            //         // if (textController.text.length > 0) {
                            //         //   addToMessages(textController.text);
                            //         //   textController.clear();
                            //         //   showTheMic();
                            //         // }
                            //       },
                            //     ),
                            //   ],
                            // ),
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
    );
  }
}
