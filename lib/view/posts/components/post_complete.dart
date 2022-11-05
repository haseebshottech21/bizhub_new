import 'package:bizhub_new/components/custom_lodaer.dart';
import 'package:bizhub_new/components/empty_icon.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/deafult_button.dart';
import '../../../model/offers_model.dart';
import '../../../utils/app_url.dart';
import '../../../utils/mytheme.dart';
import '../../../view_model/my_service_view_model.dart';

class PostComplete extends StatefulWidget {
  const PostComplete({Key? key}) : super(key: key);

  @override
  State<PostComplete> createState() => _PostCompleteState();
}

class _PostCompleteState extends State<PostComplete> {
  OfferModel? offerModel;
  TextEditingController reviewController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  getPostCompleteDetail() async {
    // String? serviceId = ModalRoute.of(context)!.settings.arguments as String;
    Map? complete = ModalRoute.of(context)!.settings.arguments as Map;

    final provider = Provider.of<MyServiceViewModel>(context, listen: false);
    await provider.getJobCompleteDetail(
      context: context,
      serviceId: complete['service_id'],
    );
    provider.rating = 0;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => getPostCompleteDetail(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    const titleStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    );

    const nameStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black87,
    );

    // String? serviceId = ModalRoute.of(context).settings.arguments String;

    // String? serviceId = ModalRoute.of(context)!.settings.arguments as String;
    // print(serviceId);
    Map? complete = ModalRoute.of(context)!.settings.arguments as Map;
    // print(complete['lead']);
    final serviceViewModel = context.watch<MyServiceViewModel>();
    // final serviceViewModel =
    //     Provider.of<MyServiceViewModel>(context, listen: false);

    return Scaffold(
      extendBody: true,
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
            fontSize: 22,
          ),
        ),
      ),
      body: serviceViewModel.loading
          ? const CustomLoader()
          : Padding(
              padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _uiTop(size, serviceViewModel),
                  const SizedBox(height: 24),
                  const Text('Who did the job ?', style: titleStyle),
                  const SizedBox(height: 10),
                  // serviceViewModel.serviceCompleteModel!.offersList!.isEmpty
                  //     ? const Padding(
                  //         padding: EdgeInsets.only(top: 20.0),
                  //         child: Center(
                  //           child: Text(
                  //             'No Offers',
                  //             style: TextStyle(fontSize: 20),
                  //           ),
                  //         ),
                  //       )
                  //     :
                  ListView.builder(
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
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(15.0),
                              ),
                            ),
                            backgroundColor: Colors.white,
                            builder: (context) => DraggableScrollableSheet(
                              initialChildSize: 0.75,
                              maxChildSize: 0.90,
                              minChildSize: 0.75,
                              expand: false,
                              builder: (context, scrollController) {
                                return SafeArea(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
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
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                              serviceViewModel.rating = 0;
                                              reviewController.clear();
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
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 30,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'RATE & REVIEW',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey,
                                                fontSize: 20,
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            userOffers.image == null
                                                ? Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade50,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        50,
                                                      ),
                                                    ),
                                                    child: const Icon(
                                                      Icons.person,
                                                      color: MyTheme.greenColor,
                                                    ),
                                                  )
                                                : SizedBox(
                                                    width: 60,
                                                    height: 60,
                                                    child: ClipOval(
                                                      child: Image.network(
                                                        AppUrl.baseUrl +
                                                            userOffers.image
                                                                .toString(),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                            const SizedBox(height: 16),
                                            Text(
                                              '${userOffers.firstName} ${userOffers.lastName}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18,
                                                letterSpacing: 0.5,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            const Divider(),
                                            const SizedBox(height: 10),
                                            Consumer<MyServiceViewModel>(
                                              builder:
                                                  (context, rateService, _) {
                                                return Column(
                                                  children: [
                                                    // Center(
                                                    //   child: Text(
                                                    //     rateService.review,
                                                    //     style: const TextStyle(
                                                    //       fontWeight:
                                                    //           FontWeight.w500,
                                                    //       fontSize: 22,
                                                    //       letterSpacing: 3.0,
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    // const SizedBox(height: 20),
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
                                                                .totalRating(1);
                                                          },
                                                          child: Icon(
                                                            Icons.star,
                                                            color: rateService
                                                                        .rating >=
                                                                    1
                                                                ? const Color(
                                                                    0xFFffa534)
                                                                : Colors.grey
                                                                    .shade300,
                                                            size: 50,
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            rateService
                                                                .totalRating(2);
                                                          },
                                                          child: Icon(
                                                            Icons.star,
                                                            color: rateService
                                                                        .rating >=
                                                                    2
                                                                ? const Color(
                                                                    0xFFffa534)
                                                                : Colors.grey
                                                                    .shade300,
                                                            size: 50,
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            rateService
                                                                .totalRating(3);
                                                          },
                                                          child: Icon(
                                                            Icons.star,
                                                            color: rateService
                                                                        .rating >=
                                                                    3
                                                                ? const Color(
                                                                    0xFFffa534)
                                                                : Colors.grey
                                                                    .shade300,
                                                            size: 50,
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            rateService
                                                                .totalRating(4);
                                                          },
                                                          child: Icon(
                                                            Icons.star,
                                                            color: rateService
                                                                        .rating >=
                                                                    4
                                                                ? const Color(
                                                                    0xFFffa534)
                                                                : Colors.grey
                                                                    .shade300,
                                                            size: 50,
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            rateService
                                                                .totalRating(5);
                                                          },
                                                          child: Icon(
                                                            Icons.star,
                                                            color: rateService
                                                                        .rating >=
                                                                    5
                                                                ? const Color(
                                                                    0xFFffa534)
                                                                : Colors.grey
                                                                    .shade300,
                                                            size: 50,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Form(
                                                      key: _formKey,
                                                      child: TextFormField(
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black),
                                                        cursorColor:
                                                            MyTheme.greenColor,
                                                        // keyboardType: TextInputType.multiline,
                                                        // maxLines: null,
                                                        controller:
                                                            reviewController,
                                                        minLines: 4,
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        keyboardType:
                                                            TextInputType
                                                                .multiline,
                                                        maxLines: null,
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Review not be empty';
                                                          } else if (value
                                                                  .length <
                                                              5) {
                                                            return 'Review must at least 5 characters';
                                                          }
                                                          return null;
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 15,
                                                            bottom: 10,
                                                            top: 10,
                                                            right: 15,
                                                          ),
                                                          // border:
                                                          //     InputBorder.none,
                                                          border:
                                                              OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  // borderSide:
                                                                  //     const BorderSide(
                                                                  //   color: Colors.black,
                                                                  // ),
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none),
                                                          // focusedBorder:
                                                          //     OutlineInputBorder(
                                                          //   borderRadius:
                                                          //       BorderRadius
                                                          //           .circular(4),
                                                          //   borderSide:
                                                          //       const BorderSide(
                                                          //     color: MyTheme
                                                          //         .greenColor,
                                                          //   ),
                                                          // ),
                                                          hintText:
                                                              'Please write your review',
                                                          hintStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black45),
                                                          fillColor: Colors
                                                              .grey.shade100,
                                                          filled: true,
                                                          // prefixIcon: Padding(
                                                          //   padding: const EdgeInsets.only(left: 12),
                                                          //   child: Icon(
                                                          //     widget.icon,
                                                          //     color: MyTheme.greenColor,
                                                          //   ),
                                                          // ),
                                                          prefixText: ' ',
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      if (complete['lead'] == true)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                          child: Consumer<MyServiceViewModel>(
                                            builder:
                                                (context, rateViewModel, _) {
                                              return DeafultButton(
                                                isloading:
                                                    serviceViewModel.loading,
                                                title: 'SUBMIT',
                                                onPress:
                                                    serviceViewModel.rating == 0
                                                        ? null
                                                        : () {
                                                            Map data = {
                                                              'service_id':
                                                                  serviceViewModel
                                                                      .serviceCompleteModel!
                                                                      .serviceId
                                                                      .toString(),
                                                              'rate_to':
                                                                  userOffers
                                                                      .userId
                                                                      .toString(),
                                                              'rate':
                                                                  '${serviceViewModel.rating}',
                                                              'review':
                                                                  reviewController
                                                                      .text,
                                                            };
                                                            if (!_formKey
                                                                .currentState!
                                                                .validate()) {
                                                              return;
                                                            } else {
                                                              rateViewModel
                                                                  .rateAndCompleteLeads(
                                                                data,
                                                                context,
                                                              );
                                                            }
                                                          },
                                              );
                                            },
                                          ),
                                        ),
                                      if (complete['lead'] == false)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                          child: Consumer<MyServiceViewModel>(
                                            builder:
                                                (context, rateViewModel, _) {
                                              return DeafultButton(
                                                isloading:
                                                    serviceViewModel.loading,
                                                title: 'SUBMIT',
                                                onPress:
                                                    serviceViewModel.rating == 0
                                                        ? null
                                                        : () {
                                                            Map data = {
                                                              'service_id':
                                                                  serviceViewModel
                                                                      .serviceCompleteModel!
                                                                      .serviceId
                                                                      .toString(),
                                                              'rate_to':
                                                                  userOffers
                                                                      .userId
                                                                      .toString(),
                                                              'rate':
                                                                  '${serviceViewModel.rating}',
                                                              'review':
                                                                  reviewController
                                                                      .text,
                                                            };

                                                            if (!_formKey
                                                                .currentState!
                                                                .validate()) {
                                                              return;
                                                            } else {
                                                              rateViewModel
                                                                  .rateAndCompleteService(
                                                                data,
                                                                context,
                                                              );
                                                            }
                                                          },
                                              );
                                            },
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: userOffers.image == null
                                ? const EmptyIcon()
                                : CircleAvatar(
                                    radius: 26,
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
                        ),
                      );
                    },
                  ),
                  // const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
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
                                maxHeight: MediaQuery.of(context).size.height,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
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
                                              BorderRadius.circular(8),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'RATE & REVIEW',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Container(
                                          width: 65,
                                          height: 65,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade50,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: const Icon(
                                            Icons.person,
                                            color: MyTheme.greenColor,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        const Text(
                                          'Someone else',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 20,
                                            letterSpacing: 0.5,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        const Divider(),
                                        const SizedBox(height: 16),
                                        if (complete['lead'] == true)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                            ),
                                            child: Consumer<MyServiceViewModel>(
                                              builder:
                                                  (context, rateViewModel, _) {
                                                return DeafultButton(
                                                  isloading:
                                                      serviceViewModel.loading,
                                                  title: 'DONE',
                                                  onPress: () {
                                                    Map data = {
                                                      'service_id': serviceViewModel
                                                          .serviceCompleteModel!
                                                          .serviceId
                                                          .toString(),
                                                    };

                                                    rateViewModel
                                                        .rateAndCompleteLeads(
                                                      data,
                                                      context,
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        if (complete['lead'] == false)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                            ),
                                            child: Consumer<MyServiceViewModel>(
                                              builder:
                                                  (context, rateViewModel, _) {
                                                return DeafultButton(
                                                  isloading:
                                                      serviceViewModel.loading,
                                                  title: 'DONE',
                                                  onPress: () {
                                                    Map data = {
                                                      'service_id': serviceViewModel
                                                          .serviceCompleteModel!
                                                          .serviceId
                                                          .toString(),
                                                    };

                                                    rateViewModel
                                                        .rateAndCompleteService(
                                                      data,
                                                      context,
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        const SizedBox(height: 16),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: const ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: EmptyIcon(),
                      title: Text(
                        'Someone else',
                        style: nameStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

Widget _uiTop(Size size, MyServiceViewModel serviceViewModel) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
    child: SizedBox(
      height: size.height * 0.11,
      // padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
      // color: Colors.yellow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: SizedBox(
              height: size.height,
              width: size.width * 0.20,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: serviceViewModel
                        .serviceCompleteModel!.imagesList!.isEmpty
                    ? Container(
                        color: Colors.grey.shade100,
                        child: Icon(
                          Icons.photo_library,
                          color: Colors.grey.shade400,
                          size: 50,
                        ),
                      )
                    :
                    // : Image.network(
                    //     AppUrl.baseUrl +
                    //         serviceViewModel
                    //             .serviceCompleteModel!.imagesList![0].image
                    //             .toString(),
                    //     fit: BoxFit.cover,
                    //   ),
                    CachedNetworkImage(
                        // height: constraints.maxHeight * 0.55,
                        // width: double.infinity,
                        fadeInDuration: const Duration(milliseconds: 300),
                        placeholder: (context, url) => const Icon(
                          Icons.photo_library,
                          color: MyTheme.greenColor,
                          size: 30,
                        ),
                        imageUrl: AppUrl.baseUrl +
                            serviceViewModel
                                .serviceCompleteModel!.imagesList![0].image
                                .toString(),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
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
                      fontSize: 18,
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
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
