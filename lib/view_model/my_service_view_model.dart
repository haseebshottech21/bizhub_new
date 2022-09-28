import 'package:bizhub_new/model/post_model.dart';
import 'package:bizhub_new/model/service_model.dart';
import 'package:bizhub_new/utils/dummy_data.dart';
import 'package:bizhub_new/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repo/service_repo.dart';
import 'bottom_navigation_view_model.dart';

class MyServiceViewModel extends ChangeNotifier {
  final serviceRepo = ServiceRepository();
  List<Post> getMyPosts = [];
  List<ServiceModel> posterServiceList = [];
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

  // bool _signupLoading = false;
  // bool get signupLoading => _signupLoading;

  // signUpLoading(bool value) {
  //   _signupLoading = value;
  //   notifyListeners();
  // }

  // Future<void> createPost(BuildContext context) async {
  //   setLoad(true);
  //   Future.delayed(const Duration(seconds: 3)).then(
  //     (value) {
  //       setLoad(false);
  //       Provider.of<BottomNavigationViewModel>(context, listen: false)
  //           .bottomIndex = 1;
  //       Navigator.of(context).pop();
  //       Navigator.of(context).pop();
  //       Navigator.of(context).pop();
  //     },
  //   );
  // }

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
          if (kDebugMode) {
            Provider.of<BottomNavigationViewModel>(context, listen: false)
                .bottomIndex = 1;
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Utils.toastMessage('Service Create Successfully!');
          }
        },
      );
    }
  }

  Future<void> myJobs() async {
    setLoad(true);
    Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        getMyPosts = getPosts();
        // notifyListeners();
        setLoad(false);
      },
    );
  }

  Future<void> getMyPoseterServiceList(
    BuildContext context,
  ) async {
    setLoad(true);
    Future.delayed(const Duration(seconds: 3)).then(
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
}
