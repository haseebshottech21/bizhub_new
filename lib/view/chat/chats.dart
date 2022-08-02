import 'package:bizhub_new/model/chat_model.dart';
import 'package:bizhub_new/utils/dummy_data.dart';
import 'package:bizhub_new/utils/mytheme.dart';
import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import '../../widgets/common/cached_image.dart';

class Chats extends StatelessWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chats = getChat();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          bottom: TabBar(
            indicatorColor: MyTheme.greenColor,
            indicatorWeight: 5,
            splashBorderRadius: BorderRadius.circular(5),
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 4.0,
                color: MyTheme.greenColor,
              ),
            ),
            // indicator: BoxDecoration(color: MyTheme.greenColor),
            tabs: [
              Tab(
                child: Text(
                  'Poster'.toUpperCase(),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  'Worker'.toUpperCase(),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          title: const Text('Chats', style: TextStyle(color: Colors.black)),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: chats
                        .map(
                          (e) => Column(
                            children: [
                              ChatWidget(chat: e),
                              chats.indexOf(e) != chats.length - 1
                                  ? const Divider(
                                      // indent: 80,
                                      height: 2,
                                      thickness: 1,
                                      // endIndent: 16,
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: chats
                        .map(
                          (e) => Column(
                            children: [
                              ChatWidget(chat: e),
                              chats.indexOf(e) != chats.length - 1
                                  ? const Divider(
                                      // indent: 80,
                                      height: 2,
                                      thickness: 1,
                                      // endIndent: 16,
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatWidget extends StatelessWidget {
  final Chat chat;
  const ChatWidget({
    required this.chat,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteName.messages);
      },
      onLongPress: () {
        showModalBottomSheet(
          backgroundColor: Colors.white,
          context: context,
          // isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15.0),
            ),
          ),
          builder: (context) {
            // print(object)

            return Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 15,
                      left: 12,
                      right: 12,
                    ),
                    child: Container(
                      height: 6,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.grey[500],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text('Delete Chat'),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        width: size.width,
        // color: Colors.yellow,
        padding: const EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: 6,
          right: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CachedImageWidget(
              height: 50,
              width: 50,
              radius: 4,
              imgUrl:
                  'https://i.pinimg.com/736x/25/78/61/25786134576ce0344893b33a051160b1.jpg',
            ),
            // const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat.username,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  chat.postTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  chat.message,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            chat.unReadCount! > 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        chat.lastMessageAt,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: Center(
                          child: Text(
                            chat.unReadCount.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Text(
                    chat.lastMessageAt,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
