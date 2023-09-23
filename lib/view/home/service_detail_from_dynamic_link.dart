import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_loader.dart';
import '../../language/language_constant.dart';
import '../../utils/icons.dart';
import '../../utils/mytheme.dart';
import '../../view_model/all_services_view_model.dart';
import '../../view_model/bottom_navigation_view_model.dart';
import '../auth/without_auth_screen.dart';
import 'components/all_service_detail_body.dart';
import 'components/send_message.dart';
import 'components/send_offer.dart';

class ServiceDetailFromDynamicLink extends StatefulWidget {
  final String serviceId;
  const ServiceDetailFromDynamicLink({Key? key, required this.serviceId})
      : super(key: key);

  @override
  State<ServiceDetailFromDynamicLink> createState() =>
      _ServiceDetailFromDynamicLinkState();
}

class _ServiceDetailFromDynamicLinkState
    extends State<ServiceDetailFromDynamicLink> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final offerController = TextEditingController();
  final messageController = TextEditingController();

  getServiceDetail() async {
    final provider = Provider.of<AllServicesViewModel>(context, listen: false);

    provider.getAllServiceDetailWithoutAuth(
      context: context,
      serviceId: widget.serviceId,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => getServiceDetail(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final allServiceViewModel =
        Provider.of<AllServicesViewModel>(context, listen: false);
    final bottomProvider = Provider.of<BottomNavigationViewModel>(context);

    // return Scaffold(
    //   body: Consumer<AllServicesViewModel>(
    //     builder: (context, provider, _) {
    //       if (provider.loading) {
    //         return const Center(child: CircularProgressIndicator());
    //       }
    //       return Container();
    //     },
    //   ),
    // );

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          // AllServiceDetailBody(allServiceViewModel: allServiceViewModel),
          Consumer<AllServicesViewModel>(
            builder: (context, allServiceViewModel, _) {
              if (allServiceViewModel.loading) {
                return const CustomLoader();
              } else {
                return Stack(
                  children: [
                    AllServiceDetailBody(
                      // allServiceViewModel: allServiceViewModel,
                      bottomNavigationViewModel: bottomProvider,
                    ),
                    // if (allServiceViewModel.offerLoading)
                    //   const Center(
                    //     child: CircularProgressIndicator(
                    //       color: Colors.white,
                    //       strokeWidth: 1,
                    //     ),
                    //   ),
                  ],
                );
              }
            },
          ),
          Positioned(
            top: 0,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.09,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent.withOpacity(0.1),
                        Colors.transparent.withOpacity(0.2),
                        Colors.transparent,
                      ],
                      stops: const [
                        0.1,
                        0.5,
                        0.9,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Positioned(
                  top: Platform.isIOS ? 55 : 40,
                  left: 20,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      CupertinoIcons.back,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: Platform.isIOS ? 35 : 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyTheme.greenColor,
                      padding: const EdgeInsets.all(10.0),
                    ),
                    onPressed: bottomProvider.token == null ||
                            bottomProvider.token == ''
                        ? () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => const WithoutAuthScreen(),
                                settings: const RouteSettings(
                                  arguments: true,
                                ),
                              ),
                            )
                        : () {
                            var bottomSheetController =
                                scaffoldKey.currentState?.showBottomSheet(
                              (context) => SendMessage(
                                formKey: _formKey,
                                controller: messageController,
                                servicesViewModel: allServiceViewModel,
                              ),
                            );
                            bottomSheetController!.closed.then((value) {
                              messageController.clear();
                            });
                          },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          chat,
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(width: 25),
                        Text(
                          translation(context).messageText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyTheme.greenColor,
                      padding: const EdgeInsets.all(10.0),
                    ),
                    onPressed: bottomProvider.token == null ||
                            bottomProvider.token == ''
                        ? () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => const WithoutAuthScreen(),
                                settings: const RouteSettings(
                                  arguments: true,
                                ),
                              ),
                            )
                        : () {
                            var bottomSheetController =
                                scaffoldKey.currentState?.showBottomSheet(
                              (context) => SendOffer(
                                formKey: _formKey,
                                controller: offerController,
                                servicesViewModel: allServiceViewModel,
                              ),
                            );

                            // showFoatingActionButton(false);
                            bottomSheetController!.closed.then((value) {
                              offerController.clear();
                            });
                          },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          dollor,
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(width: 25),
                        Text(
                          translation(context).offerText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
