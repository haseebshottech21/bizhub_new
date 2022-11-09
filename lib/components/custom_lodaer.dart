import 'package:bizhub_new/utils/mytheme.dart';
import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({
    Key? key,
    this.height,
    this.width,
    this.strokeWidth = 4.0,
  }) : super(key: key);

  final double? height, width;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          color: MyTheme.greenColor,
        ),
      ),
    );
  }
}
