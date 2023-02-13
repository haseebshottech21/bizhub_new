import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/deafult_button.dart';
import '../../../components/empty_icon.dart';
import '../../../utils/app_url.dart';
import '../../../utils/mytheme.dart';
import '../../../view_model/my_service_view_model.dart';

const nameStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: Colors.black87,
);

class MyPostOffers extends StatelessWidget {
  const MyPostOffers({
    Key? key,
    required this.serviceViewModel,
    required this.complete,
  }) : super(key: key);

  final MyServiceViewModel serviceViewModel;
  final Map<dynamic, dynamic> complete;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController reviewController = TextEditingController();
    // print(MediaQuery.of(context).viewInsets.bottom);
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: serviceViewModel.serviceCompleteModel!.offersList!.length,
      itemBuilder: (context, index) {
        // index = index + 1;
        final userOffers =
            serviceViewModel.serviceCompleteModel!.offersList![index].user!;
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
              builder: (context) => DraggableScrollableActuator(
                child: DraggableScrollableSheet(
                  // initialChildSize: MediaQuery.of(context).viewInsets.bottom > 0
                  //     ? 0.75
                  //     : 0.60,
                  // maxChildSize: MediaQuery.of(context).viewInsets.bottom > 0
                  //     ? 0.90
                  //     : 0.75,
                  // minChildSize: MediaQuery.of(context).viewInsets.bottom > 0
                  //     ? 0.75
                  //     : 0.60,
                  // expand: false,
                  initialChildSize: 0.60,
                  minChildSize: 0.55,
                  maxChildSize: 0.90,
                  snap: true,
                  expand: false,
                  snapSizes: const [
                    0.60,
                    0.90,
                  ],
                  builder: (context, scrollController) {
                    return SafeArea(
                      child: ListView(
                        shrinkWrap: true,
                        controller: scrollController,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  borderRadius: BorderRadius.circular(8),
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
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                          color: Colors.grey.shade50,
                                          borderRadius: BorderRadius.circular(
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
                                                userOffers.image.toString(),
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
                                  builder: (context, rateService, _) {
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
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              // onTap: serviceViewModel
                                              //     .totalRating(1),
                                              onTap: () {
                                                rateService.totalRating(1);
                                              },
                                              child: Icon(
                                                Icons.star,
                                                color: rateService.rating >= 1
                                                    ? const Color(0xFFffa534)
                                                    : Colors.grey.shade300,
                                                size: 50,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                rateService.totalRating(2);
                                              },
                                              child: Icon(
                                                Icons.star,
                                                color: rateService.rating >= 2
                                                    ? const Color(0xFFffa534)
                                                    : Colors.grey.shade300,
                                                size: 50,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                rateService.totalRating(3);
                                              },
                                              child: Icon(
                                                Icons.star,
                                                color: rateService.rating >= 3
                                                    ? const Color(0xFFffa534)
                                                    : Colors.grey.shade300,
                                                size: 50,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                rateService.totalRating(4);
                                              },
                                              child: Icon(
                                                Icons.star,
                                                color: rateService.rating >= 4
                                                    ? const Color(0xFFffa534)
                                                    : Colors.grey.shade300,
                                                size: 50,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                rateService.totalRating(5);
                                              },
                                              child: Icon(
                                                Icons.star,
                                                color: rateService.rating >= 5
                                                    ? const Color(0xFFffa534)
                                                    : Colors.grey.shade300,
                                                size: 50,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Form(
                                          key: formKey,
                                          child: TextFormField(
                                            style: const TextStyle(
                                                color: Colors.black),
                                            cursorColor: MyTheme.greenColor,
                                            // keyboardType: TextInputType.multiline,
                                            // maxLines: null,
                                            controller: reviewController,
                                            minLines: 4,
                                            textInputAction:
                                                TextInputAction.done,
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Review not be empty';
                                              } else if (value.length < 5) {
                                                return 'Review must at least 5 characters';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                left: 15,
                                                bottom: 10,
                                                top: 10,
                                                right: 15,
                                              ),
                                              // border:
                                              //     InputBorder.none,
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  // borderSide:
                                                  //     const BorderSide(
                                                  //   color: Colors.black,
                                                  // ),
                                                  borderSide: BorderSide.none),
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
                                              hintStyle: const TextStyle(
                                                  color: Colors.black45),
                                              fillColor: Colors.grey.shade100,
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
                          const SizedBox(height: 15),
                          if (complete['lead'] == true)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Consumer<MyServiceViewModel>(
                                builder: (context, rateViewModel, _) {
                                  return DeafultButton(
                                    isloading: serviceViewModel.loading,
                                    title: 'SUBMIT',
                                    onPress: serviceViewModel.rating == 0
                                        ? null
                                        : () {
                                            Map data = {
                                              'service_id': serviceViewModel
                                                  .serviceCompleteModel!
                                                  .serviceId
                                                  .toString(),
                                              'rate_to':
                                                  userOffers.userId.toString(),
                                              'rate':
                                                  '${serviceViewModel.rating}',
                                              'review': reviewController.text,
                                            };
                                            if (!formKey.currentState!
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
                                horizontal: 16,
                              ),
                              child: Consumer<MyServiceViewModel>(
                                builder: (context, rateViewModel, _) {
                                  return DeafultButton(
                                    isloading: serviceViewModel.loading,
                                    title: 'SUBMIT',
                                    onPress: serviceViewModel.rating == 0
                                        ? null
                                        : () {
                                            Map data = {
                                              'service_id': serviceViewModel
                                                  .serviceCompleteModel!
                                                  .serviceId
                                                  .toString(),
                                              'rate_to':
                                                  userOffers.userId.toString(),
                                              'rate':
                                                  '${serviceViewModel.rating}',
                                              'review': reviewController.text,
                                            };

                                            if (!formKey.currentState!
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
                        AppUrl.baseUrl + userOffers.image.toString(),
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
    );
  }
}
