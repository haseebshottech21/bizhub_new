import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_model/chat_view_model.dart';
import '../component/chat_item.dart';

class WorkerChats extends StatefulWidget {
  const WorkerChats({Key? key}) : super(key: key);

  @override
  State<WorkerChats> createState() => _WorkerChatsState();
}

class _WorkerChatsState extends State<WorkerChats> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getMyWorkerChatsList();
    });
    super.initState();
  }

  Future<void> getMyWorkerChatsList() async {
    await Provider.of<ChatViewModel>(context, listen: false)
        .getMyWorkerChatList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatViewModel>(
      builder: (context, chatViewModel, _) {
        if (chatViewModel.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (chatViewModel.workerChatList.isEmpty) {
          return Center(
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
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          // physics: const ClampingScrollPhysics(),
          primary: false,
          padding: const EdgeInsets.all(2.0),
          itemCount: chatViewModel.workerChatList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ChatWidget(chat: chatViewModel.workerChatList[index]),
                chatViewModel.workerChatList
                            .indexOf(chatViewModel.workerChatList[index]) !=
                        chatViewModel.workerChatList.length - 1
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
