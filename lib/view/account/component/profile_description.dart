import 'package:bizhub_new/view/account/component/report_user_bottom.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../language/language_constant.dart';
import '../../../model/rating_model.dart';
import '../../../model/user_model.dart';
import '../../../utils/app_url.dart';
import '../../../utils/utils.dart';
import '../../../widgets/common/cached_image.dart';

class ProfileDescription extends StatelessWidget {
  const ProfileDescription({
    Key? key,
    required this.description,
    required this.url,
    required this.avgRating,
    required this.totalReviews,
    required this.ratingAndReviews,
    this.formKey,
    this.userModel,
    this.controller,
    this.scaffoldKey,
    this.viewOtherProfile = false,
  }) : super(key: key);

  final String? description, url, avgRating, totalReviews;
  final UserModel? userModel;
  final TextEditingController? controller;
  final List<UserRatingModel>? ratingAndReviews;
  final GlobalKey<FormState>? formKey;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final bool viewOtherProfile;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                translation(context).aboutTitle,
                style: const TextStyle(
                  // color: Theme.of(context).textTheme.bodyText1!.color,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
              if (viewOtherProfile)
                PopupMenuButton<int>(
                  elevation: 4,
                  position: PopupMenuPosition.under,
                  onSelected: (value) {
                    if (value == 1) {
                      // print('reported user');

                      scaffoldKey!.currentState?.showBottomSheet(
                        enableDrag: false,
                        (context) {
                          return ReportUserBottom(
                            reportUserId: userModel!.userId.toString(),
                            controller: controller!,
                            formKey: formKey!,
                          );
                        },
                      );
                      // _showDialog(context);
                      // if value 2 show dialog
                    }
                    // your logic
                    // setState(() {
                    //   // selectedItem = value.toString();
                    // });
                    // print(value);
                    // Navigator.pushNamed(context, value.toString());
                  },
                  itemBuilder: (BuildContext bc) {
                    return const [
                      PopupMenuItem(
                        value: 1,
                        child: Text(
                          "Report user",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ];
                  },
                )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description!,
                style: TextStyle(
                  // decoration: TextDecoration.underline,
                  color: Colors.grey.shade500,
                  fontSize: 15,
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
                    fontSize: 15,
                  ),
                ),
                onTap: () async {
                  var finalUrl = 'https://$url';
                  _launchUrl(finalUrl);
                  // if (await canLaunch(launchUrl)) launch(launchUrl);
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Divider(),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            translation(context).rateAndReviewTitle,
            style: const TextStyle(
              // color: Theme.of(context).textTheme.bodyText1!.color,
              fontSize: 20,
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
              double.parse('$avgRating').toStringAsFixed(2),
              style: const TextStyle(
                // color: Theme.of(context).textTheme.bodyText1!.color,
                fontSize: 32,
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
                  fontSize: 18,
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
          itemCount: ratingAndReviews!.length,
          itemBuilder: (context, i) {
            // print();
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                children: [
                  CachedImageWidget(
                    height: 45,
                    width: 45,
                    radius: 4,
                    // imgUrl:
                    //     'https://i.pinimg.com/736x/25/78/61/25786134576ce0344893b33a051160b1.jpg',
                    imgUrl: AppUrl.baseUrl +
                        ratingAndReviews![i].userRateBy!.image.toString(),
                  ),
                  SizedBox(width: size.width * 0.04),
                  SizedBox(
                    width: size.width * 0.75,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${ratingAndReviews![i].userRateBy!.firstName} ${ratingAndReviews![i].userRateBy!.lastName}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: size.height * 0.006),
                        Text(
                          ratingAndReviews![i].review.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: size.height * 0.006),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: List.generate(
                                5,
                                (index) => Icon(
                                  int.parse(
                                            ratingAndReviews![i]
                                                .rate
                                                .toString(),
                                          ) <=
                                          index
                                      ? Icons.star_outline
                                      : Icons.star,
                                  color: Colors.amber,
                                  size: 20,
                                ),
                              ),
                            ),
                            Text(
                              Utils().dateFormat(
                                ratingAndReviews![i].createAt.toString(),
                              ),
                              // '11/06/2022',
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
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
    );
  }

  Future<void> _launchUrl(String decsUrl) async {
    final Uri url = Uri.parse(decsUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
