// import 'dart:ui';
// import 'package:bizhub_new/utils/mytheme.dart';
import 'package:bizhub_new/view_model/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/deafult_button.dart';
import '../../utils/routes/routes_name.dart';
import '../../widgets/common/app_bar.dart';
import 'component/category_item.dart';

class SelectCategory extends StatefulWidget {
  const SelectCategory({Key? key}) : super(key: key);

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllData();
    });
    super.initState();
  }

  getAllData() {
    final categories = Provider.of<CategoryViewModel>(context, listen: false);
    categories.getCategoriesList(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final category = Provider.of<CategoryViewModel>(context, listen: true);

    var image =
        'https://www.familyhandyman.com/wp-content/uploads/2020/03/4e43e850-61u5vx9jfvl._ac_sl1000_.jpg';

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: myAppBar(context: context, appBarTitle: 'Select Category'),
      bottomSheet: category.categoryId.isNotEmpty
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  height: size.height * 0.10,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
                    child: DeafultButton(
                      title: 'Continue',
                      onPress: () {
                        Navigator.pushNamed(context, RouteName.createPost);
                      },
                      // onPress: null,
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox(),
      // body: categoryItem(size: size),
      body: Consumer<CategoryViewModel>(
        builder: (context, categoryViewModel, _) {
          if (categoryViewModel.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final category = categoryViewModel.categoryList;
            return GridView(
              padding: const EdgeInsets.only(
                bottom: 120,
                top: 25,
                left: 12,
                right: 12,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                // crossAxisCount: 2,
                // mainAxisSpacing: 16,
                // crossAxisSpacing: 20,
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              children: List.generate(
                category.length,
                (index) {
                  return CategoryItem(category: category[index]);
                },
              ),
            );
          }
        },
      ),

      // body: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      //   child: Column(
      //     children: [
      //       Container(
      //         height: size.height * 0.25,
      //         width: size.width * 0.45,
      //         decoration: BoxDecoration(
      //           color: Colors.yellow,
      //           borderRadius: BorderRadius.circular(20),
      //           boxShadow: kElevationToShadow[8],
      //           border: Border.all(
      //             color: MyTheme.greenColor,
      //             width: 4,
      //           ),
      //           image: DecorationImage(
      //             image: NetworkImage(image),
      //             fit: BoxFit.cover,
      //           ),
      //         ),
      //         child: Stack(
      //           children: [
      //             Align(
      //               alignment: Alignment.bottomCenter,
      //               child: BackdropFilter(
      //                 filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
      //                 child: Container(
      //                   height: 40,
      //                   decoration: BoxDecoration(
      //                     // boxShadow: [
      //                     //   BoxShadow(
      //                     //     color: Colors.white,
      //                     //     // blurRadius: 2,
      //                     //   ),
      //                     // ],
      //                     color: Colors.grey.withOpacity(0.5),
      //                     border: Border.all(
      //                       color: Colors.white.withOpacity(0.1),
      //                       width: 1,
      //                     ),
      //                     borderRadius: const BorderRadius.only(
      //                       bottomLeft: Radius.circular(16),
      //                       bottomRight: Radius.circular(16),
      //                     ),
      //                   ),
      //                   child: const Center(
      //                     child: Text(
      //                       'Electriction',
      //                       style: TextStyle(
      //                         fontWeight: FontWeight.w500,
      //                         color: Colors.white,
      //                         fontSize: 22,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       const SizedBox(height: 20),
      //       Container(
      //         height: size.height * 0.25,
      //         width: size.width * 0.45,
      //         decoration: BoxDecoration(
      //           color: Colors.yellow,
      //           border: Border.all(
      //             color: MyTheme.greenColor,
      //             width: 4,
      //           ),
      //           borderRadius: BorderRadius.circular(20),
      //           boxShadow: kElevationToShadow[8],
      //           image: DecorationImage(
      //             image: NetworkImage(image),
      //             fit: BoxFit.cover,
      //           ),
      //         ),
      //         child: Stack(
      //           children: [
      //             Align(
      //               alignment: Alignment.bottomCenter,
      //               child: BackdropFilter(
      //                 filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
      //                 child: Container(
      //                   height: 40,
      //                   decoration: BoxDecoration(
      //                     color: Colors.grey.withOpacity(0.7),
      //                     borderRadius: const BorderRadius.only(
      //                       bottomLeft: Radius.circular(20),
      //                       bottomRight: Radius.circular(20),
      //                     ),
      //                   ),
      //                   child: const Center(
      //                     child: Text(
      //                       'Electriction',
      //                       style: TextStyle(
      //                         fontWeight: FontWeight.w500,
      //                         color: Colors.white,
      //                         fontSize: 22,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
