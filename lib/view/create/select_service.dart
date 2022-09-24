import 'package:bizhub_new/components/deafult_button.dart';
import 'package:flutter/material.dart';
import '../../utils/routes/routes_name.dart';
import '../../widgets/common/app_bar.dart';

class SelectService extends StatelessWidget {
  const SelectService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool goNext = true;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: myAppBar(context: context, appBarTitle: 'Select Your Service'),
      bottomSheet: goNext == true
          ? SafeArea(
              child: SizedBox(
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
                      Navigator.pushNamed(context, RouteName.selectCategory);
                    },
                    // onPress: null,
                  ),
                ),
              ),
            )
          : const SizedBox(),
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.only(top: 80, left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            selectType(size, MainAxisAlignment.start),
            selectType(size, MainAxisAlignment.center),
          ],
        ),
      ),
    );
  }

  Widget selectType(
    Size size,
    MainAxisAlignment mainAxisAlignment,
  ) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Container(
          width: size.width * 0.45,
          height: size.height * 0.35,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: kElevationToShadow[6],
            // border: Border.all(color: Colors.green),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                    child: Image.asset(
                      'assets/images/worker.png',
                      fit: BoxFit.fill,
                      height: constraints.maxHeight * 0.80,
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
        ),
      ],
    );
  }
}
