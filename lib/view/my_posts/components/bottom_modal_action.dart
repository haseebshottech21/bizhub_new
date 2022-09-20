import 'package:flutter/material.dart';
import '../../../widgets/common/dialog_box.dart';

class BottomModalAction extends StatelessWidget {
  final String text;
  final Color color;
  const BottomModalAction({
    required this.text,
    this.color = Colors.black,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        Navigator.of(context).pop();
        simpleDialog(
          context: context,
          title: 'Confirm Delete',
          subTitle: 'Are you sure you want to Delete ?',
          onPressed: () {},
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          top: 6,
          left: 10,
          bottom: 8,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            color: color,
          ),
        ),
      ),
    );
  }
}
