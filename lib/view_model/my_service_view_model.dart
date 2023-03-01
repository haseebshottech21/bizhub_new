import 'dart:async';
import 'package:bizhub_new/model/service_model.dart';
import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:bizhub_new/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import '../repo/service_repo.dart';
import '../utils/shared_prefrences.dart';
import 'bottom_navigation_view_model.dart';
import 'category_view_model.dart';

class MyServiceViewModel extends ChangeNotifier {
  final serviceRepo = ServiceRepository();
  final prefrences = Prefrences();

  List<ServiceModel> posterServiceList = [];
  List<ServiceModel> workerServiceList = [];
  // List<OfferModel> offersList = [];
  ServiceModel? serviceModel;
  ServiceCompleteModel? serviceCompleteModel;
  List<Map<String, dynamic>> serviceImgaes = [];
  bool? isPoster;
  bool isInternetConnect = true;

  Map<String, dynamic> serviceBody = {
    'category_id': '',
    'images': [],
    'title': '',
    'description': '',
    'amount': '',
    'latitude': '',
    'longitude': '',
    'address': '',
    'is_negotiable': '',
  };

  Map<String, dynamic> updateServiceBody = {
    'category_id': '',
    'images': [],
    'title': '',
    'description': '',
    'amount': '',
    'latitude': '',
    'longitude': '',
    'address': '',
    'is_negotiable': '',
  };

  initailValue(BuildContext context) {
    final category = Provider.of<CategoryViewModel>(context, listen: false);
    isPoster = null;
    category.categoryId = '';
    category.categoryName = '';
  }

  bool isPriceNegotiable = false;
  togglePriceNegotiable() {
    isPriceNegotiable = !isPriceNegotiable;
    notifyListeners();
  }

  // bool isPriceNegotiable = false;
  changePriceNegotiable(bool value) {
    isPriceNegotiable = value;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoad(bool status) {
    _loading = status;
    notifyListeners();
  }

  bool _postloading = false;
  bool get postLoading => _postloading;
  postLoad(bool status) {
    _postloading = status;
    notifyListeners();
  }

  bool _updateLoading = false;
  bool get updateLoading => _updateLoading;
  setUpdateLoad(bool status) {
    _updateLoading = status;
    notifyListeners();
  }

  selectServiceType(bool type) {
    isPoster = type;
    notifyListeners();
    // print(isPoster);
  }

  clearImages() {
    serviceImgaes.clear();
    notifyListeners();
  }

  Future<void> selectMulipleImages() async {
    final List<Map<String, dynamic>> selectedImages =
        await Utils().selectImages();
    if (selectedImages.isNotEmpty) {
      serviceImgaes = selectedImages;
      notifyListeners();
    } else if (serviceImgaes.isEmpty) {
      Utils.toastMessage('Select atleast one image');
    }
  }

  // CREATE
  Future<void> createPost(
    dynamic data,
    BuildContext context,
  ) async {
    postLoad(true);
    final loadedData = await serviceRepo.createService(data);
    // print(loadedData);
    if (loadedData == null) {
      postLoad(false);
    } else if (loadedData != null) {
      Future.delayed(Duration.zero).then(
        (value) {
          // print(value);
          postLoad(false);
          // if (kDebugMode) {
          Provider.of<BottomNavigationViewModel>(context, listen: false)
              .bottomIndex = 0;
          // Navigator.of(context).pop();
          // Navigator.of(context).pop();
          // Navigator.of(context).pop();
          Navigator.of(context).pushNamedAndRemoveUntil(
            RouteName.home,
            (route) => false,
          );
          initailValue(context);
          serviceImgaes.clear();
          Utils.toastMessage('Service Create Successfully!');
          // }
        },
      );
    }
  }

  // checkAuthCreatePost(BuildContext context) async {
  //   final token = await prefrences.getSharedPreferenceValue('token');
  //   if (token == null || token == '') {
  //     Timer(
  //       Duration.zero,
  //       () => Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (ctx) => const AuthNotLogin(),
  //           settings: const RouteSettings(arguments: false),
  //         ),
  //       ),
  //     );
  //   } else {
  //     Navigator.of(context).pushNamed(RouteName.selectService);
  //   }
  // }

  // JOBS
  Future<void> getMyPosterServiceList({
    required BuildContext context,
  }) async {
    checkInternet();
    posterServiceList.clear();
    setLoad(true);
    Future.delayed(const Duration(seconds: 1)).then(
      (value) async {
        // getMyPosts = getPosts();
        if (posterServiceList.isEmpty) {
          posterServiceList = await serviceRepo.fetchMyPosterServiceList();
        }
        setLoad(false);
      },
    );
    notifyListeners();
  }

  Future getMyPosterServices(BuildContext context) async {
    final provider = Provider.of<MyServiceViewModel>(context, listen: false);
    provider.posterServiceList.clear();
    await provider.getMyPosterServiceList(context: context);
  }

  noInternetAndGetJobs({
    required BuildContext context,
  }) async {
    if (await InternetConnectionChecker().hasConnection == true) {
      // getAllServices();
      getMyPosterServices(context);
      Utils.snackBarMessage(
        message: 'Internet Conneted',
        icons: CupertinoIcons.wifi,
        context: context,
      );
    } else {
      Utils.snackBarMessage(
        message: 'Internet Conneted',
        icons: CupertinoIcons.wifi_slash,
        context: context,
      );
    }
  }

  // SERVICES
  Future<void> getMyWorkerServiceList(
    BuildContext context,
  ) async {
    checkInternet();
    workerServiceList.clear();
    setLoad(true);
    Future.delayed(const Duration(seconds: 1)).then(
      (value) async {
        // getMyPosts = getPosts();
        if (workerServiceList.isEmpty) {
          workerServiceList = await serviceRepo.fetchMyWorkerServiceList();
        }
        setLoad(false);
      },
    );
    notifyListeners();
  }

  Future getMyServices(BuildContext context) async {
    final provider = Provider.of<MyServiceViewModel>(context, listen: false);
    provider.workerServiceList.clear();
    await provider.getMyWorkerServiceList(context);
  }

  noInternetAndGetServices({
    required BuildContext context,
  }) async {
    if (await InternetConnectionChecker().hasConnection == true) {
      // getAllServices();
      getMyServices(context);
      Utils.snackBarMessage(
        message: 'Internet Conneted',
        icons: CupertinoIcons.wifi,
        context: context,
      );
    } else {
      Utils.snackBarMessage(
        message: 'Internet Conneted',
        icons: CupertinoIcons.wifi_slash,
        context: context,
      );
    }
  }

  // CHECK INTERNET
  checkInternet() async {
    isInternetConnect = await InternetConnectionChecker().hasConnection;
    notifyListeners();
  }

  // POST DETAIL
  Future<void> getMyPostDetail({
    required BuildContext context,
    required String serviceId,
  }) async {
    setLoad(true);
    Future.delayed(Duration.zero).then(
      (value) async {
        serviceModel =
            await serviceRepo.fetchMyPosterService(serviceId: serviceId);
        setLoad(false);
      },
    );
    notifyListeners();
  }

  // BUMP UP POST
  Future<void> bumpUpPost({
    required BuildContext context,
    required String serviceId,
    bool service = false,
  }) async {
    setLoad(true);
    final response = await serviceRepo.bumpUpMyService(serviceId: serviceId);
    if (response) {
      Future.delayed(Duration.zero).then((value) {
        Navigator.of(context).pop();
        setLoad(false);
        getMyPosterServices(context);
        Utils.toastMessage(
          service
              ? 'BumpUp My Service Successfully!'
              : 'BumpUp My Job Successfully!',
        );
      });
    }
  }

  // DELETE POST
  Future<void> deleteMyPost({
    required BuildContext context,
    required String serviceId,
  }) async {
    setLoad(true);
    final response = await serviceRepo.deleteMyService(serviceId: serviceId);
    if (response) {
      Future.delayed(Duration.zero).then((value) {
        Navigator.of(context).pop();
        setLoad(false);
        getMyPosterServices(context);
        Utils.toastMessage('Job delete Successfully!');
      });
    }
  }

  // DELETE SERVICE
  Future<void> deleteMyService({
    required BuildContext context,
    required String serviceId,
  }) async {
    setLoad(true);
    final response = await serviceRepo.deleteMyService(serviceId: serviceId);
    if (response) {
      Future.delayed(Duration.zero).then((value) {
        Navigator.of(context).pop();
        setLoad(false);
        getMyServices(context);
        Utils.toastMessage('Service delete Successfully!');
      });
    }
  }

  // UPDATE JOBS
  Future<void> updateMyPosterService({
    required dynamic data,
    required BuildContext context,
  }) async {
    setUpdateLoad(true);
    final loadedData = await serviceRepo.updateService(data);
    // print(loadedData);
    if (loadedData == null) {
      setUpdateLoad(false);
    } else if (loadedData != null) {
      Future.delayed(const Duration(seconds: 1)).then(
        (value) {
          setUpdateLoad(false);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Utils.toastMessage('Updated Successfully!');
          getMyPosterServices(context);
        },
      );
    }
  }

  // UPDATE SERVICES
  Future<void> updateMyWorkerService({
    required dynamic data,
    required BuildContext context,
  }) async {
    setUpdateLoad(true);
    final loadedData = await serviceRepo.updateService(data);
    // print(loadedData);
    if (loadedData == null) {
      setUpdateLoad(false);
    } else if (loadedData != null) {
      Future.delayed(const Duration(seconds: 1)).then(
        (value) {
          setUpdateLoad(false);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Utils.toastMessage('Updated Successfully!');
          getMyServices(context);
        },
      );
    }
  }

  // COMPLETE JOB DETAIL
  Future<void> getJobCompleteDetail({
    required BuildContext context,
    required String serviceId,
  }) async {
    setLoad(true);
    Future.delayed(const Duration(seconds: 1)).then(
      (value) async {
        serviceCompleteModel =
            await serviceRepo.fetchCompleteService(serviceId: serviceId);
        setLoad(false);
      },
    );
    notifyListeners();
  }

  int rating = 0;
  // String review = 'NO REVIEW';
  totalRating(int rate) {
    rating = rate;
    // if (rate == 0) {
    //   review = 'NO REVIEW';
    // } else if (rate == 1) {
    //   review = 'NOT SATISFIED';
    // } else if (rate == 2) {
    //   review = 'SATISFIED';
    // } else if (rate == 3) {
    //   review = 'GOOD';
    // } else if (rate == 4) {
    //   review = 'VERY GOOD';
    // } else if (rate == 5) {
    //   review = 'EXCELLENT';
    // }
    // print(rate);
    notifyListeners();
  }

  resetRating(BuildContext context) {
    rating = 0;
    Navigator.of(context).pop();
    notifyListeners();
  }

  // RATE LEADS
  Future<void> rateAndCompleteLeads(
    dynamic data,
    BuildContext context,
  ) async {
    setLoad(true);
    final loadedData = await serviceRepo.completeAndRate(data);
    // print(loadedData);
    if (loadedData == null) {
      setLoad(false);
    } else if (loadedData != null) {
      Future.delayed(const Duration(seconds: 1)).then(
        (value) {
          // print(value);
          setLoad(false);
          // if (kDebugMode) {
          Navigator.of(context).pop();
          Utils.toastMessage('Rating Submit Successfully!');
          Future.delayed(const Duration(seconds: 2)).then((value) async {
            await getMyPosterServiceList(context: context);
          });
          Navigator.of(context).pop();
          // }
        },
      );
    }
  }

  // RATE SERVICE
  Future<void> rateAndCompleteService(
    dynamic data,
    BuildContext context,
  ) async {
    setLoad(true);
    final loadedData = await serviceRepo.completeAndRate(data);
    // print(loadedData);
    if (loadedData == null) {
      setLoad(false);
    } else if (loadedData != null) {
      Future.delayed(const Duration(seconds: 1)).then(
        (value) {
          // print(value);
          setLoad(false);
          // if (kDebugMode) {
          Navigator.of(context).pop();
          Utils.toastMessage('Rating Submit Successfully!');
          Future.delayed(const Duration(seconds: 2)).then((value) async {
            await getMyWorkerServiceList(context);
          });
          Navigator.of(context).pop();
          // }
        },
      );
    }
  }
}
