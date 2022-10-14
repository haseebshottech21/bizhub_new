import 'package:flutter/material.dart';

class TestNavigation extends StatelessWidget {
  const TestNavigation({Key? key}) : super(key: key);

  static const routeName = '/test';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('LOGIN'),
      ),
    );
  }
}
