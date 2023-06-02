// import 'package:bizhub_new/model/service_model.dart';
// import 'package:bizhub_new/view_model/all_services_view_model.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:share_plus/share_plus.dart';
// import '../view/home/all_service_detail_screen.dart';
import '../view/home/service_detail_from_dynamic_link.dart';

class DynamicLinkProvider {
  Future<String> createLink(String postId) async {
    const String url = 'https://bizhubai.page.link';

    final DynamicLinkParameters parameter = DynamicLinkParameters(
      androidParameters: const AndroidParameters(
        packageName: 'com.bizhub.bizhubAndroid',
        minimumVersion: 0,
      ),
      link: Uri.parse('$url/$postId'),
      uriPrefix: url,
      socialMetaTagParameters: const SocialMetaTagParameters(),
    );

    final FirebaseDynamicLinks links = FirebaseDynamicLinks.instance;

    final refLink = await links.buildShortLink(parameter);

    return refLink.shortUrl.toString();
  }

  // init dynamic link
  // void initDynamicLink() async {
  //   final instanceLink = await FirebaseDynamicLinks.instance.getInitialLink();

  //   if (instanceLink != null) {
  //     final Uri refLink = instanceLink.link;

  //     Share.share('this is the link ${refLink.queryParameters["post"]}');
  //   }
  // }

  Future<void> initDynamicLinks(BuildContext context) async {
    final navigator = Navigator.of(context);
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null) {
      var dynamicServiceId = initialLink.link.path.split('/').last;

      navigator.push(
        MaterialPageRoute(
          builder: (ctx) =>
              ServiceDetailFromDynamicLink(serviceId: dynamicServiceId),
        ),
      );
    }

    dynamicLinks.onLink.listen((dynamicLinkData) {
      // print('dynamic link' + dynamicLinkData.toString());
      // print('dynamic link path: ' + dynamicLinkData.link.path);

      var dynamicServiceId = dynamicLinkData.link.path.split('/').last;

      // print('id: ' + dynamicServiceId.toString());
      // Navigator.pushNamed(context, dynamicLinkData.link.path);

      navigator.push(
        MaterialPageRoute(
          builder: (ctx) =>
              ServiceDetailFromDynamicLink(serviceId: dynamicServiceId),
        ),
      );
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }
}
