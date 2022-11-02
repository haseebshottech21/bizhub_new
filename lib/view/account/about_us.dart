import 'package:flutter/material.dart';
import '../../utils/mytheme.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.greenColor,
        title: const Text(
          'About Us',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'About Us',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'BizHub is todays modern job Market! We were created to not only make your life easier, by just posting what you need done and allowing people to come to you.  We are here to connect you to the help you need with a simple free post . A  place like never created before! A work platform where you  can find jobs or services from professionals to new entrepreneurs. Grow your community, help those around you, build your brand while  earning extra income . We are BizHub and we are here to help.',
              style: TextStyle(
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
