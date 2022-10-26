import 'package:flutter/material.dart';
import '../../../model/message_model.dart';
import '../../../utils/mytheme.dart';

class OfferMessageItem extends StatelessWidget {
  const OfferMessageItem({
    Key? key,
    required this.message,
    this.isMe = true,
  }) : super(key: key);

  final MessageModel message;
  final bool? isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 250),
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
          margin: const EdgeInsets.only(
            right: 8,
            left: 8,
            bottom: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: isMe == false
                ? const BorderRadius.only(
                    // bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  )
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    // bottomRight: Radius.circular(6),
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
            color: MyTheme.greenColor,
          ),
          child: Column(
            crossAxisAlignment: isMe == true
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              const Text(
                'MY OFFER',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
                // style: theme.textTheme.bodyText2
                //     ?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 2),
              Text(
                '\$ ${message.offer}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
                // style: theme.textTheme.bodyText2
                //     ?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 6),
              Text(
                // '2 : 40 am',
                message.createdAt.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                // style: theme.textTheme.bodySmall
                //     ?.copyWith(color: Colors.grey.shade300),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MessageItem extends StatelessWidget {
  const MessageItem({
    Key? key,
    required this.message,
    this.isMe = true,
  }) : super(key: key);

  final MessageModel message;
  final bool? isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 250),
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
          margin: const EdgeInsets.only(
            right: 8,
            bottom: 8,
            left: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: isMe == false
                ? const BorderRadius.only(
                    // bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  )
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    // bottomRight: Radius.circular(6),
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
            color: isMe == false ? MyTheme.blueBorder : MyTheme.statusBar,
          ),
          child: Column(
            crossAxisAlignment: isMe == true
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 2),
              Text(
                message.message.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                // style: theme.textTheme.bodyText2
                //     ?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                // '2 : 55 am',
                message.createdAt.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                ),
                // style: theme.textTheme.bodySmall
                //     ?.copyWith(color: Colors.grey.shade300),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
