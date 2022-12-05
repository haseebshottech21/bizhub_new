import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/deafult_button.dart';
import '../../../components/empty_icon.dart';
import '../../../utils/mytheme.dart';
import '../../../view_model/my_service_view_model.dart';

const nameStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: Colors.black87,
);

class RateBottomSheet extends StatelessWidget {
  const RateBottomSheet({
    Key? key,
    required this.complete,
    required this.serviceViewModel,
  }) : super(key: key);

  final Map<dynamic, dynamic> complete;
  final MyServiceViewModel serviceViewModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                      padding: const EdgeInsets.symmetric(horizontal: 30),
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
                          Container(
                            width: 65,
                            height: 65,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(50),
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
                                builder: (context, rateViewModel, _) {
                                  return DeafultButton(
                                    isloading: serviceViewModel.loading,
                                    title: 'DONE',
                                    onPress: () {
                                      Map data = {
                                        'service_id': serviceViewModel
                                            .serviceCompleteModel!.serviceId
                                            .toString(),
                                      };

                                      rateViewModel.rateAndCompleteLeads(
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
                                builder: (context, rateViewModel, _) {
                                  return DeafultButton(
                                    isloading: serviceViewModel.loading,
                                    title: 'DONE',
                                    onPress: () {
                                      Map data = {
                                        'service_id': serviceViewModel
                                            .serviceCompleteModel!.serviceId
                                            .toString(),
                                      };

                                      rateViewModel.rateAndCompleteService(
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
    );
  }
}
