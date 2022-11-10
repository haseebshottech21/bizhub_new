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

  bool _hasMore = true;
  bool get hasMore => _hasMore;
  setHasMore(bool status) {
    _hasMore = status;
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
        // allServiceList = await serviceRepo.fetchAllServicesList(
        //     serviceType: nearByJobs ? '0' : '1'
        //     //     ? '${prefernce.setSharedPreferenceValue('type', '0')}'
        //     //     : '${prefernce.setSharedPreferenceValue('type', '1')}',
        //     );
        final loadedData = await serviceRepo.fetchAllServicesList(
          serviceType: nearByJobs ? '0' : '1',
        );
        allServiceList = loadedData['allService'];

        // }
        setLoad(false);
      },
    );
    Navigator.of(context).pop();
    notifyListeners();
    // print(isPoster);
  }

  int page = 1;

  bool isFirstLoadRunning = false;
  bool hasNextPage = true;

  bool isLoadMoreRunning = false;

  List<ServiceModel> posts = [];
  late ScrollController controller;

  var next;

  Future refresh(BuildContext context) async {
    // setLoad(false);
    // // setHasMore(true);
    page = 1;
    posts.clear();
    notifyListeners();
    getAllService();
  }

  Future<void> getAllService() async {
    checkInternet();
    posts.clear();
    isFirstLoadRunning = true;

    final loadedData = await serviceRepo.fetchAllServicesList(
      serviceType: nearByJobs ? '0' : '1',
    );
    if (posts.isEmpty) {
      // posts = loadedData['data'];
      posts = loadedData['allService'];
      // print(posts);
    }
    isFirstLoadRunning = false;
    notifyListeners();
  }

  Future<void> getAllServiceMore() async {
    // void _loadMore() async {
    checkInternet();
    if (next != '' &&
        hasNextPage == true &&
        isFirstLoadRunning == false &&
        isLoadMoreRunning == false &&
        controller.position.extentAfter < 300) {
      // setState(() {
      isLoadMoreRunning = true; // Display a progress indicator at the bottom
      // });

      page += 1; // Increase _page by 1

      // try {
      // final res = await http.get(
      //   Uri.parse("$_baseUrlNew?page=$_page&type=0"),
      //   headers: await AppUrl().headerWithAuth(),
      // );

      final loadedData = await serviceRepo.fetchAllServicesList(
        serviceType: nearByJobs ? '0' : '1',
        page: page,
      );

      // print("$_baseUrlNew?page=$_page&type=0");
      // final loadedData = json.decode(res.body);

      next = loadedData['next'];
      final List<ServiceModel> fetchedPosts = loadedData['allService'];
      // print(next);
      if (fetchedPosts.isNotEmpty) {
        // setState(() {
        posts.addAll(fetchedPosts);
        // });
      } else {
        // setState(() {
        hasNextPage = false;
        // });
      }
      // } catch (err) {
      //   if (kDebugMode) {
      //     print('Something went wrong!');
      //   }
      // }

      // setState(() {
      isLoadMoreRunning = false;
      // });
    }
    notifyListeners();
    // }
  }

  // ALL SERVICES
  Future<void> getAllServicesList({
    required BuildContext context,
  }) async {
    checkInternet();
    allServiceList.clear();
    setLoad(true);
    Future.delayed(Duration.zero).then(
      (value) async {
        // getMyPosts = getPosts();
        final loadedData = await serviceRepo.fetchAllServicesList(
          serviceType: nearByJobs ? '0' : '1',
        );

        Future.delayed(const Duration(seconds: 5)).then((value) {
          setHasMore(false);
        });
        setLoad(false);
      },
    );
    notifyListeners();
  }

  Future<void> getAllServicesLists({
    required BuildContext context,
  }) async {
    checkInternet();
    allServiceList.clear();
    setLoad(true);
    Future.delayed(Duration.zero).then(
      (value) async {
        final loadedData = await serviceRepo.fetchAllServicesList(
          serviceType: nearByJobs ? '0' : '1',
        );

        if (allServiceList.isEmpty) {
          allServiceList = loadedData['allService'];
        }

        setLoad(false);
      },
    );
    notifyListeners();
  }

  // Future<void> getAllServiceNewList({
  //   required BuildContext context,
  // }) async {
  //   checkInternet();
  //   setLoad(true);
  //   final loadedData = await serviceRepo.fetchAllServicesList(
  //     serviceType: nearByJobs ? '0' : '1',
  //     page: page,
  //   );
  //   allServiceList = loadedData['allservice'];
  // }

  // Future fetch() async {
  //   if (isLoading) return;
  //   isLoading = true;
  //   const limit = 25;
  //   final url = Uri.parse(
  //       'https://jsonplaceholder.typicode.com/posts?_limit=$limit&_page=$page');
  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     final List newItem = json.decode(response.body);
  //     setState(() {
  //       page++;
  //       isLoading = false;
  //       if (newItem.length < limit) {
  //         hasmore = false;
  //       }

  //       items.addAll(newItem.map<String>((item) {
  //         final number = item['id'];
  //         return 'Item $number';
  //       }).toList());
  //     });
  //   }
  // }

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
      getAllServicesList(context: context);
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
