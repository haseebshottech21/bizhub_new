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
  ServiceDetalModel? serviceDetalModel;
  bool nearByJobs = true;

  List<ServiceModel> displayList = [];

  void searchList(String value) {
    displayList = allServiceList
        .where((element) =>
            element.serviceTitle!.toLowerCase().contains(value.toLowerCase()))
        .toList();
    notifyListeners();
  }

  // void clearList(TextEditingController value) {
  //   displayList.clear();
  //   // displayList = allServiceList
  //   //     .where((element) =>
  //   //         element.serviceTitle!.toLowerCase().contains(value.toLowerCase()))
  //   //     .toList();
  //   notifyListeners();
  // }

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

  selectType(
    bool type,
    BuildContext context,
  ) async {
    nearByJobs = type;
    // type == true
    //     ? await prefernce.setSharedPreferenceValue('type', '0')
    //     : await prefernce.setSharedPreferenceValue('type', '1');
    // print('type ${await prefernce.getSharedPreferenceListValue('type')}');
    allServiceList.clear();
    setLoad(true);
    Future.delayed(Duration.zero).then(
      (value) async {
        // getMyPosts = getPosts();
        // if (allServiceList.isEmpty) {
        allServiceList = await serviceRepo.fetchAllServicesList(
            serviceType: nearByJobs ? '0' : '1'
            //     ? '${prefernce.setSharedPreferenceValue('type', '0')}'
            //     : '${prefernce.setSharedPreferenceValue('type', '1')}',
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
    allServiceList.clear();
    setLoad(true);
    Future.delayed(const Duration(seconds: 1)).then(
      (value) async {
        // getMyPosts = getPosts();
        if (allServiceList.isEmpty) {
          allServiceList = await serviceRepo.fetchAllServicesList(
            serviceType: nearByJobs ? '0' : '1',
            // serviceType: await prefernce.getSharedPreferenceValue('type'),
            // categoryId: await Prefrences().getSharedPreferenceValue('catId'),
            // categoryId: categoryId,
          );
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
        serviceDetalModel =
            await serviceRepo.fetchAllServiceDetail(serviceId: serviceId);
        setLoad(false);
      },
    );
    notifyListeners();
  }

  // SEND OFFER
  Future<void> sendOffer({
    required dynamic data,
    required BuildContext context,
    TextEditingController? controller,
  }) async {
    setOfferLoad(true);
    final loadedData = await chatRepo.sendOfferApi(data);
    // // print(loadedData);
    if (loadedData == null) {
      setLoad(false);
    } else if (loadedData != null) {
      Future.delayed(const Duration(seconds: 2)).then(
        (value) {
          setOfferLoad(false);
          Utils.toastMessage('Offer Send Successfully!');
          Navigator.of(context).pop();
          controller!.clear();
        },
      );
    }
  }

  // SEND MESSAGE
  Future<void> sendMessage({
    required dynamic data,
    required BuildContext context,
    TextEditingController? controller,
  }) async {
    setOfferLoad(true);
    final loadedData = await chatRepo.sendOfferApi(data);
    // // print(loadedData);
    if (loadedData == null) {
      setLoad(false);
    } else if (loadedData != null) {
      Future.delayed(const Duration(seconds: 2)).then(
        (value) {
          setOfferLoad(false);
          Utils.toastMessage('Message Send Successfully!');
          Navigator.of(context).pop();
          controller!.clear();
        },
      );
    }
  }
}
