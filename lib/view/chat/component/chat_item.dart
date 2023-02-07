import 'dart:io';
import 'package:bizhub_new/utils/app_url.dart';
import 'package:bizhub_new/utils/mytheme.dart';
import 'package:flutter/material.dart';
import '../../../model/chat_model.dart';
import '../../../utils/utils.dart';
import '../../../widgets/common/cached_image.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    required this.chat,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final ChatModel chat;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final phoneDevice = Utils.getDeviceType() == 'phone';

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: InkWell(
        onTap: onTap,
        // onLongPress: () {},
        child: Container(
          width: size.width,
          // color: Colors.yellow,
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 4,
            right: 6,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              chat.user!.image == null
                  ? Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 40,
                        color: MyTheme.greenColor,
                      ),
                    )
                  : CachedImageWidget(
                      height: 60,
                      width: 60,
                      radius: 4,
                      imgUrl: AppUrl.baseUrl + chat.user!.image.toString(),
                    ),
              SizedBox(width: size.width * 0.02),
              SizedBox(
                width: phoneDevice ? size.width * 0.58 : size.width * 0.62,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chat.service!.serviceTitle.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: size.height * 0.003),
                    if (chat.message!.offer == null)
                      Text(
                        chat.message!.message.toString(),
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    if (chat.message!.message == null)
                      Text(
                        'Offer : ${chat.message!.offer}',
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                // height: 50,
                width: size.width * 0.18,
                // color: Colors.green,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      chat.message!.createdAt.toString(),
                      style: TextStyle(
                        fontSize: Platform.isIOS ? 9 : 10,
                        fontWeight: chat.unreadMessage! > 0
                            ? FontWeight.w500
                            : FontWeight.w400,
                        color: chat.unreadMessage! > 0
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ),
                    SizedBox(height: size.height * 0.008),
                    if (chat.unreadMessage! > 0)
                      CircleAvatar(
                        radius: 11,
                        backgroundColor: MyTheme.greenColor,
                        child: Center(
                          child: Text(
                            chat.unreadMessage.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
