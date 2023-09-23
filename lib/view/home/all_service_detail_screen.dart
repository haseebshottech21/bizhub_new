import 'dart:developer';
import 'dart:io';
import 'package:bizhub_new/components/custom_loader.dart';
import 'package:bizhub_new/model/service_model.dart';
import 'package:bizhub_new/utils/icons.dart';
import 'package:bizhub_new/view/home/components/all_service_detail_body.dart';
import 'package:bizhub_new/view_model/all_services_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../language/language_constant.dart';
import '../../utils/dynamic_links.dart';
import '../../utils/mytheme.dart';
import '../../view_model/bottom_navigation_view_model.dart';
import '../auth/without_auth_screen.dart';
import 'components/send_message.dart';
import 'components/send_offer.dart';

class AllServiceDetail extends StatefulWidget {
  const AllServiceDetail({Key? key}) : super(key: key);

  @override
  State<AllServiceDetail> createState() => _AllServiceDetailState();
}

class _AllServiceDetailState extends State<AllServiceDetail> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final offerController = TextEditingController();
  final messageController = TextEditingController();

  getAllServiceDetail() async {
    final provider = Provider.of<AllServicesViewModel>(context, listen: false);
    ServiceModel service =
        ModalRoute.of(context)!.settings.arguments as ServiceModel;
    await provider.getAllServiceDetailWithCheckAuth(
      context: context,
      serviceId: service.serviceId.toString(),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => getAllServiceDetail(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final allServiceViewModel =
    //     Provider.of<AllServicesViewModel>(context, listen: false);
    final bottomProvider = Provider.of<BottomNavigationViewModel>(context);

    // log('service ${allServiceViewModel.loading}');
    // log('user ${allServiceViewModel.serviceDetalModel!.user!.firstName}');
    // log('user ${allServiceViewModel.serviceDetalModel!.user!.lastName}');

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          // AllServiceDetailBody(allServiceViewModel: allServiceViewModel),
          // Consumer<AllServicesViewModel>(
          //   builder: (context, allServiceViewModel, _) {
          //     if (allServiceViewModel.loading) {
          //       return const CustomLoader();
          //     } else {
          //       return Stack(
          //         children: [
          //           AllServiceDetailBody(
          //             allServiceViewModel: allServiceViewModel,
          //             bottomNavigationViewModel: bottomProvider,
          //           ),
          //           // if (allServiceViewModel.offerLoading)
          //           //   const Center(
          //           //     child: CircularProgressIndicator(
          //           //       color: Colors.white,
          //           //       strokeWidth: 1,
          //           //     ),
          //           //   ),
          //         ],
          //       );
          //     }
          //   },
          // ),

          AllServiceDetailBody(
            // allServiceViewModel: allServiceViewModel,
            bottomNavigationViewModel: bottomProvider,
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
                Consumer<AllServicesViewModel>(
                    builder: (context, allServiceViewModel, _) {
                  return Positioned(
                    top: Platform.isIOS ? 55 : 40,
                    right: 20,
                    child: InkWell(
                      onTap: () {
                        DynamicLinkProvider()
                            .createLink(
                          allServiceViewModel.serviceDetalModel!.serviceId!,
                        )
                            .then(
                          (value) {
                            Share.share(value);
                          },
                        );
                      },
                      child: const Icon(
                        CupertinoIcons.share,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          // if (allServiceViewModel.serviceDetalModel!.user!.firstName !=
          //         'Guest' &&
          //     allServiceViewModel.serviceDetalModel!.user!.lastName == 'User')

          // if (!(  allServiceViewModel.serviceDetalModel!.user!.firstName ==
          //     "Guest"))
          Consumer<AllServicesViewModel>(
              builder: (context, allServiceViewModel, _) {
            if (allServiceViewModel.loading) {
              return const SizedBox();
            }
            if (allServiceViewModel.serviceDetalModel!.user!.firstName ==
                'Guest') {
              return const SizedBox();
            }
            return Positioned(
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
                ));
          }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    offerController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
