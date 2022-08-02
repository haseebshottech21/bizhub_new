import 'package:bizhub_new/utils/dummy_data.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  // final textController = TextEditingController();
  // final _scrollController = ScrollController();

  late Animation<double> opacity;
  // late AnimationController slideInputController;
  // late Animation<Offset> slideInputAnimation;

  // @override
  // void initState() {
  //   slideInputController = createController()
  //     ..duration = Duration(milliseconds: 500);

  //   slideInputAnimation = Tween<Offset>(
  //     begin: Offset(0, 0),
  //     end: Offset(-2, 0),
  //   ).animate(slideInputController);

  //   opacity = Tween<double>(begin: 1, end: 0).animate(controller);
  //   controller.duration = Duration(milliseconds: 200);

  //   super.initState();
  // }

  var isVisible = true;

  final message = getMessage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorConstants.lightBackgroundColor,
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
          subtitle: const Text(
            'last seen yesterday',
            style: TextStyle(
              fontSize: 12,
            ),
            // style: theme.textTheme.bodySmall,
          ),
        ),
      ),
      // a message list
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              Expanded(
                child: message.isNotEmpty
                    ? ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        // controller: _scrollController,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: message.length,
                        itemBuilder: (context, index) {
                          // return MessageWidget(
                          //   message: chat.messages[index],
                          // );

                          if (message[index].isMe) {
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
                                    color: Color(0xff1972F5),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        message[index].text!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        // style: theme.textTheme.bodyText2
                                        //     ?.copyWith(color: Colors.white),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        message[index].createdAt,
                                        style: const TextStyle(
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
                          } else {
                            return Row(
                              children: [
                                Container(
                                  constraints: BoxConstraints(maxWidth: 250),
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.only(left: 8, bottom: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color.fromARGB(255, 225, 231, 236),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        message[index].text!,
                                        // style: theme.textTheme.bodyText2,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        message[index].createdAt,
                                        // style: theme.textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
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
                                color: isVisible
                                    ? Colors.grey.shade700
                                    : Colors.blue,
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
