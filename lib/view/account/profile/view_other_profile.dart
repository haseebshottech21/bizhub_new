import 'package:bizhub_new/model/user_model.dart';
import 'package:bizhub_new/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_url.dart';
import '../../../utils/mytheme.dart';
import '../../../widgets/common/cached_image.dart';
import '../../../widgets/common/empty_profile.dart';
import '../component/profile_description.dart';
// import '../component/report_reason_item.dart';
import '../component/view_profile.dart';

class ViewOtherProfile extends StatefulWidget {
  const ViewOtherProfile({Key? key}) : super(key: key);

  @override
  State<ViewOtherProfile> createState() => _ViewOtherProfileState();
}

class _ViewOtherProfileState extends State<ViewOtherProfile> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final commentController = TextEditingController();
  // List<ReportModel> reportedData = [];

  showOtherProile() async {
    final profileViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final UserModel profile =
        ModalRoute.of(context)!.settings.arguments as UserModel;
    await profileViewModel.getReportedDate();
    await profileViewModel.viewOtherProfile(userId: profile.userId.toString());
    // print(profile.userId);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        showOtherProile();
        // reportedData();
      },
    );
  }

  // void reportedData() {
  //   final profileViewModel = Provider.of<AuthViewModel>(context, listen: false);
  // }

  @override
  Widget build(BuildContext context) {
    // final profileViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final size = MediaQuery.of(context).size;
    final UserModel profile =
        ModalRoute.of(context)!.settings.arguments as UserModel;

    // print(profile.userId);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyTheme.greenColor,
        actions: const [
          // PopupMenuButton<int>(
          //   elevation: 0,
          //   position: PopupMenuPosition.under,
          //   onSelected: (value) {
          //     if (value == 1) {
          //       // print('reported user');

          //       scaffoldKey.currentState?.showBottomSheet(
          //         enableDrag: false,
          //         (context) {
          //           return ReportUserBottom(
          //             reportUserId: profile.userId.toString(),
          //             controller: commentController,
          //             formKey: _formKey,
          //           );
          //         },
          //       );
          //       // _showDialog(context);
          //       // if value 2 show dialog
          //     }
          //     // your logic
          //     // setState(() {
          //     //   // selectedItem = value.toString();
          //     // });
          //     // print(value);
          //     // Navigator.pushNamed(context, value.toString());
          //   },
          //   itemBuilder: (BuildContext bc) {
          //     return const [
          //       PopupMenuItem(
          //         value: 1,
          //         child: Text(
          //           "Report user",
          //           style: TextStyle(color: Colors.black),
          //         ),
          //       ),
          //     ];
          //   },
          // )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ViewProfile(
              userName: '${profile.firstName} ${profile.lastName}',
              // userImage: profile.image,
              image: profile.image == null
                  ? const EmptyProfile()
                  : CachedImageWidget(
                      height: size.height * 0.20,
                      width: size.width * 0.40,
                      radius: 100,
                      imgUrl: AppUrl.baseUrl + profile.image!,
                    ),
            ),
            const SizedBox(height: 15),
            Consumer<AuthViewModel>(
              builder: (context, authViewModel, _) {
                if (authViewModel.loading) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Center(
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.5,
                          color: MyTheme.greenColor,
                        ),
                      ),
                    ),
                  );
                }
                return ProfileDescription(
                  formKey: _formKey,
                  scaffoldKey: scaffoldKey,
                  controller: commentController,
                  viewOtherProfile: true,
                  userModel: profile,
                  description: authViewModel.viewUser!.description == null
                      ? 'No description added yet.'
                      : authViewModel.viewUser!.description.toString(),
                  url: authViewModel.viewUser!.url == null
                      ? 'www.google.com'
                      : authViewModel.viewUser!.url.toString(),
                  avgRating: authViewModel.viewUser!.avgRating == 'null'
                      ? '0.0'
                      : double.parse(
                              authViewModel.viewUser!.avgRating.toString())
                          .toString(),
                  totalReviews: authViewModel.viewUser!.totalReviews == '0'
                      ? '0'
                      : '${authViewModel.viewUser!.totalReviews}',
                  ratingAndReviews: authViewModel.viewUser!.ratingList,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
