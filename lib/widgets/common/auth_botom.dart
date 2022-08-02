import 'package:flutter/material.dart';
import '../../utils/mytheme.dart';

class AuthBottom extends StatelessWidget {
  final String title;
  final String text;
  final VoidCallback onTap;
  const AuthBottom({
    required this.title,
    required this.text,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: const BoxDecoration(
          color: MyTheme.whiteColor,
          border: Border(
            top: BorderSide(
              color: Colors.black54,
              width: 0.2,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 5),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                ),
              ),
            ),
            InkWell(
              onTap: onTap,
              child: Container(
                // margin: const EdgeInsets.only(right: 5),
                padding: const EdgeInsets.only(right: 5),
                child: Text(
                  text,
                  style: const TextStyle(
                    color: MyTheme.greenColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
