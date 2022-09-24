import 'package:bizhub_new/model/post_model.dart';
import 'package:bizhub_new/utils/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bottom_navigation_view_model.dart';

class PostViewModel extends ChangeNotifier {
  // final _myRepo = AuthRepository();

  List<Post> getMyPosts = [];

  bool _loading = false;
  bool get loading => _loading;
  setLoad(bool status) {
    _loading = status;
    notifyListeners();
  }

  // bool _signupLoading = false;
  // bool get signupLoading => _signupLoading;

  // signUpLoading(bool value) {
  //   _signupLoading = value;
  //   notifyListeners();
  // }

  Future<void> createPost(BuildContext context) async {
    setLoad(true);
    Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        setLoad(false);
        Provider.of<BottomNavigationViewModel>(context, listen: false)
            .bottomIndex = 1;
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );
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
}
