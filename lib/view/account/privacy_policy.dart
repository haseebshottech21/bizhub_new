import 'dart:async';
import 'dart:io';
import 'package:bizhub_new/utils/mytheme.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../components/custom_loader.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  bool isLoading = true;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.greenColor,
        title: const Text(
          'Privacy Policy',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl:
                'https://app.websitepolicies.com/policies/view/r06kud3i',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onProgress: (int progress) {
              // print('WebView is loading (progress : $progress%)');
            },
            // javascriptChannels: <JavascriptChannel>{
            //   _toasterJavascriptChannel(context),
            // },
            navigationDelegate: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                // print('blocking navigation to $request}');
                return NavigationDecision.prevent;
              }
              // print('allowing navigation to $request');
              return NavigationDecision.navigate;
            },
            onPageStarted: (String url) {
              // print('Page started loading: $url');
            },
            onPageFinished: (String url) {
              // print('Page finished loading: $url');
              setState(() {
                isLoading = false;
              });
            },
            gestureNavigationEnabled: true,
            backgroundColor: const Color(0x00000000),
          ),
          isLoading ? const CustomLoader() : Stack(),
        ],
      ),
      // floatingActionButton: favoriteButton(),
    );
  }
}
