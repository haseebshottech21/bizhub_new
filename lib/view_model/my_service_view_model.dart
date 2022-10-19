import 'package:bizhub_new/model/service_model.dart';
import 'package:bizhub_new/utils/utils.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repo/service_repo.dart';
import 'bottom_navigation_view_model.dart';
import 'category_view_model.dart';

class MyServiceViewModel extends ChangeNotifier {
  final serviceRepo = ServiceRepository();
  List<ServiceModel> posterServiceList = [];
  List<ServiceModel> workerServiceList = [];
  // List<OfferModel> offersList = [];
  ServiceModel? serviceModel;
  ServiceCompleteModel? serviceCompleteModel;
  List<Map<String, dynamic>> serviceImgaes = [];
  bool? isPoster;

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
    setLoad(true);
    final loadedData = await serviceRepo.createService(data);
    // print(loadedData);
    if (loadedData == null) {
      setLoad(false);
    } else if (loadedData != null) {
      Future.delayed(const Duration(seconds: 1)).then(
        (value) {
          // print(value);
          setLoad(false);
          // if (kDebugMode) {
          initailValue(context);
          serviceImgaes.clear();
          Provider.of<BottomNavigationViewModel>(context, listen: false)
              .bottomIndex = 1;
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Utils.toastMessage('Service Create Successfully!');
          // }
        },
      );
    }
  }

  // Future<void> myJobs() async {
  //   setLoad(true);
  //   Future.delayed(const Duration(seconds: 3)).then(
  //     (value) {
  //       getMyPosts = getPosts();
  //       // notifyListeners();
  //       setLoad(false);
  //     },
  //   );
  // }

  // JOBS
  Future<void> getMyPosterServiceList(
    BuildContext context,
  ) async {
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
    await provider.getMyPosterServiceList(context);
  }

  Future<void> getMyPosterServiceDetail({
    required BuildContext context,
    required String serviceId,
  }) async {
    setLoad(true);
    Future.delayed(const Duration(seconds: 1)).then(
      (value) async {
        serviceModel =
            await serviceRepo.fetchMyPosterService(serviceId: serviceId);
        setLoad(false);
      },
    );
    notifyListeners();
  }

  // DELETE JOB
  Future<void> deleteMyPosterService({
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
        Utils.toastMessage('Service delete Successfully!');
      });
    }
  }

  // SERVICES
  Future<void> getMyWorkerServiceList(
    BuildContext context,
  ) async {
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
  String review = 'NO REVIEW';
  totalRating(int rate) {
    rating = rate;
    if (rate == 0) {
      review = 'NO REVIEW';
    } else if (rate == 1) {
      review = 'NOT SATISFIED';
    } else if (rate == 2) {
      review = 'SATISFIED';
    } else if (rate == 3) {
      review = 'GOOD';
    } else if (rate == 4) {
      review = 'VERY GOOD';
    } else if (rate == 5) {
      review = 'EXCELLENT';
    }
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
            await getMyPosterServiceList(context);
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
