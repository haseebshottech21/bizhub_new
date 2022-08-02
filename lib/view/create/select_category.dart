import 'package:bizhub_new/utils/mytheme.dart';
import 'package:flutter/material.dart';

import '../../components/deafult_button.dart';
import '../../utils/routes/routes_name.dart';
import '../../widgets/common/app_bar.dart';

class SelectCategory extends StatelessWidget {
  const SelectCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool goNext = true;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: myAppBar(context: context, appBarTitle: 'Select Category'),

      bottomSheet: goNext == true
          ? SafeArea(
              child: Container(
                height: size.height * 0.10,
                // decoration: const BoxDecoration(
                //   border: Border(
                //     top: BorderSide(
                //       color: Colors.black54,
                //       width: 0.05,
                //     ),
                //   ),
                // ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
                  child: DeafultButton(
                    title: 'Continue',
                    onPress: () {
                      Navigator.pushNamed(context, RouteName.createPost);
                    },
                    // onPress: null,
                  ),
                ),
              ),
            )
          : const SizedBox(),
      // body: categoryItem(size: size),
      body: GridView(
        padding:
            const EdgeInsets.only(bottom: 100, top: 20, left: 10, right: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        children: List.generate(
          10,
          (index) {
            return const CategoryItem();
          },
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Container(
      // width: size.width * 0.40,
      // height: size.height * 0.15,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: kElevationToShadow[4],
        // border: Border.all(color: MyTheme.greenColor, width: 2),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
                child: Image.asset(
                  'assets/images/developer.png',
                  fit: BoxFit.fill,
                  height: constraints.maxHeight * 0.60,
                  // width: constraints.maxWidth,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Center(
                  child: Text('WORKER'),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
