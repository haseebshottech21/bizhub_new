import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_model/chat_view_model.dart';
import '../component/chat_item.dart';
// import '../poster/poster_messages.dart';
import 'my_messages.dart';

class MyChats extends StatefulWidget {
  const MyChats({Key? key}) : super(key: key);

  @override
  State<MyChats> createState() => _MyChatsState();
}

class _MyChatsState extends State<MyChats> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getMyAllChatsList();
    });
    super.initState();
  }

  Future<void> getMyAllChatsList() async {
    await Provider.of<ChatViewModel>(context, listen: false)
        .getMyAllChatList(context);
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
          if (myChats.loading) {
            return const Center(child: CircularProgressIndicator());
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
            return ListView.builder(
              shrinkWrap: true,
              // physics: const ClampingScrollPhysics(),
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
                            'service_id': myChats.allChatList[index].serviceId,
                            'userName':
                                '${myChats.allChatList[index].user!.firstName!} ${myChats.allChatList[index].user!.lastName}',
                            'userImage': myChats.allChatList[index].user!.image,
                            'user': myChats.allChatList[index].user!,
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
