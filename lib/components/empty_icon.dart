import 'package:flutter/material.dart';
import '../utils/mytheme.dart';

class EmptyIcon extends StatelessWidget {
  const EmptyIcon({
    this.radius = 26,
    Key? key,
  }) : super(key: key);

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey.shade100,
      child: const Icon(
        Icons.person,
        color: MyTheme.greenColor,
        size: 28,
      ),
    );
  }
}
