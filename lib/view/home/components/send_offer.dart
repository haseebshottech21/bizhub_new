import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../language/language_constant.dart';
import '../../../utils/icons.dart';
import '../../../utils/mytheme.dart';
import '../../../view_model/all_services_view_model.dart';

class SendOffer extends StatelessWidget {
  final TextEditingController controller;
  final AllServicesViewModel servicesViewModel;
  final GlobalKey<FormState> formKey;

  const SendOffer({
    required this.controller,
    required this.servicesViewModel,
    required this.formKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // controller.text =
    //     servicesViewModel.serviceDetalModel!.serviceAmount.toString();
    // controller.text =
    //     '\$ ${servicesViewModel.serviceDetalModel!.serviceAmount}';
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      // margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
      height: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: kElevationToShadow[4],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 12,
              left: 12,
              right: 12,
            ),
            child: Container(
              height: 4,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(dollor, size: 26),
              const SizedBox(width: 6),
              Text(
                translation(context).offerTitle,
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
          TextField(
            controller: controller,
            style: const TextStyle(color: Colors.black, fontSize: 32),
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.center,
            autofocus: true,
            // cursorColor: Colors.transparent,
            keyboardType: TextInputType.number,
            showCursor: false,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(7),
            ],
            decoration: const InputDecoration(
              hintText: '\$ 0',
              hintStyle: TextStyle(color: Colors.black),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Consumer<AllServicesViewModel>(
                  builder: (context, provider, _) {
                    return provider.success
                        ? Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: const BoxDecoration(
                              color: MyTheme.greenColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.check, color: Colors.white),
                          )
                        : ElevatedButton(
                            onPressed: provider.offerLoading
                                ? null
                                : () async {
                                    // controller.text =
                                    //     controller.text.split('\$')[1];
                                    Map data = {
                                      'receiver_id': servicesViewModel
                                          .serviceDetalModel!.userId,
                                      'service_id': servicesViewModel
                                          .serviceDetalModel!.serviceId,
                                      'offer': controller.text.trim(),
                                    };

                                    // print(data);
                                    // await Future.delayed(Duration(milliseconds: 500));
                                    // controller.clear();
                                    // Navigator.pop(context);

                                    // if (formKey.currentState!.validate()) {
                                    provider.sendOffer(
                                      data: data,
                                      context: context,
                                      controller: controller,
                                    );
                                    // }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyTheme.greenColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 10.0,
                              ),
                            ),
                            child: provider.offerLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3.0,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    translation(context).sendOfferBtnText,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                          );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
