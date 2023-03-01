import 'package:bizhub_new/view/account/component/report_reason_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/mytheme.dart';
import '../../../view_model/auth_view_model.dart';

class ReportUserBottom extends StatelessWidget {
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  final String reportUserId;
  const ReportUserBottom({
    required this.reportUserId,
    required this.formKey,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      // margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
      height: size.height * 0.50,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text(
            'Report user',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          // ReportReasonItem(),
          Consumer<AuthViewModel>(builder: (context, provider, _) {
            return Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 6,
                      ),
                    );
                  },
                  padding: EdgeInsets.zero,
                  itemCount: provider.reportedData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      // highlightColor: Colors.red,
                      splashColor: Colors.transparent.withOpacity(0.1),
                      onTap: () {
                        provider.selectReportedReason(index);
                      },
                      child: ReportReasonItem(
                        reportModel: provider.reportedData[index],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: TextFormField(
                      // validator: ,
                      validator: (value) {
                        return value!.isEmpty
                            ? 'Please enter your comment'
                            : null;
                      },
                      controller: controller,
                      // autofocus: true,
                      maxLines: 2,
                      cursorColor: MyTheme.greenColor,
                      style: const TextStyle(color: Colors.black),
                      // textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        // filled: true,
                        // fillColor: Colors.grey[50],
                        hintText: 'Comment',
                        contentPadding: EdgeInsets.all(15),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black87,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: MyTheme.greenColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black87,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
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
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        provider.unSelectReportedReason(controller);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        Map data = {
                          'report_to': reportUserId,
                          'comment': controller.text.trim(),
                          'reason': provider.reportReasonText,
                        };

                        if (formKey.currentState!.validate()) {
                          // print(data);
                          provider
                              .reportUser(
                            data: data,
                            context: context,
                            controller: controller,
                          )
                              .then(
                            (value) {
                              provider.unSelectReportedReason(controller);
                            },
                          );
                        }
                      },
                      child: const Text(
                        'Send',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
