import 'package:bizhub_new/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../components/deafult_button.dart';
import '../../../utils/mytheme.dart';
import '../../../view_model/all_services_view_model.dart';
import '../../../view_model/bottom_navigation_view_model.dart';
import '../../auth/without_auth_screen.dart';

class ServicesDetailBottom extends StatelessWidget {
  const ServicesDetailBottom({
    required this.messageController,
    required this.offerController,
    Key? key,
  }) : super(key: key);

  final TextEditingController messageController;
  final TextEditingController offerController;

  @override
  Widget build(BuildContext context) {
    // final allServiceViewModel = context.watch<AllServicesViewModel>();
    final allServiceViewModel =
        Provider.of<AllServicesViewModel>(context, listen: false);
    final bottomProvider = Provider.of<BottomNavigationViewModel>(context);

    return SafeArea(
      child: Container(
        // height: size.height * 0.10,
        padding:
            const EdgeInsets.only(bottom: 24, left: 16, right: 16, top: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.black54,
              width: 0.05,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: DeafultIconButton(
                title: 'Message',
                onPress:
                    bottomProvider.token == null || bottomProvider.token == ''
                        ? () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => const WithoutAuthScreen(),
                                settings: const RouteSettings(
                                  arguments: true,
                                ),
                              ),
                            )
                        : () => sendMessage(context, allServiceViewModel),
                icon: chat,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DeafultIconButton(
                title: 'Make Offer',
                onPress:
                    bottomProvider.token == null || bottomProvider.token == ''
                        ? () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => const WithoutAuthScreen(),
                                settings: const RouteSettings(
                                  arguments: true,
                                ),
                              ),
                            )
                        : () => makeOffer(context, allServiceViewModel),
                icon: dollor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendMessage(
    BuildContext context,
    AllServicesViewModel servicesViewModel,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 50.0),
            child: Wrap(
              spacing: 40.0,
              children: <Widget>[
                Center(
                  child: Container(
                    height: 4,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[500],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    'Enter Your Message',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: messageController,
                  style: const TextStyle(color: Colors.black),
                  // textAlignVertical: TextAlignVertical.center,
                  // textAlign: TextAlign.center,
                  autofocus: true,

                  cursorColor: MyTheme.greenColor,
                  // keyboardType: TextInputType.multiline,

                  showCursor: false,
                  // inputFormatters: [
                  //   FilteringTextInputFormatter.digitsOnly,
                  //   LengthLimitingTextInputFormatter(7),
                  // ],
                  decoration: InputDecoration(
                    hintText: 'Send your message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(
                        color: MyTheme.greenColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Consumer<AllServicesViewModel>(
                      builder: (context, provider, _) {
                        return ElevatedButton(
                          onPressed: provider.offerLoading
                              ? null
                              : () {
                                  Map data = {
                                    'receiver_id': servicesViewModel
                                        .serviceDetalModel!.userId,
                                    'service_id': servicesViewModel
                                        .serviceDetalModel!.serviceId,
                                    'message': messageController.text.trim(),
                                  };
                                  // print(data);
                                  provider.sendMessage(
                                    data: data,
                                    context: context,
                                    controller: messageController,
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            primary: MyTheme.greenColor,
                            padding: const EdgeInsets.all(10.0),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                'Send Message',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(width: 12),
                              Icon(Icons.send, size: 20),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void makeOffer(
    BuildContext context,
    AllServicesViewModel servicesViewModel,
  ) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
      ),
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          // child: const MakeOffer(),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 20.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 4,
                    bottom: 20,
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
                const Text(
                  'Enter Your Offer',
                  style: TextStyle(fontSize: 24),
                ),
                TextField(
                  controller: offerController,
                  style: const TextStyle(color: Colors.black, fontSize: 36),
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
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Consumer<AllServicesViewModel>(
                      builder: (context, provider, _) {
                        // if (provider.offerLoading) {
                        //   return const CustomLoader();
                        // }
                        return ElevatedButton(
                          onPressed: provider.offerLoading
                              ? null
                              : () {
                                  Map data = {
                                    'receiver_id': servicesViewModel
                                        .serviceDetalModel!.userId,
                                    'service_id': servicesViewModel
                                        .serviceDetalModel!.serviceId,
                                    'offer': offerController.text.trim(),
                                  };
                                  // print(data);
                                  // context.read<AllServicesViewModel>().sendOffer(
                                  //       data: data,
                                  //       context: context,
                                  //       controller: offerController,
                                  //     );
                                  provider.sendOffer(
                                    data: data,
                                    context: context,
                                    controller: offerController,
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            primary: MyTheme.greenColor,
                            padding: const EdgeInsets.all(10.0),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                'Send Offer',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(width: 12),
                              Icon(Icons.send, size: 20),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
