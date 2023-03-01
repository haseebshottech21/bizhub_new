import 'package:bizhub_new/components/custom_loader.dart';
import 'package:bizhub_new/components/deafult_button.dart';
import 'package:bizhub_new/utils/mytheme.dart';
import 'package:bizhub_new/utils/shared_prefrences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../language/language_constant.dart';
import '../../view_model/category_view_model.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllData();
    });
    super.initState();
  }

  Prefrences pref = Prefrences();

  getAllData() async {
    final categories = Provider.of<CategoryViewModel>(context, listen: false);
    await categories.checkAuth();
    await categories.getMiles();

    categories.selectedIndexList =
        await pref.getSharedPreferenceListValue('categories');
  }

  RangeValues currentRangeValues = const RangeValues(0, 2000);

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<CategoryViewModel>(context, listen: true);
    // final location = Provider.of<LocationViewModel>(context, listen: true);

    // print(category.deafultMiles);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          translation(context).filterText,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: Consumer<CategoryViewModel>(builder: (context, provider, _) {
          return IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
              // provider.clearDistance();
            },
          );
        }),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              onPressed: () {
                context.read<CategoryViewModel>().clearFilter(context);
              },
              child: Text(
                translation(context).resetText,
                style: const TextStyle(
                  fontSize: 17,
                  color: MyTheme.greenColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: category.loading
          ? const CustomLoader()
          : Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Text(
                  //   'Price Range',
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text('\$ ${currentRangeValues.start.round().toString()}'),
                  //       const Text('-'),
                  //       Text('\$ ${currentRangeValues.end.round().toString()}'),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   child: SliderTheme(
                  //     data: const SliderThemeData(trackHeight: 0.1),
                  //     child: RangeSlider(
                  //       values: currentRangeValues,
                  //       min: 0,
                  //       max: 20000,
                  //       divisions: 200,
                  //       // labels: RangeLabels(
                  //       //   currentRangeValues.start.round().toString(),
                  //       //   currentRangeValues.end.round().toString(),
                  //       // ),
                  //       // onChanged: findServices.updateRangeValues,
                  //       onChanged: (value) {
                  //         setState(() {
                  //           currentRangeValues = value;
                  //         });
                  //       },
                  //       inactiveColor: Colors.grey,
                  //       activeColor: MyTheme.greenColor,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  Text(
                    translation(context).selectCategoriesText,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Consumer<CategoryViewModel>(
                    builder: (context, categoryViewModel, _) {
                      return Wrap(
                        spacing: 6.0,
                        runSpacing: 6.0,
                        children: List.generate(
                          category.categoryList.length,
                          (index) {
                            return ChoiceChip(
                              label: Text(
                                category.categoryList[index].catTitle
                                    .toString(),
                                style: TextStyle(
                                  // color: selectedIndex == index
                                  color: categoryViewModel.selectedIndexList
                                          .contains(
                                    category.categoryList[index].catId
                                        .toString(),
                                  )
                                      ? Colors.white
                                      : Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              // selected: selectedIndex == index,
                              selected:
                                  categoryViewModel.selectedIndexList.contains(
                                category.categoryList[index].catId.toString(),
                              ),
                              avatar:
                                  categoryViewModel.selectedIndexList.contains(
                                category.categoryList[index].catId.toString(),
                              )
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 16,
                                        )
                                      : null,
                              backgroundColor: Colors.grey.shade100,
                              selectedColor: MyTheme.greenColor,
                              onSelected: (bool selected) {
                                categoryViewModel.onChangeSelect(
                                  selected,
                                  index,
                                  category.categoryList[index].catId.toString(),
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Select Distance',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Consumer<CategoryViewModel>(
                    builder: (context, provider, _) {
                      return Wrap(
                        runSpacing: 8.0,
                        spacing: 8.0,
                        children: List.generate(
                          provider.selectedMilesList.length,
                          (index) {
                            return GestureDetector(
                              onTap: () {
                                provider.selectMiles(
                                  provider.selectedMilesList[index].miles,
                                );
                                // print(provider.selectedMilesList[index].miles);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 10.0,
                                ),
                                decoration: BoxDecoration(
                                  color: provider.selectedMilesList[index]
                                              .selectMiles ==
                                          true
                                      ? MyTheme.greenColor
                                      : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  provider.selectedMilesList[index].miles,
                                  style: TextStyle(
                                    color: provider.selectedMilesList[index]
                                                .selectMiles ==
                                            true
                                        ? Colors.white
                                        : Colors.black54,
                                    // fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  // Consumer<CategoryViewModel>(
                  //   builder: (context, provider, _) {
                  //     return Wrap(
                  //       runSpacing: 8.0,
                  //       spacing: 8.0,
                  //       children: List.generate(
                  //         provider.radius.length,
                  //         (index) {
                  //           return GestureDetector(
                  //             onTap: () {
                  //               provider.selectMiles(
                  //                 provider.radius[index]['miles'],
                  //               );
                  //               print(provider.deafultMiles);
                  //             },
                  //             child: Container(
                  //               padding: const EdgeInsets.symmetric(
                  //                 vertical: 8.0,
                  //                 horizontal: 10.0,
                  //               ),
                  //               decoration: BoxDecoration(
                  //                 color:
                  //                     provider.radius[index]['status'] == true
                  //                         ? MyTheme.greenColor
                  //                         : Colors.grey.shade100,
                  //                 borderRadius: BorderRadius.circular(8.0),
                  //               ),
                  //               child: Text(
                  //                 provider.radius[index]['miles'],
                  //                 style: TextStyle(
                  //                   color:
                  //                       provider.radius[index]['status'] == true
                  //                           ? Colors.white
                  //                           : Colors.black,
                  //                 ),
                  //               ),
                  //             ),
                  //           );
                  //         },
                  //       ),
                  //     );
                  //   },
                  // ),
                  const SizedBox(height: 30),
                  Consumer<CategoryViewModel>(
                    builder: (context, categoriesViewModel, _) {
                      // print(categoriesViewModel.deafultMiles);
                      return DeafultButton(
                        title: translation(context).applyText,
                        isloading: categoriesViewModel.btnLoading,
                        onPress:
                            categoriesViewModel.selectedIndexList.isEmpty &&
                                    (categoriesViewModel.deafultMiles == null ||
                                        categoriesViewModel.deafultMiles == '')
                                ? null
                                : () {
                                    categoriesViewModel
                                        .setAndApplyWithCategory(context);
                                  },
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
