import 'package:bizhub_new/components/deafult_button.dart';
import 'package:bizhub_new/utils/mytheme.dart';
import 'package:bizhub_new/view_model/my_service_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/routes/routes_name.dart';
import '../../widgets/common/app_bar.dart';

class SelectService extends StatelessWidget {
  const SelectService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final post = Provider.of<MyServiceViewModel>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: myAppBar(context: context, appBarTitle: 'Select Your Service'),
      bottomSheet: post.isPoster != null
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  height: size.height * 0.10,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
                    child: DeafultButton(
                      title: 'Continue',
                      onPress: () {
                        Navigator.pushNamed(context, RouteName.selectCategory);
                        // print(post.isPoster);
                      },
                      // onPress: null,
                    ),
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
            selectType(
              size: size,
              mainAxisAlignment: MainAxisAlignment.start,
              serviceType: 'POST',
              selectType: (post.isPoster != null && post.isPoster == true)
                  ? true
                  : false,
              onTap: () => post.selectServiceType(true),
            ),
            selectType(
              size: size,
              mainAxisAlignment: MainAxisAlignment.center,
              serviceType: 'SERVICE',
              selectType: (post.isPoster != null && post.isPoster == false)
                  ? true
                  : false,
              onTap: () => post.selectServiceType(false),
            ),
          ],
        ),
      ),
    );
  }

  Widget selectType({
    required Size size,
    required MainAxisAlignment mainAxisAlignment,
    required String serviceType,
    required bool selectType,
    required Function onTap,
  }) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        GestureDetector(
          onTap: () => onTap(),
          child: Container(
            width: size.width * 0.45,
            height: size.height * 0.35,
            decoration: BoxDecoration(
              color: selectType ? MyTheme.greenColor : Colors.white,
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
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: Text(serviceType),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
