import 'package:bizhub_new/utils/shared_prefrences.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../model/service_model.dart';
import '../repo/chat_repo.dart';
import '../repo/notification_repo.dart';
import '../repo/service_repo.dart';
import '../utils/utils.dart';

class AllServicesViewModel extends ChangeNotifier {
  final serviceRepo = ServiceRepository();
  final chatRepo = ChatRepository();
  final prefernce = Prefrences();
  final notification = NotificationRepo();

  List<ServiceModel> allServiceList = [];
  ServiceModel? serviceModel;
  ServiceDetalModel? serviceDetalModel;
  bool nearByJobs = true;
  bool isInternetConnect = true;

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

  // ALL SERVICES
  Future<void> getAllServicesList(
    BuildContext context,
  ) async {
    checkInternet();
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

  // CHECK INTERNET
  checkInternet() async {
    isInternetConnect = await InternetConnectionChecker().hasConnection;
    notifyListeners();
  }

  noInternetAndGetServices({
    required BuildContext context,
  }) async {
    if (await InternetConnectionChecker().hasConnection == true) {
      // getAllServices();
      getAllServicesList(context);
      Utils.snackBarMessage(
        'Internet Conneted',
        CupertinoIcons.wifi,
        context,
      );
    } else {
      Utils.snackBarMessage(
        'No Internet Connection',
        CupertinoIcons.wifi_slash,
        context,
      );
    }
  }

  // ALL SERVICE DETAIL
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
      Future.delayed(Duration.zero).then(
        (value) async {
          Utils.toastMessage('Offer Send Successfully!');
          Navigator.of(context).pop();
          controller!.clear();
          // notification.sendNotification(
          //   notiTitle: 'Offer',
          //   notiBody:
          //       '${await prefernce.getSharedPreferenceValue('firstname')} send you Offer',
          //   notifyToken: notificationId,
          //   data: 'send-offer',
          //   requestId: chatId,
          // );
          setOfferLoad(false);
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
      setOfferLoad(false);
    } else if (loadedData != null) {
      Future.delayed(Duration.zero).then(
        (value) async {
          Utils.toastMessage('Message Send Successfully!');
          Navigator.of(context).pop();
          controller!.clear();
          setOfferLoad(false);
        },
      );
    }
  }
}
