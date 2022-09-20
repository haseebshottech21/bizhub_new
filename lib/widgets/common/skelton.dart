import 'package:flutter/material.dart';

class Skelton extends StatelessWidget {
  final double? height, width;
  const Skelton({
    this.height,
    this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
    );
  }
}

class PostItemSkelton extends StatelessWidget {
  const PostItemSkelton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Skelton(
          height: 80,
          width: 80,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Skelton(),
              const SizedBox(height: 8),
              const Skelton(width: 160),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Skelton(width: 50),
                  Skelton(width: 85, height: 35),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
