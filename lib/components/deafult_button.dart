import 'package:bizhub_new/utils/mytheme.dart';
import 'package:bizhub_new/utils/utils.dart';
import 'package:flutter/material.dart';

class DeafultButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPress;
  final bool isloading;
  final Color color;
  final double borderRadius;
  const DeafultButton({
    required this.title,
    required this.onPress,
    this.isloading = false,
    this.color = MyTheme.greenColor,
    this.borderRadius = 2,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
        onPressed: isloading ? null : onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Center(
          child: isloading
              ? Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Please Wait',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(width: 15),
                      SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 1.5,
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class DeafultIconButton extends StatelessWidget {
  final String title, loadingTitle;
  final VoidCallback? onPress;
  final IconData icon;
  final Color color;
  final bool isloading;
  const DeafultIconButton({
    required this.title,
    required this.onPress,
    required this.icon,
    this.isloading = false,
    this.loadingTitle = 'Please wait...',
    this.color = MyTheme.greenColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isloading ? null : onPress,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(10.0),
        elevation: 0,
        backgroundColor: color,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      child: isloading
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
                SizedBox(width: Utils.getDeviceType() == 'phone' ? 15 : 25),
                Text(
                  loadingTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
                SizedBox(width: Utils.getDeviceType() == 'phone' ? 15 : 25),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
    );
  }
}

class DefaultOutlineButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPress;
  final Color btnTextColor, backgroundColor, borderColor;
  final double borderRadius;
  final bool btnIcon;
  const DefaultOutlineButton({
    required this.title,
    required this.onPress,
    this.btnTextColor = Colors.black,
    this.borderColor = Colors.black54,
    this.backgroundColor = Colors.white,
    this.borderRadius = 2,
    this.btnIcon = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.white,
          backgroundColor: backgroundColor,
          shape: BeveledRectangleBorder(
            side: BorderSide(
              width: 0.5,
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: btnIcon == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: btnTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )
                : Text(
                    title,
                    style: TextStyle(
                      color: btnTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
