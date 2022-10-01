import 'package:flutter/material.dart';
import '../../../model/message_model.dart';
import '../../../utils/mytheme.dart';

class OfferMessageItem extends StatelessWidget {
  const OfferMessageItem({
    Key? key,
    required this.message,
  }) : super(key: key);

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 250),
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(
            left: 8,
            bottom: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: MyTheme.greenColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'MY OFFER  ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
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
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                // style: theme.textTheme.bodyText2
                //     ?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 6),
              const Text(
                '2 : 40 am',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
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
