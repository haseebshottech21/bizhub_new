// import 'dart:ui';
// import 'package:bizhub_new/utils/mytheme.dart';
import 'package:bizhub_new/view_model/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/deafult_button.dart';
import '../../utils/mytheme.dart';
import '../../utils/routes/routes_name.dart';
import '../../view_model/bottom_navigation_view_model.dart';
import '../../view_model/my_service_view_model.dart';
// import '../../widgets/common/app_bar.dart';
import '../../widgets/common/dialog_box.dart';
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

    // var image =
    //     'https://www.familyhandyman.com/wp-content/uploads/2020/03/4e43e850-61u5vx9jfvl._ac_sl1000_.jpg';

    return Scaffold(
      backgroundColor: Colors.grey[50],
      // appBar: myAppBar(context: context, appBarTitle: 'Select Category'),
      appBar: AppBar(
        backgroundColor: MyTheme.whiteColor,
        automaticallyImplyLeading: false,
        elevation: 3,
        leading: IconButton(
          onPressed: () {
            Provider.of<BottomNavigationViewModel>(context, listen: false)
                .toggleCurrentIndex(0);
            final service =
                Provider.of<MyServiceViewModel>(context, listen: false);
            // final category =
            //     Provider.of<CategoryViewModel>(context, listen: false);
            showDialog(
              context: context,
              builder: (_) => cancelDialog(
                context: context,
                title: 'Leave',
                subTitle: 'Are you sure you want to leave ?',
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteName.home,
                    (route) => false,
                  );
                  service.initailValue(context);
                  // post.isPoster = null;
                  // category.categoryId = '';
                  // category.categoryName = '';
                },
              ),
            );
          },
          icon: const Icon(
            Icons.clear,
            color: Colors.black,
            size: 22.0,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Select Category',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w400,
            fontSize: 17,
          ),
        ),
      ),
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
    );
  }
}
