import 'package:bizhub_new/components/deafult_button.dart';
import 'package:bizhub_new/utils/mytheme.dart';
import 'package:bizhub_new/utils/shared_prefrences.dart';
import 'package:bizhub_new/view_model/all_services_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  getAllData() {
    final categories = Provider.of<CategoryViewModel>(context, listen: false);
    categories.getCategoriesList(context);
  }

  RangeValues currentRangeValues = const RangeValues(0, 2000);

  int selectedIndex = 0;
  // List<String> options = [
  //   'Woolha',
  //   'Flutter',
  //   'Dart',
  //   'Web develop',
  //   'App Develop',
  //   'Market'
  // ];

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<CategoryViewModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Filter',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Navigator.of(context).pop();
              // category.filterCatId = '';
              context.read<CategoryViewModel>().clearFilter();
            },
            child: const Text('Reset'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Price Range',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$ ${currentRangeValues.start.round().toString()}'),
                  const Text('-'),
                  Text('\$ ${currentRangeValues.end.round().toString()}'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SliderTheme(
                data: const SliderThemeData(trackHeight: 0.1),
                child: RangeSlider(
                  values: currentRangeValues,
                  min: 0,
                  max: 20000,
                  divisions: 200,
                  // labels: RangeLabels(
                  //   currentRangeValues.start.round().toString(),
                  //   currentRangeValues.end.round().toString(),
                  // ),
                  // onChanged: findServices.updateRangeValues,
                  onChanged: (value) {
                    setState(() {
                      currentRangeValues = value;
                    });
                  },
                  inactiveColor: Colors.grey,
                  activeColor: MyTheme.greenColor,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select Categories',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            // Padding(
            //   padding: const EdgeInsets.all(15.0),
            //   child: Column(
            //     children: <Widget>[
            //       Container(
            //         height: 30,
            //         child: buildChips(),
            //       ),
            //     ],
            //   ),
            // ),
            Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: List.generate(
                category.categoryList.length,
                (index) {
                  return ChoiceChip(
                    label: Text(
                      category.categoryList[index].catTitle.toString(),
                      style: TextStyle(
                        color: selectedIndex == index
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    selected: selectedIndex == index,
                    backgroundColor: Colors.grey.shade100,
                    selectedColor: MyTheme.greenColor,
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          selectedIndex = index;
                          category.setCategoryId(
                            category.categoryList[index].catId.toString(),
                          );
                        }
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            Consumer<AllServicesViewModel>(
              builder: (context, allServices, _) {
                return DeafultButton(
                  // isloading: allServices.loading,
                  title: 'Apply',
                  onPress: () async {
                    print('category: ${category.filterCatId}');
                    print(await Prefrences().getSharedPreferenceValue('catId'));
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
