import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bizhub_new/model/category_model.dart';
import 'package:bizhub_new/repo/category_repo.dart';
import 'package:bizhub_new/utils/shared_prefrences.dart';

import 'all_services_view_model.dart';

class CategoryViewModel extends ChangeNotifier {
  final catRepo = CategoryRepository();
  final prefrence = Prefrences();
  List<CategoryModel> categoryList = [];
  Prefrences pref = Prefrences();
  String? token;

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

  Future<void> checkAuth() async {
    token = await prefrence.getSharedPreferenceValue('token');
    if (token == null || token == '') {
      getCategoriesListWithoutAuth();
    } else {
      getCategoriesList();
    }
  }

  Future<void> getCategoriesList() async {
    setLoad(true);
    if (categoryList.isEmpty) {
      categoryList = await catRepo.fetchAllCategories();
    }
    setLoad(false);
    notifyListeners();
  }

  Future<void> getCategoriesListWithoutAuth() async {
    setLoad(true);
    if (categoryList.isEmpty) {
      categoryList = await catRepo.fetchAllCategoriesWithouAuth();
    }
    setLoad(false);
    notifyListeners();
  }

  // FILTER
  int selectedIndex = 0;
  String? deafultMiles;
  bool selected = false;
  List<String> selectedIndexList = [];
  List<MilesModel> selectedMilesList = [];

  clearFilter(BuildContext context) async {
    clearMiles();
    Provider.of<AllServicesViewModel>(context, listen: false).page = 1;
    Provider.of<AllServicesViewModel>(context, listen: false).hasNextPage =
        true;
    Provider.of<AllServicesViewModel>(context, listen: false)
        .getLatLongAndMiles();
    token = await prefrence.getSharedPreferenceValue('token');
    selectedIndexList = [];

    pref.setSharedPreferenceListValue("categories", selectedIndexList);
    Future.delayed(Duration.zero).then((value) async {
      Navigator.of(context).pop();
      if (token == null || token == '') {
        await Provider.of<AllServicesViewModel>(context, listen: false)
            .getAllServiceWithoutAuth();
      } else {
        await Provider.of<AllServicesViewModel>(context, listen: false)
            .getAllService();
      }
    });

    notifyListeners();
  }

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
    Provider.of<AllServicesViewModel>(context, listen: false).page = 1;
    Provider.of<AllServicesViewModel>(context, listen: false).hasNextPage =
        true;
    Provider.of<AllServicesViewModel>(context, listen: false)
        .getLatLongAndMiles();
    setBtnLoad(true);
    token = await prefrence.getSharedPreferenceValue('token');
    Future.delayed(Duration.zero).then((value) async {
      pref.setSharedPreferenceListValue("categories", selectedIndexList);
      setBtnLoad(false);
      Navigator.of(context).pop();
      // final serviceProvider =
      //     Provider.of<AllServicesViewModel>(context, listen: false);
      if (token == null || token == '') {
        // getCategoriesListWithoutAuth();
        await Provider.of<AllServicesViewModel>(context, listen: false)
            .getAllServiceWithoutAuth();
      } else {
        // getCategoriesList();
        await Provider.of<AllServicesViewModel>(context, listen: false)
            .getAllService();
      }
    });
    notifyListeners();
  }

  getMiles() async {
    if (selectedMilesList.isEmpty || selectedMilesList == []) {
      selectedMilesList.addAll(
        {
          MilesModel(
            miles: '5 miles',
            selectMiles: false,
          ),
          MilesModel(
            miles: '10 miles',
            selectMiles: false,
          ),
          MilesModel(
            miles: '20 miles',
            selectMiles: false,
          ),
          MilesModel(
            miles: '50 miles',
            selectMiles: false,
          ),
          MilesModel(
            miles: '100 miles',
            selectMiles: false,
          ),
          MilesModel(
            miles: '200 miles',
            selectMiles: false,
          ),
          MilesModel(
            miles: '500 miles',
            selectMiles: false,
          ),
        },
      );
    }
    // print(selectedIndexList);
    // await pref.setSharedPreferenceListValue('milesList', selectedMilesList);
  }

  void selectMiles(String name) async {
    for (var e in selectedMilesList) {
      if (name == e.miles) {
        selectedMilesList[selectedMilesList.indexOf(e)].selectMiles = true;
        deafultMiles = name;
        await pref.setSharedPreferenceValue('myLocationMiles', deafultMiles!);
      } else {
        selectedMilesList[selectedMilesList.indexOf(e)].selectMiles = false;
      }
    }
    notifyListeners();
  }

  void clearMiles() async {
    for (var e in selectedMilesList) {
      selectedMilesList[selectedMilesList.indexOf(e)].selectMiles = false;
      deafultMiles = '';
      await pref.setSharedPreferenceValue('myLocationMiles', deafultMiles!);
    }
    notifyListeners();
  }
}

class MilesModel {
  String miles;
  bool selectMiles;

  MilesModel({
    required this.miles,
    required this.selectMiles,
  });
}
