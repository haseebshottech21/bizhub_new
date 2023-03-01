import 'package:bizhub_new/components/deafult_button.dart';
import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../language/language_constant.dart';
import '../../view_model/bottom_navigation_view_model.dart';

class WithoutAuthScreen extends StatefulWidget {
  const WithoutAuthScreen({Key? key}) : super(key: key);

  @override
  State<WithoutAuthScreen> createState() => _WithoutAuthScreenState();
}

class _WithoutAuthScreenState extends State<WithoutAuthScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(systemNavigationBarColor: Colors.white),
    );
    final arg = ModalRoute.of(context)!.settings.arguments as bool;
    final provider =
        Provider.of<BottomNavigationViewModel>(context, listen: false);
    // print(checkArgument);
    return WillPopScope(
      onWillPop: arg
          ? () async {
              final shouldPop = Navigator.of(context).maybePop();
              return shouldPop;
            }
          : () async {
              final shouldPop = provider.toggleCurrentIndex(0);
              provider.routeCheck(context);
              // Navigator.of(context).pushNamedAndRemoveUntil(
              //   myLocationEnable ? RouteName.home : RouteName.getMyAddress,
              //   (route) => false,
              // );
              return shouldPop;
            },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          leading: IconButton(
            onPressed: arg
                ? () {
                    Navigator.of(context).pop();
                  }
                : () async {
                    provider.toggleCurrentIndex(0);
                    provider.routeCheck(context);
                  },
            icon: const Icon(
              Icons.clear,
              color: Colors.black,
              size: 26,
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Image.asset(
                  'assets/images/bizhub_logo_black.png',
                ),
                const SizedBox(height: 20),
                Text(
                  translation(context).welcomeBizhubTxt,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    translation(context).welcomeSubTxt,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                DefaultOutlineButton(
                  title: translation(context).welcomeLoginBtn,
                  btnIcon: true,
                  onPress: () {
                    Navigator.of(context).pushNamed(RouteName.login);
                  },
                ),
                const SizedBox(height: 12),
                DefaultOutlineButton(
                  title: translation(context).welcomeSignupBtn,
                  btnIcon: true,
                  onPress: () {
                    Navigator.of(context).pushNamed(RouteName.signup);
                  },
                ),
                const Spacer(),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "If you continue, you are accepting\n",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                        text: "Term & Condition",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            _launchUrl(
                                'https://app.websitepolicies.com/policies/view/5r6t2xx1');
                          },
                      ),
                      const TextSpan(
                        text: " and ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                        text: "Privacy Policy",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            _launchUrl(
                                'https://app.websitepolicies.com/policies/view/r06kud3i');
                          },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _launchUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw 'Could not launch $url';
  }
}
