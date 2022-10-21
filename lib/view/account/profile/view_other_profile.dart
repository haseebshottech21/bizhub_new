import 'package:bizhub_new/model/user_model.dart';
import 'package:bizhub_new/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/app_url.dart';
import '../../../utils/mytheme.dart';
import '../../../widgets/common/cached_image.dart';
import '../component/view_profile.dart';

class ViewOtherProfile extends StatefulWidget {
  const ViewOtherProfile({Key? key}) : super(key: key);

  @override
  State<ViewOtherProfile> createState() => _ViewOtherProfileState();
}

class _ViewOtherProfileState extends State<ViewOtherProfile> {
  showOtherProile() async {
    final profileViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final UserModel profile =
        ModalRoute.of(context)!.settings.arguments as UserModel;
    await profileViewModel.viewOtherProfile(
      context: context,
      userId: profile.userId.toString(),
    );
    // print(profile.userId);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showOtherProile(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final UserModel profile =
        ModalRoute.of(context)!.settings.arguments as UserModel;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyTheme.greenColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ViewProfile(
              userName: '${profile.firstName} ${profile.lastName}',
              userImage: profile.image!.isEmpty
                  ? 'https://i.pinimg.com/736x/25/78/61/25786134576ce0344893b33a051160b1.jpg'
                  : AppUrl.baseUrl + profile.image!,
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
                return Column(
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
                          horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            authViewModel.viewUser!.description == null
                                ? 'No description added yet.'
                                : authViewModel.viewUser!.description
                                    .toString(),
                            style: TextStyle(
                              // decoration: TextDecoration.underline,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          GestureDetector(
                            child: Text(
                              authViewModel.viewUser!.url == null
                                  ? 'www.google.com'
                                  : authViewModel.viewUser!.url.toString(),
                              // "www.google.com",
                              // viewProfile.response['url'] ?? '',
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                // decoration: TextDecoration.underline,
                                color: Colors.blue,
                              ),
                            ),
                            onTap: () async {
                              var url = authViewModel.viewUser!.url == null
                                  ? 'www.google.com'
                                  : authViewModel.viewUser!.url.toString();
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
                          authViewModel.viewUser!.avgRating == 'null'
                              ? '0.0'
                              : double.parse(authViewModel.viewUser!.avgRating
                                      .toString())
                                  .toString(),
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
                            authViewModel.viewUser!.totalReviews == '0'
                                ? '(0)'
                                : '(${authViewModel.viewUser!.totalReviews})',
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
                      itemCount: authViewModel.viewUser!.ratingList!.length,
                      itemBuilder: (context, i) {
                        // print();
                        var ratings = authViewModel.viewUser!.ratingList!;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Row(
                            children: [
                              const CachedImageWidget(
                                height: 45,
                                width: 45,
                                radius: 4,
                                imgUrl:
                                    'https://i.pinimg.com/736x/25/78/61/25786134576ce0344893b33a051160b1.jpg',
                                // imgUrl: AppUrl.baseUrl + chat.user!.image.toString(),
                              ),
                              SizedBox(width: size.width * 0.04),
                              SizedBox(
                                width: size.width * 0.75,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'USERNAME',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.002),
                                    Text(
                                      ratings[i].review.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.004),
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
                                                        ratings[i]
                                                            .rate
                                                            .toString(),
                                                      ) <=
                                                      index
                                                  ? Icons.star_outline
                                                  : Icons.star,
                                              color: Colors.amber,
                                              size: 22,
                                            ),
                                          ),
                                        ),
                                        const Text(
                                          '11/06/2022',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
