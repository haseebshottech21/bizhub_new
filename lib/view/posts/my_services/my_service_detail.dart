import 'package:bizhub_new/components/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_model/my_service_view_model.dart';
import '../components/my_post_detail.dart';

class MyWorkDetail extends StatefulWidget {
  const MyWorkDetail({Key? key, required this.serviceId}) : super(key: key);

  final String serviceId;

  @override
  State<MyWorkDetail> createState() => _MyWorkDetailState();
}

class _MyWorkDetailState extends State<MyWorkDetail> {
  getMyPosterServiceDetail() async {
    final provider = Provider.of<MyServiceViewModel>(context, listen: false);
    await provider.getMyPostDetail(
      context: context,
      serviceId: widget.serviceId,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => getMyPosterServiceDetail(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final myServiceViewModel =
    //     Provider.of<MyServiceViewModel>(context, listen: true);
    return Scaffold(
      body: Stack(
        children: [
          Consumer<MyServiceViewModel>(
            builder: (context, myServiceViewModel, _) {
              if (myServiceViewModel.loading) {
                return const CustomLoader();
              } else {
                return MyPostDetail(myServiceViewModel: myServiceViewModel);
              }
            },
          ),
          // Positioned(
          //   top: 0,
          //   child: Container(
          //     height: MediaQuery.of(context).size.height * 0.10,
          //     width: MediaQuery.of(context).size.width,
          //     alignment: Alignment.bottomLeft,
          //     decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //         colors: [
          //           Colors.transparent.withOpacity(0.2),
          //           Colors.transparent.withOpacity(0.1),
          //           Colors.transparent,
          //         ],
          //         stops: const [
          //           0.1,
          //           0.5,
          //           0.9,
          //         ],
          //         begin: Alignment.topCenter,
          //         end: Alignment.bottomCenter,
          //       ),
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Container(
          //           width: 40,
          //           height: 50,
          //           margin: const EdgeInsets.symmetric(horizontal: 12),
          //           // decoration: const BoxDecoration(
          //           // color: Colors.white,
          //           // shape: BoxShape.circle,
          //           // ),
          //           child: InkWell(
          //             onTap: () {
          //               Navigator.of(context).pop();
          //             },
          //             child:
          //                 const Icon(Icons.arrow_back_ios, color: Colors.white),
          //           ),
          //         ),
          //         Container(
          //           width: 40,
          //           height: 50,
          //           margin: const EdgeInsets.symmetric(horizontal: 12),
          //           child: InkWell(
          //             onTap: () {
          //               Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                   builder: (context) => const EditMyPost(),
          //                   settings: RouteSettings(
          //                     arguments: myServiceViewModel.serviceModel,
          //                   ),
          //                 ),
          //               );
          //             },
          //             child: const Icon(Icons.edit, color: Colors.white),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
