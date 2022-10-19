import 'package:bizhub_new/view/chat/poster/poster_messages.dart';
import 'package:bizhub_new/view_model/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../../../utils/routes/routes_name.dart';
import '../component/chat_item.dart';

class PosterChats extends StatefulWidget {
  const PosterChats({Key? key}) : super(key: key);

  @override
  State<PosterChats> createState() => _PosterChatsState();
}

class _PosterChatsState extends State<PosterChats> {
  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     getMyPostserChatsList();
  //   });
  //   super.initState();
  // }

  // Future<void> getMyPostserChatsList() async {
  //   await Provider.of<ChatViewModel>(context, listen: false)
  //       .getMyPosterChatList(context);
  // }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getMyLeadsChatsList();
    });
    super.initState();
  }

  Future<void> getMyLeadsChatsList() async {
    await Provider.of<ChatViewModel>(context, listen: false)
        .getMyLeadChatList(context);
  }

  @override
  Widget build(BuildContext context) {
    // final chats = getChat();

    // final chatViewModel = context.watch<ChatViewModel>();
    // return Consumer<ChatViewModel>(
    //   builder: (context, chatViewModel, _) {
    //     if (chatViewModel.posterChatList.isEmpty) {
    //       // return const Center(child: CircularProgressIndicator());
    //       return const Center(
    //         child: Text(
    //           'No Chat Available',
    //           style: TextStyle(
    //             color: Colors.black,
    //             fontSize: 20.0,
    //             fontWeight: FontWeight.w400,
    //           ),
    //         ),
    //       );
    //     }
    //     // return SingleChildScrollView(
    //     //   child: Column(
    //     //     crossAxisAlignment: CrossAxisAlignment.start,
    //     //     children: [
    //     //       // Column(
    //     //       //   children: chats
    //     //       //       .map(
    //     //       //         (e) => Column(
    //     //       //           children: [
    //     //       //             ChatWidget(chat: e),
    //     //       //             chats.indexOf(e) != chats.length - 1
    //     //       //                 ? const Divider(
    //     //       //                     // indent: 80,
    //     //       //                     height: 2,
    //     //       //                     thickness: 1,
    //     //       //                     // endIndent: 16,
    //     //       //                   )
    //     //       //                 : const SizedBox(),
    //     //       //           ],
    //     //       //         ),
    //     //       //       )
    //     //       //       .toList(),
    //     //       // ),
    //     //     ],
    //     //   ),
    //     // );
    //     // print(chatViewModel.posterChatList.length);
    //     return ListView.builder(
    //       shrinkWrap: true,
    //       // physics: const ClampingScrollPhysics(),
    //       primary: false,
    //       padding: const EdgeInsets.all(2.0),
    //       itemCount: chatViewModel.posterChatList.length,
    //       itemBuilder: (context, index) {
    //         return Column(
    //           children: [
    //             ChatWidget(
    //               chat: chatViewModel.posterChatList[index],
    //               onTap: () {
    //                 Navigator.pushNamed(context, RouteName.posterMessages);
    //               },
    //             ),
    //             chatViewModel.posterChatList
    //                         .indexOf(chatViewModel.posterChatList[index]) !=
    //                     chatViewModel.posterChatList.length - 1
    //                 ? const Divider(
    //                     // indent: 80,
    //                     height: 2,
    //                     thickness: 1,
    //                     // endIndent: 16,
    //                   )
    //                 : const SizedBox(),
    //           ],
    //         );
    //       },
    //     );
    //   },
    // );

    return Consumer<ChatViewModel>(
      builder: (context, leadsChats, _) {
        // print(leadsChats.leadChatList.length);
        if (leadsChats.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (leadsChats.leadChatList.isEmpty) {
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
            itemCount: leadsChats.leadChatList.length,
            itemBuilder: (context, index) {
              // return JobPostItem(
              //   myPosterService: postView.posterServiceList[index],
              // );
              // return Text('data $index');
              return ChatWidget(
                chat: leadsChats.leadChatList[index],
                onTap: () {
                  // Navigator.pushNamed(
                  //   context,
                  //   RouteName.posterMessages,
                  //   arguments: leadsChats.leadChatList[index].serviceId,
                  // );
                  // print(leadsChats.leadChatList[index].serviceId);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const PosterMessages(),
                      settings: RouteSettings(
                        arguments: {
                          'chat_id': leadsChats.leadChatList[index].chatId,
                          'service_id':
                              leadsChats.leadChatList[index].serviceId,
                          'userName':
                              '${leadsChats.leadChatList[index].user!.firstName!} ${leadsChats.leadChatList[index].user!.lastName}',
                          'userImage':
                              leadsChats.leadChatList[index].user!.image,
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
    );
  }
}
