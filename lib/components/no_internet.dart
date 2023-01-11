import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/mytheme.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: size.height * 0.05),
        const Icon(
          CupertinoIcons.wifi_exclamationmark,
          color: MyTheme.greenColor,
          size: 100,
        ),
        SizedBox(height: size.height * 0.02),
        const Text(
          'No Internet Connection',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: size.height * 0.005),
        const Text(
          'Please Check Your Internet',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: size.height * 0.02),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 6,
            backgroundColor: MyTheme.greenColor,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            fixedSize: Size(size.width * 0.40, 45),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(CupertinoIcons.arrow_clockwise),
              Text(
                'Try Again',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
