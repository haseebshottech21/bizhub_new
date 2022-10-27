import 'package:bizhub_new/utils/mytheme.dart';
import 'package:flutter/material.dart';

class DeafultButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPress;
  final bool isloading;
  final Color color;
  const DeafultButton({
    required this.title,
    required this.onPress,
    this.isloading = false,
    this.color = MyTheme.greenColor,
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
            borderRadius: BorderRadius.circular(2),
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
  final String title;
  final VoidCallback? onPress;
  final IconData icon;
  final Color color;
  const DeafultIconButton({
    required this.title,
    required this.onPress,
    required this.icon,
    this.color = MyTheme.greenColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(10.0),
        elevation: 0,
        backgroundColor: color,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
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
