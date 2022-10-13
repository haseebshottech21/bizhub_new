import 'package:bizhub_new/utils/app_url.dart';
import 'package:flutter/material.dart';
import '../../../model/chat_model.dart';
// import '../../../utils/routes/routes_name.dart';
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

    // print(chat.message!.message);

    // return Container();

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: InkWell(
        onTap: onTap,
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
                      child: const Text('Delete Chat'),
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
            top: 10,
            bottom: 10,
            left: 8,
            right: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CachedImageWidget(
                height: 50,
                width: 50,
                radius: 4,
                // imgUrl:
                //     'https://i.pinimg.com/736x/25/78/61/25786134576ce0344893b33a051160b1.jpg',
                imgUrl: AppUrl.baseUrl + chat.user!.image.toString(),
              ),
              // const SizedBox(width: 10),
              SizedBox(width: size.width * 0.02),
              SizedBox(
                width: size.width * 0.50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   '${chat.user!.firstName!.substring(0, 1)} ${chat.user!.lastName}',
                    //   style: const TextStyle(
                    //     fontWeight: FontWeight.w500,
                    //     fontSize: 14,
                    //   ),
                    // ),
                    // SizedBox(height: size.height * 0.002),
                    Text(
                      chat.service!.serviceTitle.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: size.height * 0.002),
                    if (chat.message!.offer == null)
                      Text(
                        chat.message!.message.toString(),
                        // chat.message!.offer == 'null'
                        //     ? chat.message!.message.toString()
                        //     : chat.message!.offer.toString(),
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    if (chat.message!.message == null)
                      Text(
                        'Offer : ${chat.message!.offer}',
                        // chat.message!.offer == 'null'
                        //     ? chat.message!.message.toString()
                        //     : chat.message!.offer.toString(),
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
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
