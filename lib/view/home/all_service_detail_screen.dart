import 'package:bizhub_new/view/home/components/all_service_detail_body.dart';
import 'package:bizhub_new/view/home/components/services_detail_bottom.dart';
import 'package:bizhub_new/view_model/all_services_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostJobDetail extends StatefulWidget {
  const PostJobDetail({Key? key, required this.serviceId}) : super(key: key);

  final String serviceId;

  @override
  State<PostJobDetail> createState() => _PostJobDetailState();
}

class _PostJobDetailState extends State<PostJobDetail> {
  final offerController = TextEditingController();
  final messageController = TextEditingController();

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

    // final size = MediaQuery.of(context).size;

    // final allServiceViewModel = context.watch<AllServicesViewModel>();
    // final serviceViewModel =
    //     Provider.of<AllServicesViewModel>(context, listen: true);
    return Scaffold(
      bottomSheet: ServicesDetailBottom(
        messageController: messageController,
        offerController: offerController,
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

  @override
  void dispose() {
    offerController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
