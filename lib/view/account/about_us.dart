import 'package:flutter/material.dart';
import '../../language/language_constant.dart';
import '../../utils/mytheme.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.greenColor,
        title: Text(
          translation(context).aboutUs,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              translation(context).aboutUs,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              translation(context).aboutUsDescription,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
