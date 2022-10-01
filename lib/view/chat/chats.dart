// import 'package:bizhub_new/utils/dummy_data.dart';
import 'package:bizhub_new/utils/mytheme.dart';
import 'package:bizhub_new/view/chat/poster/poster_chats.dart';
import 'package:bizhub_new/view/chat/worker/worker_chats.dart';
import 'package:flutter/material.dart';
// import 'component/chat_item.dart';

class Chats extends StatelessWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final chats = getChat();

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
        body: const TabBarView(
          children: [
            PosterChats(),
            WorkerChats(),
          ],
        ),
      ),
    );
  }
}
