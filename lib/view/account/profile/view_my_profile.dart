import 'package:bizhub_new/utils/app_url.dart';
import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
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

  getData() async {
    final auth = context.read<AuthViewModel>();
    auth.setPrefrenceValues();
    await auth.getUser(context);
    desc = auth.user!.description == null
        ? 'No description added yet.'
        : auth.user!.description.toString();
    url = auth.user!.url == null ? 'www.google.com' : auth.user!.url.toString();
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
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
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
                'Reviews',
                style: TextStyle(
                  // color: Theme.of(context).textTheme.bodyText1!.color,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider();
              },
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 40,
                left: 12,
                right: 12,
              ),
              itemCount: 5,
              itemBuilder: (index, context) {
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
                            const Text(
                              'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: size.height * 0.004),
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
                                      int.parse('4') <= index
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
        ),
      ),
    );
  }
}
