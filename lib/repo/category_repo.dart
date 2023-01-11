import 'dart:convert';
import 'package:bizhub_new/model/category_model.dart';
import '../utils/app_url.dart';
import '../utils/shared_prefrences.dart';
import 'package:http/http.dart' as http;

import '../utils/utils.dart';

class CategoryRepository {
  final prefrence = Prefrences();

  Future<List<CategoryModel>> fetchAllCategories() async {
    try {
      final response = await http.get(
        Uri.parse(AppUrl.showCategoriesEndPoint),
        headers: await AppUrl().headerWithAuth(),
      );
      // print(response.body);
      final loadedData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<CategoryModel> categoryList = (loadedData['data'] as List)
            .map((e) => CategoryModel.fromJson(e))
            .toList();
        return categoryList;
      } else {
        Utils.toastMessage(loadedData['message']);
      }
    } catch (e) {
      Utils.toastMessage(e.toString());
    }
    return [];
  }

  Future<List<CategoryModel>> fetchAllCategoriesWithouAuth() async {
    try {
      final response = await http.get(
        Uri.parse(AppUrl.withoutAuthShowCategoriesEndPoint),
        headers: AppUrl.header,
      );
      // print(response.body);
      final loadedData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<CategoryModel> categoryList = (loadedData['data'] as List)
            .map((e) => CategoryModel.fromJson(e))
            .toList();
        return categoryList;
      } else {
        Utils.toastMessage(loadedData['message']);
      }
    } catch (e) {
      Utils.toastMessage(e.toString());
    }
    return [];
  }
}
