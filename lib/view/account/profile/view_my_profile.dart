import 'package:bizhub_new/utils/app_url.dart';
import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:bizhub_new/view/account/component/profile_description.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/rating_model.dart';
import '../../../utils/mytheme.dart';
import '../../../view_model/auth_view_model.dart';
import '../../../widgets/common/cached_image.dart';
import '../../../widgets/common/empty_profile.dart';
import '../component/view_profile.dart';

class ViewMyProfile extends StatefulWidget {
  const ViewMyProfile({Key? key}) : super(key: key);

  @override
  State<ViewMyProfile> createState() => _ViewMyProfileState();
}

class _ViewMyProfileState extends State<ViewMyProfile> {
  String? desc;
  String? url;
  String? avgRating;
  String? totalReviews;
  List<UserRatingModel>? myRatings;

  getData() async {
    final auth = context.read<AuthViewModel>();
    auth.setPrefrenceValues();
    await auth.getUser(context);
    desc = auth.user!.description == null
        ? 'No description added yet.'
        : auth.user!.description.toString();
    url = auth.user!.url == null ? 'www.google.com' : auth.user!.url.toString();
    avgRating = auth.user!.avgRating == 'null'
        ? '0.0'
        : auth.user!.avgRating.toString();
    totalReviews = auth.user!.totalReviews == '0'
        ? '0'
        : auth.user!.totalReviews.toString();
    myRatings = auth.user!.ratingList ?? [];
    // print(auth.user!.avgRating);
    // print(auth.user!.totalReviews);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthViewModel>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyTheme.greenColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteName.editMyProfile);
            },
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ViewProfile(
              userName:
                  '${auth.getPrefrenceValue('firstName')} ${auth.getPrefrenceValue('lastName')}',
              image: auth.getPrefrenceValue('image') == null.toString()
                  ? const EmptyProfile()
                  : CachedImageWidget(
                      height: size.height * 0.20,
                      width: size.width * 0.40,
                      radius: 100,
                      imgUrl: AppUrl.baseUrl + auth.getPrefrenceValue('image'),
                    ),
            ),
            const SizedBox(height: 15),
            auth.loading
                ? const Padding(
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
                  )
                : ProfileDescription(
                    description: desc,
                    url: url,
                    avgRating: avgRating,
                    totalReviews: totalReviews,
                    ratingAndReviews: myRatings,
                  ),
          ],
        ),
      ),
    );
  }
}
