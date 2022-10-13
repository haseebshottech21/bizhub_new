import 'package:bizhub_new/utils/app_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/category_model.dart';
import '../../../utils/mytheme.dart';
import '../../../view_model/category_view_model.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;

  const CategoryItem({
    required this.category,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var image =
    //     'https://www.familyhandyman.com/wp-content/uploads/2020/03/4e43e850-61u5vx9jfvl._ac_sl1000_.jpg';
    final size = MediaQuery.of(context).size;
    final categoryViewModel = context.watch<CategoryViewModel>();

    // print(category.catImage.toString());

    return GestureDetector(
      onTap: () => context.read<CategoryViewModel>().selectCategory(
            category.catId.toString(),
          ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade100,
          boxShadow: categoryViewModel.categoryId == category.catId.toString()
              ? kElevationToShadow[2]
              : kElevationToShadow[8],
          border: categoryViewModel.categoryId == category.catId.toString()
              ? Border.all(color: MyTheme.greenColor, width: 4)
              : null,
        ),
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(
                        AppUrl.baseUrl + category.catImage.toString(),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                categoryViewModel.categoryId == category.catId.toString()
                    ? const SizedBox()
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            stops: const [0.1, 0.9],
                            colors: [
                              // Colors.black.withOpacity(0.2),
                              // Colors.black.withOpacity(0.9),
                              MyTheme.greenColor.withOpacity(0.1),
                              MyTheme.greenColor.withOpacity(0.4),
                            ],
                          ),
                        ),
                      )
                // : const SizedBox()
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 40,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.grey.shade500.withOpacity(0.6),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Center(
                  child: Text(
                    category.catTitle.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),
            categoryViewModel.categoryId == category.catId.toString()
                ? Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1.5),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        CupertinoIcons.check_mark_circled_solid,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
