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
    final categoryViewModel = context.watch<CategoryViewModel>();

    return GestureDetector(
      onTap: () => context.read<CategoryViewModel>().selectCategory(
            category.catId.toString(),
          ),
      child: Container(
        decoration: BoxDecoration(
          color: categoryViewModel.categoryId == category.catId.toString()
              ? MyTheme.greenColor
              : Colors.white,
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
                    height: constraints.maxHeight * 0.55,
                    // width: constraints.maxWidth,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      category.catTitle.toString(),
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
