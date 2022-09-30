import 'package:bizhub_new/components/deafult_button.dart';
import 'package:bizhub_new/utils/icons.dart';
import 'package:bizhub_new/view/home/components/all_service_detail_body.dart';
import 'package:bizhub_new/view_model/all_services_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter/services.dart';
import 'components/make_offer.dart';
import 'components/send_message.dart';

class PostJobDetail extends StatefulWidget {
  const PostJobDetail({Key? key, required this.serviceId}) : super(key: key);

  final String serviceId;

  @override
  State<PostJobDetail> createState() => _PostJobDetailState();
}

class _PostJobDetailState extends State<PostJobDetail> {
  getAllServiceDetail() async {
    final provider = Provider.of<AllServicesViewModel>(context, listen: false);
    await provider.getAllServiceDetail(
      context: context,
      serviceId: widget.serviceId,
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
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    // );

    final size = MediaQuery.of(context).size;

    void makeOffer(BuildContext context) {
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
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: const MakeOffer(),
          ),
        ),
      );
    }

    void sendMessage(BuildContext context) {
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
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: const SendMessage(),
          ),
        ),
      );
    }

    return Scaffold(
      bottomSheet: SafeArea(
        child: Container(
          // height: size.height * 0.10,
          padding:
              const EdgeInsets.only(bottom: 25, left: 16, right: 16, top: 10),
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
                  onPress: () => sendMessage(context),
                  icon: chat,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: DeafultIconButton(
                  title: 'Make an offer',
                  onPress: () => makeOffer(context),
                  icon: dollor,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          // AllServiceDetailBody(allServiceViewModel: allServiceViewModel),
          Consumer<AllServicesViewModel>(
            builder: (context, allServiceViewModel, _) {
              if (allServiceViewModel.loading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Stack(
                  children: [
                    AllServiceDetailBody(
                      allServiceViewModel: allServiceViewModel,
                    ),
                    if (allServiceViewModel.offerLoading)
                      const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 1,
                        ),
                      ),
                  ],
                );
              }
            },
          ),
          Positioned(
            top: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.10,
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
              child: Container(
                width: 40,
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                // decoration: const BoxDecoration(
                //   color: Colors.white,
                //   shape: BoxShape.circle,
                // ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
