import 'package:bizhub_new/utils/shared_prefrences.dart';
import 'package:flutter/material.dart';
import '../model/service_model.dart';
import '../repo/chat_repo.dart';
import '../repo/service_repo.dart';
import '../utils/utils.dart';

class AllServicesViewModel extends ChangeNotifier {
  final serviceRepo = ServiceRepository();
  final chatRepo = ChatRepository();
  final prefernce = Prefrences();
  List<ServiceModel> allServiceList = [];
  ServiceModel? serviceModel;
  bool nearByJobs = true;

  List<ServiceModel> displayList = [];

  void searchList(String value) {
    displayList = allServiceList
        .where((element) =>
            element.serviceTitle!.toLowerCase().contains(value.toLowerCase()))
        .toList();
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoad(bool status) {
    _loading = status;
    notifyListeners();
  }

  bool _offerLoading = false;
  bool get offerLoading => _offerLoading;
  setOfferLoad(bool status) {
    _offerLoading = status;
    notifyListeners();
  }

  selectType(bool type, BuildContext context) {
    nearByJobs = type;
    setLoad(true);
    Future.delayed(Duration.zero).then(
      (value) async {
        // getMyPosts = getPosts();
        // if (allServiceList.isEmpty) {
        allServiceList = await serviceRepo.fetchAllServicesList(
          serviceType: nearByJobs ? '0' : '1',
        );
        // }
        setLoad(false);
      },
    );
    Navigator.of(context).pop();
    notifyListeners();
    // print(isPoster);
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

  Future<void> getAllServiceDetail({
    required BuildContext context,
    required String serviceId,
  }) async {
    setLoad(true);
    Future.delayed(const Duration(seconds: 1)).then(
      (value) async {
        serviceModel = await serviceRepo.fetchAllService(serviceId: serviceId);
        setLoad(false);
      },
    );
    notifyListeners();
  }

  Future<void> sendOffer(
    // dynamic data,
    BuildContext context,
  ) async {
    setOfferLoad(true);
    // final loadedData = await chatRepo.sendOfferApi(data);
    // // print(loadedData);
    // if (loadedData == null) {
    //   setLoad(false);
    // } else if (loadedData != null) {
    Future.delayed(const Duration(seconds: 2)).then(
      (value) {
        setOfferLoad(false);
        Utils.toastMessage('Offer Send Successfully!');
        Navigator.of(context).pop();
      },
    );
  }
}
