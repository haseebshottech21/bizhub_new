import 'package:bizhub_new/components/custom_loader.dart';
// import 'package:bizhub_new/components/empty_icon.dart';
import 'package:bizhub_new/view/posts/components/post_offers.dart';
import 'package:bizhub_new/view/posts/components/rate_bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../../../components/deafult_button.dart';
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
  // TextEditingController reviewController = TextEditingController();
  // final _formKey = GlobalKey<FormState>();

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

    // const nameStyle = TextStyle(
    //   fontSize: 16,
    //   fontWeight: FontWeight.w400,
    //   color: Colors.black87,
    // );

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
                  // _offerList(serviceViewModel, complete, nameStyle),
                  MyPostOffers(
                    serviceViewModel: serviceViewModel,
                    complete: complete,
                  ),
                  // const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 5),
                  // _rateBottomSheet(
                  //     context, complete, serviceViewModel, nameStyle),
                  RateBottomSheet(
                    complete: complete,
                    serviceViewModel: serviceViewModel,
                  ),
                ],
              ),
            ),
    );
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
}
