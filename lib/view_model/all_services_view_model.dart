import 'package:flutter/material.dart';

import '../model/service_model.dart';
import '../repo/service_repo.dart';

class AllServicesViewModel extends ChangeNotifier {
  final serviceRepo = ServiceRepository();
  List<ServiceModel> allServiceList = [];

  bool _loading = false;
  bool get loading => _loading;
  setLoad(bool status) {
    _loading = status;
    notifyListeners();
  }

  Future<void> getAllServicesList(
    BuildContext context,
  ) async {
    setLoad(true);
    Future.delayed(const Duration(seconds: 1)).then(
      (value) async {
        // getMyPosts = getPosts();
        if (allServiceList.isEmpty) {
          allServiceList =
              await serviceRepo.fetchAllServicesList(serviceType: '0');
        }
        setLoad(false);
      },
    );
    notifyListeners();
  }
}
