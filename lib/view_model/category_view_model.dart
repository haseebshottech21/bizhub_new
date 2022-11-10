import 'package:bizhub_new/model/category_model.dart';
import 'package:bizhub_new/repo/category_repo.dart';
import 'package:bizhub_new/utils/shared_prefrences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'all_services_view_model.dart';

class CategoryViewModel extends ChangeNotifier {
  final catRepo = CategoryRepository();
  final prefrence = Prefrences();
  List<CategoryModel> categoryList = [];
  Prefrences pref = Prefrences();

  String categoryId = '';
  String categoryName = '';

  // void selectCategoryId(String catId, String catName) {
  //   categoryId = catId;
  //   categoryName = catName;
  //   notifyListeners();

  //   print(categoryId);
  //   print(categoryName);
  // }

  selectCategory(String id) {
    if (id == categoryId) {
      categoryId = '';
    } else {
      categoryId = id;
    }
    notifyListeners();
  }

  // int selectedIndex = 0;
  // String filterCatId = '';
  // selectFilterCategory(String catId) {
  //   if (catId.isNotEmpty) {
  //     filterCatId = catId;
  //   }
  //   print(filterCatId);
  // }

  // setCategoryId(String catId) async {
  //   if (filterCatId == '') {
  //     filterCatId = catId;
  //   }
  //   await prefrence.setSharedPreferenceValue('catId', catId);
  //   notifyListeners();
  // }

  // clearFilter() async {
  //   filterCatId = '';
  //   await prefrence.setSharedPreferenceValue('catId', filterCatId);
  //   notifyListeners();
  // }

  bool _loading = false;
  bool get loading => _loading;
  setLoad(bool status) {
    _loading = status;
    notifyListeners();
  }

  bool _btnLoading = false;
  bool get btnLoading => _btnLoading;
  setBtnLoad(bool status) {
    _btnLoading = status;
    notifyListeners();
  }

  // getCategoriesList() async {
  //   setLoad(true);
  //   post = (await repo.getListPostData());
  //   setLoad(false);

  //   notifyListeners();
  //   // print(post.length);
  // }

  Future<void> getCategoriesList(
    BuildContext context,
  ) async {
    setLoad(true);
    if (categoryList.isEmpty) {
      categoryList = await catRepo.fetchAllCategories();
    }
    setLoad(false);
    notifyListeners();
  }

  // FILTER
  int selectedIndex = 0;
  bool selected = false;
  List<String> selectedIndexList = [];

  // clearFilter() async {
  //   filterCatId = '';
  //   await prefrence.setSharedPreferenceValue('catId', filterCatId);
  //   notifyListeners();
  // }

  selectFilterCategory(int index, String id) {
    selectedIndexList.add(id);
    notifyListeners();
  }

  unSelectCategory(int index, String id) {
    selectedIndexList.removeWhere((element) => element == id);
    notifyListeners();
  }

  onChangeSelect(bool select, int index, String id) {
    if (select) {
      selectFilterCategory(index, id);
    } else {
      unSelectCategory(index, id);
    }
    notifyListeners();
  }

  Future<void> setAndApplyWithCategory(
    BuildContext context,
  ) async {
    setBtnLoad(true);
    Future.delayed(const Duration(seconds: 2)).then((value) async {
      pref.setSharedPreferenceListValue("categories", selectedIndexList);
      setBtnLoad(false);
      Navigator.of(context).pop();
      await Provider.of<AllServicesViewModel>(context, listen: false)
          .getAllServicesList(context: context);
    });
    notifyListeners();
  }
}
