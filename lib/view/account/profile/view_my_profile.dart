import 'package:bizhub_new/utils/app_url.dart';
import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../model/rating_model.dart';
import '../../../utils/mytheme.dart';
import '../../../view_model/auth_view_model.dart';
import '../../../widgets/common/cached_image.dart';
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
              userImage: auth.getPrefrenceValue('image').isEmpty
                  ? 'https://i.pinimg.com/736x/25/78/61/25786134576ce0344893b33a051160b1.jpg'
                  : AppUrl.baseUrl + auth.getPrefrenceValue('image'),
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
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          'About',
                          style: TextStyle(
                            // color: Theme.of(context).textTheme.bodyText1!.color,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              desc!,
                              style: TextStyle(
                                // decoration: TextDecoration.underline,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            SizedBox(height: size.height * 0.005),
                            GestureDetector(
                              child: Text(
                                url!,
                                // viewProfile.response['url'] ?? '',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  // decoration: TextDecoration.underline,
                                  color: Colors.blue,
                                ),
                              ),
                              onTap: () async {
                                var launchUrl = 'https://${url}';
                                if (await canLaunch(launchUrl))
                                  launch(launchUrl);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          'Rate & Reviews',
                          style: TextStyle(
                            // color: Theme.of(context).textTheme.bodyText1!.color,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            double.parse('$avgRating').toString(),
                            style: const TextStyle(
                              // color: Theme.of(context).textTheme.bodyText1!.color,
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              '($totalReviews)',
                              style: const TextStyle(
                                // color: Theme.of(context).textTheme.bodyText1!.color,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ListView.separated(
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 40,
                          left: 12,
                          right: 12,
                        ),
                        itemCount: myRatings!.length,
                        itemBuilder: (context, i) {
                          // print();
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Row(
                              children: [
                                const CachedImageWidget(
                                  height: 40,
                                  width: 40,
                                  radius: 4,
                                  imgUrl:
                                      'https://i.pinimg.com/736x/25/78/61/25786134576ce0344893b33a051160b1.jpg',
                                  // imgUrl: AppUrl.baseUrl + chat.user!.image.toString(),
                                ),
                                SizedBox(width: size.width * 0.04),
                                SizedBox(
                                  width: size.width * 0.75,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'USERNAME',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.006),
                                      Text(
                                        myRatings![i].review.toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.006),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            children: List.generate(
                                              5,
                                              (index) => Icon(
                                                int.parse(
                                                          myRatings![i]
                                                              .rate
                                                              .toString(),
                                                        ) <=
                                                        index
                                                    ? Icons.star_outline
                                                    : Icons.star,
                                                color: Colors.amber,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                          const Text(
                                            '11/06/2022',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: Colors.black54,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
