import 'package:bizhub_new/components/deafult_button.dart';
import 'package:bizhub_new/model/offers_model.dart';
import 'package:bizhub_new/utils/app_url.dart';
import 'package:bizhub_new/utils/mytheme.dart';
// import 'package:bizhub_new/utils/mytheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_model/my_service_view_model.dart';
// import '../components/rate_review.dart';

class LeadComplete extends StatefulWidget {
  const LeadComplete({Key? key}) : super(key: key);

  @override
  State<LeadComplete> createState() => _LeadCompleteState();
}

class _LeadCompleteState extends State<LeadComplete> {
  OfferModel? offerModel;

  getLeadCompleteDetail() async {
    String? serviceId = ModalRoute.of(context)!.settings.arguments as String;
    final provider = Provider.of<MyServiceViewModel>(context, listen: false);
    await provider.getJobCompleteDetail(
      context: context,
      serviceId: serviceId,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => getLeadCompleteDetail(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    const titleStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    );

    const nameStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.black87,
    );

    // String? serviceId = ModalRoute.of(context).settings.arguments String;

    // String? serviceId = ModalRoute.of(context)!.settings.arguments as String;
    // print(serviceId);

    final serviceViewModel = context.watch<MyServiceViewModel>();
    // final serviceViewModel =
    //     Provider.of<MyServiceViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        title: const Text(
          'Mark as Complete',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: serviceViewModel.loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _uiTop(size, serviceViewModel),
                  const SizedBox(height: 20),
                  const Text('Who did the job ?', style: titleStyle),
                  const SizedBox(height: 10),
                  serviceViewModel.serviceCompleteModel!.offersList!.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Center(
                            child: Text(
                              'No Offers',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: serviceViewModel
                              .serviceCompleteModel!.offersList!.length,
                          itemBuilder: (context, index) {
                            // index = index + 1;
                            final userOffers = serviceViewModel
                                .serviceCompleteModel!.offersList![index].user!;
                            return GestureDetector(
                              onTap: () {
                                // rateReviewDialog(
                                //   status: '1',
                                //   userName:
                                //       '${userOffers.firstName} ${userOffers.lastName}',
                                //   context: context,
                                // );

                                showModalBottomSheet(
                                  backgroundColor: Colors.white,
                                  context: context,
                                  // isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(15.0),
                                    ),
                                  ),
                                  builder: (BuildContext context) {
                                    return SafeArea(
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxHeight: MediaQuery.of(context)
                                              .size
                                              .height,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                // GestureDetector(
                                                //   onTap: () {
                                                //     Navigator.of(context)
                                                //         .pop();
                                                //   },
                                                //   child: const Icon(
                                                //     Icons.clear,
                                                //     size: 20,
                                                //   ),
                                                // ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                    top: 12,
                                                    left: 12,
                                                  ),
                                                  child: SizedBox(),
                                                ),
                                                Container(
                                                  height: 6,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[400],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                    // serviceViewModel.rating = 0;
                                                  },
                                                  child: const Padding(
                                                    padding: EdgeInsets.only(
                                                      top: 12,
                                                      right: 12,
                                                    ),
                                                    child: Icon(
                                                      Icons.clear,
                                                      size: 24,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    'RATE & REVIEW',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.grey,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 16),
                                                  userOffers.image == null
                                                      ? Container(
                                                          width: 50,
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .grey.shade50,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                          child: const Icon(
                                                            Icons.person,
                                                            color: MyTheme
                                                                .greenColor,
                                                          ),
                                                        )
                                                      : SizedBox(
                                                          width: 50,
                                                          height: 50,
                                                          child: ClipOval(
                                                            child:
                                                                Image.network(
                                                              AppUrl.baseUrl +
                                                                  userOffers
                                                                      .image
                                                                      .toString(),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                  const SizedBox(height: 12),
                                                  Text(
                                                    '${userOffers.firstName} ${userOffers.lastName}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 18,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  const Divider(),
                                                  const SizedBox(height: 20),
                                                  Consumer<MyServiceViewModel>(
                                                      builder: (context,
                                                          rateService, _) {
                                                    return Column(
                                                      children: [
                                                        Center(
                                                          child: Text(
                                                            rateService.review,
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 22,
                                                              letterSpacing:
                                                                  3.0,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 20),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            GestureDetector(
                                                              // onTap: serviceViewModel
                                                              //     .totalRating(1),
                                                              onTap: () {
                                                                rateService
                                                                    .totalRating(
                                                                        1);
                                                              },
                                                              child: Icon(
                                                                Icons.star,
                                                                color: rateService
                                                                            .rating >=
                                                                        1
                                                                    ? const Color(
                                                                        0xFFffa534)
                                                                    : Colors
                                                                        .grey
                                                                        .shade400,
                                                                size: 50,
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                rateService
                                                                    .totalRating(
                                                                        2);
                                                              },
                                                              child: Icon(
                                                                Icons.star,
                                                                color: rateService
                                                                            .rating >=
                                                                        2
                                                                    ? const Color(
                                                                        0xFFffa534)
                                                                    : Colors
                                                                        .grey
                                                                        .shade400,
                                                                size: 50,
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                rateService
                                                                    .totalRating(
                                                                        3);
                                                              },
                                                              child: Icon(
                                                                Icons.star,
                                                                color: rateService
                                                                            .rating >=
                                                                        3
                                                                    ? const Color(
                                                                        0xFFffa534)
                                                                    : Colors
                                                                        .grey
                                                                        .shade400,
                                                                size: 50,
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                rateService
                                                                    .totalRating(
                                                                        4);
                                                              },
                                                              child: Icon(
                                                                Icons.star,
                                                                color: rateService
                                                                            .rating >=
                                                                        4
                                                                    ? const Color(
                                                                        0xFFffa534)
                                                                    : Colors
                                                                        .grey
                                                                        .shade400,
                                                                size: 50,
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                rateService
                                                                    .totalRating(
                                                                        5);
                                                              },
                                                              child: Icon(
                                                                Icons.star,
                                                                color: rateService
                                                                            .rating >=
                                                                        5
                                                                    ? const Color(
                                                                        0xFFffa534)
                                                                    : Colors
                                                                        .grey
                                                                        .shade400,
                                                                size: 50,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              child:
                                                  Consumer<MyServiceViewModel>(
                                                builder: (context,
                                                    rateViewModel, _) {
                                                  return DeafultButton(
                                                    isloading: serviceViewModel
                                                        .loading,
                                                    title: 'DONE',
                                                    onPress: serviceViewModel
                                                                .rating ==
                                                            0
                                                        ? null
                                                        : () {
                                                            Map data = {
                                                              'service_id':
                                                                  serviceViewModel
                                                                      .serviceCompleteModel!
                                                                      .serviceId
                                                                      .toString(),
                                                              'complete_by':
                                                                  userOffers
                                                                      .userId
                                                                      .toString(),
                                                              'rate':
                                                                  '${serviceViewModel.rating}',
                                                              'review':
                                                                  serviceViewModel
                                                                      .review,
                                                            };
                                                            // if (textController.text.length > 0) {
                                                            //   addToMessages(textController.text);
                                                            //   textController.clear();
                                                            //   showTheMic();
                                                            // }
                                                            print(data);
                                                            rateViewModel
                                                                .rateAndCompleteLeads(
                                                              data,
                                                              context,
                                                            );
                                                            // if (messageController
                                                            //     .text
                                                            //     .isNotEmpty) {
                                                            //   messageViewModel
                                                            //       .sendMessage(
                                                            //     data:
                                                            //         data,
                                                            //     context:
                                                            //         context,
                                                            //     chatId: chat[
                                                            //         'chat_id'],
                                                            //   );
                                                            //   messageController
                                                            //       .clear();
                                                            // }
                                                          },
                                                    // style: ElevatedButton
                                                    //     .styleFrom(
                                                    //   primary:
                                                    //       MyTheme.greenColor,
                                                    // ),
                                                    // child: const Text('DONE'),
                                                  );
                                                },
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: userOffers.image == null
                                    ? CircleAvatar(
                                        backgroundColor: Colors.grey.shade100,
                                        child: const Icon(
                                          Icons.person,
                                          color: MyTheme.greenColor,
                                        ),
                                      )
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          AppUrl.baseUrl +
                                              userOffers.image.toString(),
                                        ),
                                      ),
                                title: Text(
                                  '${userOffers.firstName} ${userOffers.lastName}',
                                  style: nameStyle,
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
    );
  }

  // Widget _offerItem(
  //   BuildContext context,
  //   TextStyle nameStyle,
  // ) {
  //   return GestureDetector(
  //     onTap: () {
  //       rateReviewDialog(
  //         status: '1',
  //         userName: 'John Cary',
  //         context: context,
  //       );
  //     },
  //     child: ListTile(
  //       contentPadding: EdgeInsets.zero,
  //       leading: const CircleAvatar(
  //         backgroundImage: AssetImage('assets/images/job2.jpg'),
  //       ),
  //       title: Text(
  //         'username',
  //         style: nameStyle,
  //       ),
  //     ),
  //   );
  // }

  Widget _uiTop(Size size, MyServiceViewModel serviceViewModel) {
    return SizedBox(
      height: size.height * 0.10,
      // padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
      // color: Colors.yellow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: size.height,
            width: size.width * 0.22,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Image.network(
                AppUrl.baseUrl +
                    serviceViewModel.serviceCompleteModel!.imagesList![0].image
                        .toString(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * 0.70,
                  child: Text(
                    serviceViewModel.serviceCompleteModel!.serviceTitle
                        .toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                Text(
                  '\$ ${serviceViewModel.serviceCompleteModel!.serviceAmount.toString()}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
