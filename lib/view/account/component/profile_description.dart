import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../model/rating_model.dart';
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
  }) : super(key: key);

  final String? description, url, avgRating, totalReviews;
  final List<UserRatingModel>? ratingAndReviews;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            'About',
            style: TextStyle(
              // color: Theme.of(context).textTheme.bodyText1!.color,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
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
                  var launchUrl = 'https://${url}';
                  if (await canLaunch(launchUrl)) launch(launchUrl);
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
}
