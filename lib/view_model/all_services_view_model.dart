import 'dart:async';
import 'package:bizhub_new/utils/shared_prefrences.dart';
import 'package:flutter/cupertino.dart';
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
  List<ServiceModel> allServiceMoreList = [];
  List<ServiceModel> displayList = [];
  ServiceModel? serviceModel;
  ServiceDetalModel? serviceDetalModel;
  bool nearByJobs = true;
  bool isInternetConnect = true;
  String? token;

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

  // bool _hasMore = true;
  // bool get hasMore => _hasMore;
  // setHasMore(bool status) {
  //   _hasMore = status;
  //   notifyListeners();
  // }

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
    // allServiceList.clear();
    page = 1;
    hasNextPage = true;
    allServiceList.clear();

    setLoad(true);

    // isFirstLoadRunning = true;
    Future.delayed(Duration.zero).then(
      (value) async {
        token = await prefernce.getSharedPreferenceValue('token');
        final loadedData = token == null || token == ''
            ? await serviceRepo.fetchAllServicesWithoutAuthList(
                serviceType: nearByJobs ? '0' : '1',
              )
            : await serviceRepo.fetchAllServicesList(
                serviceType: nearByJobs ? '0' : '1',
              );
        allServiceList = loadedData['allService'];
        setLoad(false);
        // isFirstLoadRunning = false;
      },
    );
    Navigator.of(context).pop();
    notifyListeners();
  }

  int page = 1;

  bool isFirstLoadRunning = false;
  bool hasNextPage = true;
  bool isLoadMoreRunning = false;

  // List<ServiceModel> posts = [];
  ScrollController controller = ScrollController();

  dynamic next;

  Future<void> refresh(BuildContext context) async {
    page = 1;
    hasNextPage = true;
    allServiceList.clear();
    notifyListeners();
    // getAllService();

    token = await prefernce.getSharedPreferenceValue('token');
    if (token == null || token == '') {
      getAllServiceWithoutAuth();
    } else {
      getAllService();
    }
  }

  Future<void> checkAuth(BuildContext context) async {
    token = await prefernce.getSharedPreferenceValue('token');
    if (token == null || token == '') {
      getAllServiceWithoutAuth();
    } else {
      getAllService();
    }
  }

  Future<void> getAllServiceWithoutAuth() async {
    checkInternet();
    allServiceList.clear();
    isFirstLoadRunning = true;

    final loadedData = await serviceRepo.fetchAllServicesWithoutAuthList(
      serviceType: nearByJobs ? '0' : '1',
    );
    if (allServiceList.isEmpty) {
      allServiceList = loadedData['allService'];
    }
    isFirstLoadRunning = false;
    notifyListeners();
  }

  Future<void> getAllService() async {
    checkInternet();
    allServiceList.clear();
    isFirstLoadRunning = true;

    final loadedData = await serviceRepo.fetchAllServicesList(
      serviceType: nearByJobs ? '0' : '1',
    );
    if (allServiceList.isEmpty) {
      allServiceList = loadedData['allService'];
    }
    isFirstLoadRunning = false;
    notifyListeners();
  }

  Future<void> getAllServiceMore() async {
    // checkInternet();
    if (next != '' &&
        hasNextPage == true &&
        isFirstLoadRunning == false &&
        isLoadMoreRunning == false &&
        controller.position.extentAfter < 300) {
      isLoadMoreRunning = true; // Display a progress indicator at the bottom

      page += 1; // Increase _page by 1

      // Future.delayed(Duration.zero).then((value) async {
      Map<String, dynamic> loadedData = {};

      token = await prefernce.getSharedPreferenceValue('token');
      if (token == null || token == '') {
        loadedData = await serviceRepo.fetchAllServicesWithoutAuthList(
          serviceType: nearByJobs ? '0' : '1',
          page: page,
        );
      } else {
        loadedData = await serviceRepo.fetchAllServicesList(
          serviceType: nearByJobs ? '0' : '1',
          page: page,
        );
      }

      next = loadedData['next'];
      allServiceMoreList = loadedData['allService'];
      if (allServiceMoreList.isNotEmpty) {
        allServiceList.addAll(allServiceMoreList);
      } else {
        hasNextPage = false;
      }
      isLoadMoreRunning = false;
      // });
    }
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
      token = await prefernce.getSharedPreferenceValue('token');
      // getAllServices();
      // getAllService();

      if (token == null || token == '') {
        getAllServiceWithoutAuth();
      } else {
        getAllService();
      }
      Utils.snackBarMessage(
        message: 'Internet Conneted',
        icons: CupertinoIcons.wifi,
        context: context,
      );
    } else {
      Utils.snackBarMessage(
        message: 'No Internet Conneted',
        icons: CupertinoIcons.wifi_slash,
        context: context,
      );
    }
  }

  // ALL SERVICE DETAIL WITH CHECK AUTH
  Future<void> getAllServiceDetailWithCheckAuth({
    required BuildContext context,
    required String serviceId,
  }) async {
    token = await prefernce.getSharedPreferenceValue('token');
    if (token == null || token == '') {
      getAllServiceDetailWithoutAuth(context: context, serviceId: serviceId);
    } else {
      getAllServiceDetail(context: context, serviceId: serviceId);
    }
  }

  // ALL SERVICE DETAIL
  Future<void> getAllServiceDetailWithoutAuth({
    required BuildContext context,
    required String serviceId,
  }) async {
    setLoad(true);
    Future.delayed(const Duration(seconds: 1)).then(
      (value) async {
        serviceDetalModel = await serviceRepo.fetchAllServiceDetailWithoutAuth(
          serviceId: serviceId,
        );
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
