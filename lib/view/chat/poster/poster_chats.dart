import 'package:bizhub_new/view_model/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../component/chat_item.dart';

class PosterChats extends StatefulWidget {
  const PosterChats({Key? key}) : super(key: key);

  @override
  State<PosterChats> createState() => _PosterChatsState();
}

class _PosterChatsState extends State<PosterChats> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getMyPostserChatsList();
    });
    super.initState();
  }

  Future<void> getMyPostserChatsList() async {
    await Provider.of<ChatViewModel>(context, listen: false)
        .getMyPosterChatList(context);
  }

  @override
  Widget build(BuildContext context) {
    // final chats = getChat();
    return Consumer<ChatViewModel>(
      builder: (context, chatViewModel, _) {
        if (chatViewModel.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        // return SingleChildScrollView(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       // Column(
        //       //   children: chats
        //       //       .map(
        //       //         (e) => Column(
        //       //           children: [
        //       //             ChatWidget(chat: e),
        //       //             chats.indexOf(e) != chats.length - 1
        //       //                 ? const Divider(
        //       //                     // indent: 80,
        //       //                     height: 2,
        //       //                     thickness: 1,
        //       //                     // endIndent: 16,
        //       //                   )
        //       //                 : const SizedBox(),
        //       //           ],
        //       //         ),
        //       //       )
        //       //       .toList(),
        //       // ),
        //     ],
        //   ),
        // );
        return ListView.builder(
          shrinkWrap: true,
          // physics: const ClampingScrollPhysics(),
          primary: false,
          padding: const EdgeInsets.all(2.0),
          itemCount: chatViewModel.posterChatList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ChatWidget(chat: chatViewModel.posterChatList[index]),
                chatViewModel.posterChatList
                            .indexOf(chatViewModel.posterChatList[index]) !=
                        chatViewModel.posterChatList.length - 1
                    ? const Divider(
                        // indent: 80,
                        height: 2,
                        thickness: 1,
                        // endIndent: 16,
                      )
                    : const SizedBox(),
              ],
            );
          },
        );
      },
    );
  }
}
