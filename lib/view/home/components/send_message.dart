import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../language/language_constant.dart';
import '../../../utils/mytheme.dart';
import '../../../view_model/all_services_view_model.dart';

class SendMessage extends StatelessWidget {
  final TextEditingController controller;
  final AllServicesViewModel servicesViewModel;
  final GlobalKey<FormState> formKey;
  const SendMessage({
    required this.formKey,
    required this.controller,
    required this.servicesViewModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      // margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
      height: 225,
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
          Text(
            translation(context).sendMessageTitle,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 12),
          Form(
            key: formKey,
            child: TextFormField(
              // validator: ,
              validator: (value) {
                return value!.isEmpty ? 'Please enter your message' : null;
              },
              controller: controller,
              autofocus: true,
              cursorColor: MyTheme.greenColor,
              style: const TextStyle(color: Colors.black),

              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[50],
                hintText: translation(context).sendMessageFieldHint,
                contentPadding: const EdgeInsets.all(15),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(4),
                //   borderSide: const BorderSide(
                //     color: MyTheme.greenColor,
                //   ),
                // ),
              ),
            ),
          ),

          const SizedBox(height: 12),
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
                                    Map data = {
                                      'receiver_id': servicesViewModel
                                          .serviceDetalModel!.userId,
                                      'service_id': servicesViewModel
                                          .serviceDetalModel!.serviceId,
                                      'message': controller.text.trim(),
                                    };

                                    // print(data);
                                    // await Future.delayed(Duration(milliseconds: 500));
                                    // controller.clear();
                                    // Navigator.pop(context);

                                    if (formKey.currentState!.validate()) {
                                      provider.sendMessage(
                                        data: data,
                                        context: context,
                                        controller: controller,
                                      );
                                    }
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
                                    translation(context).sendMessageBtnText,
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
          // !checkingFlight
          //     ? MaterialButton(
          //         color: Colors.grey[800],
          //         onPressed: () async {
          //           setState(() {
          //             checkingFlight = true;
          //           });
          //           await Future.delayed(
          //               Duration(seconds: 1));
          //           setState(() {
          //             success = true;
          //           });
          //           await Future.delayed(
          //               Duration(milliseconds: 500));
          //           // Navigator.pop(context);
          //         },
          //         child: Text(
          //           'Send Message',
          //           style: TextStyle(color: Colors.white),
          //         ),
          //       )
          //     : !success
          //         ? CircularProgressIndicator()
          //         : Icon(
          //             Icons.check,
          //             color: Colors.green,
          //           ),
        ],
      ),
    );
  }
}
