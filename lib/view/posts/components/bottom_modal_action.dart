import 'package:flutter/material.dart';

class BottomModalAction extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback? onTap;
  const BottomModalAction({
    required this.text,
    this.onTap,
    this.color = Colors.black,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8,
          left: 16,
          bottom: 8,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: color,
          ),
        ),
      ),
    );
  }
}
