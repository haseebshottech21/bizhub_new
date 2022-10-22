// import 'package:bizhub_new/view/chat/worker/worker_messages.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../utils/routes/routes_name.dart';
// import '../../../view_model/chat_view_model.dart';
// import '../component/chat_item.dart';

// class WorkerChats extends StatefulWidget {
//   const WorkerChats({Key? key}) : super(key: key);

//   @override
//   State<WorkerChats> createState() => _WorkerChatsState();
// }

// class _WorkerChatsState extends State<WorkerChats> {
//   // @override
//   // void initState() {
//   //   WidgetsBinding.instance.addPostFrameCallback((_) {
//   //     getMyWorkerChatsList();
//   //   });
//   //   super.initState();
//   // }

//   // Future<void> getMyWorkerChatsList() async {
//   //   await Provider.of<ChatViewModel>(context, listen: false)
//   //       .getMyWorkerChatList(context);
//   // }

//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       getMyServicesChatsList();
//     });
//     super.initState();
//   }

//   Future<void> getMyServicesChatsList() async {
//     await Provider.of<ChatViewModel>(context, listen: false)
//         .getMyServiceChatList(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // return Consumer<ChatViewModel>(
//     //   builder: (context, chatViewModel, _) {
//     //     if (chatViewModel.loading) {
//     //       return const Center(child: CircularProgressIndicator());
//     //     } else if (chatViewModel.workerChatList.isEmpty) {
//     //       return Center(
//     //         child: Column(
//     //           mainAxisAlignment: MainAxisAlignment.center,
//     //           children: [
//     //             Icon(
//     //               Icons.chat,
//     //               size: 80,
//     //               color: Colors.grey.shade400,
//     //             ),
//     //             const SizedBox(height: 20),
//     //             const Text(
//     //               'No messages yet',
//     //               // style: theme.textTheme.bodyText2,
//     //             ),
//     //           ],
//     //         ),
//     //       );
//     //     }
//     //     return ListView.builder(
//     //       shrinkWrap: true,
//     //       // physics: const ClampingScrollPhysics(),
//     //       primary: false,
//     //       padding: const EdgeInsets.all(2.0),
//     //       itemCount: chatViewModel.workerChatList.length,
//     //       itemBuilder: (context, index) {
//     //         return Column(
//     //           children: [
//     //             ChatWidget(
//     //               chat: chatViewModel.workerChatList[index],
//     //               onTap: () {
//     //                 Navigator.pushNamed(context, RouteName.workerMessages);
//     //               },
//     //             ),
//     //             chatViewModel.workerChatList
//     //                         .indexOf(chatViewModel.workerChatList[index]) !=
//     //                     chatViewModel.workerChatList.length - 1
//     //                 ? const Divider(
//     //                     // indent: 80,
//     //                     height: 2,
//     //                     thickness: 1,
//     //                     // endIndent: 16,
//     //                   )
//     //                 : const SizedBox(),
//     //           ],
//     //         );
//     //       },
//     //     );
//     //   },
//     // );

//     return Consumer<ChatViewModel>(
//       builder: (context, serviceChats, _) {
//         if (serviceChats.loading) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (serviceChats.servicesChatList.isEmpty) {
//           return const Center(
//             child: Text(
//               'No Chat Available',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           );
//         } else {
//           return ListView.builder(
//             shrinkWrap: true,
//             // physics: const ClampingScrollPhysics(),
//             primary: false,
//             padding: const EdgeInsets.all(8.0),
//             itemCount: serviceChats.servicesChatList.length,
//             itemBuilder: (context, index) {
//               // return JobPostItem(
//               //   myPosterService: postView.posterServiceList[index],
//               // );
//               return ChatWidget(
//                 chat: serviceChats.servicesChatList[index],
//                 onTap: () {
//                   // Navigator.pushNamed(context, RouteName.posterMessages);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (ctx) => const WorkerMessages(),
//                       settings: RouteSettings(
//                         // arguments:
//                         //     serviceChats.servicesChatList[index].serviceId,
//                         arguments: {
//                           'chat_id':
//                               serviceChats.servicesChatList[index].chatId,
//                           'service_id':
//                               serviceChats.servicesChatList[index].serviceId,
//                           'userName':
//                               '${serviceChats.servicesChatList[index].user!.firstName!} ${serviceChats.servicesChatList[index].user!.lastName}',
//                           'userImage':
//                               serviceChats.servicesChatList[index].user!.image,
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }
