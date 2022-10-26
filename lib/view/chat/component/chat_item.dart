import 'package:bizhub_new/utils/app_url.dart';
import 'package:bizhub_new/utils/mytheme.dart';
import 'package:flutter/material.dart';
import '../../../model/chat_model.dart';
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

    // print(chat.user!.image);

    // return Container();

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: InkWell(
        onTap: onTap,
        onLongPress: () {},
        child: Container(
          width: size.width,
          // color: Colors.yellow,
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 8,
            right: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              chat.user!.image == null
                  ? Container(
                      height: 55,
                      width: 55,
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
                      height: 55,
                      width: 55,
                      radius: 4,
                      imgUrl: AppUrl.baseUrl + chat.user!.image.toString(),
                    ),
              SizedBox(width: size.width * 0.02),
              SizedBox(
                width: size.width * 0.56,
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
                    SizedBox(height: size.height * 0.002),
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
              // const Spacer(),

              // chat.unReadCount! > 0
              //     ? Column(
              //         crossAxisAlignment: CrossAxisAlignment.end,
              //         children: [
              //           Text(
              //             chat.lastMessageAt,
              //             style: const TextStyle(
              //               fontSize: 11,
              //               fontWeight: FontWeight.w400,
              //               color: Colors.grey,
              //             ),
              //           ),
              //           SizedBox(height: size.height * 0.008),
              //           Container(
              //             padding: const EdgeInsets.all(6),
              //             decoration: const BoxDecoration(
              //               shape: BoxShape.circle,
              //               color: Colors.red,
              //             ),
              //             child: Center(
              //               child: Text(
              //                 chat.unReadCount.toString(),
              //                 style: const TextStyle(
              //                   fontWeight: FontWeight.w500,
              //                   color: Colors.white,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ],
              //       )
              //     :
              Text(
                chat.message!.createdAt.toString(),
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
