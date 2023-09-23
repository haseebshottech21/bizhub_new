import 'package:bizhub_new/components/custom_loader.dart';
import 'package:bizhub_new/utils/app_url.dart';
import 'package:bizhub_new/view/account/profile/view_other_profile.dart';
import 'package:bizhub_new/view/home/components/google_map_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../language/language_constant.dart';
import '../../../utils/mytheme.dart';
import '../../../view_model/all_services_view_model.dart';
import '../../../view_model/bottom_navigation_view_model.dart';
import '../../../widgets/common/cached_image.dart';

class AllServiceDetailBody extends StatelessWidget {
  const AllServiceDetailBody({
    Key? key,
    // required this.allServiceViewModel,
    required this.bottomNavigationViewModel,
  }) : super(key: key);

  // final AllServicesViewModel allServiceViewModel;
  final BottomNavigationViewModel bottomNavigationViewModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final user = allServiceViewModel.serviceDetalModel!.user!;

    return Consumer<AllServicesViewModel>(
        builder: (context, allServiceViewModel, _) {
      if (allServiceViewModel.loading) {
        return const Center(child: CustomLoader());
      }

      // print('USER ${allServiceViewModel.serviceDetalModel!.user!.firstName}');
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: size.height * 0.35,
                child: allServiceViewModel
                        .serviceDetalModel!.imagesList!.isEmpty
                    ? Container(
                        width: size.width,
                        color: Colors.black,
                        child: Image.asset('assets/images/bizhub_logo.png'),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: allServiceViewModel
                            .serviceDetalModel!.imagesList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final serviceImages = allServiceViewModel
                              .serviceDetalModel!.imagesList![index];
                          return GestureDetector(
                            onTap: () => {},
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  height: size.height,
                                  width: size.width,
                                  fadeInDuration:
                                      const Duration(milliseconds: 300),
                                  placeholder: (context, url) => Container(
                                    width: size.width,
                                    color: Colors.black,
                                    child: Image.asset(
                                      'assets/images/bizhub_logo.png',
                                    ),
                                  ),
                                  imageUrl: AppUrl.baseUrl +
                                      serviceImages.image!.toString(),
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  right: 8,
                                  bottom: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          MyTheme.greenColor.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${index + 1}/${allServiceViewModel.serviceDetalModel!.imagesList!.length}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$ ${allServiceViewModel.serviceDetalModel!.serviceAmount.toString()}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      allServiceViewModel.serviceDetalModel!.serviceTitle
                          .toString(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Divider(),
                    const SizedBox(height: 5),
                    Text(
                      translation(context).postDesctiptionTitle,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      allServiceViewModel.serviceDetalModel!.serviceDesc
                          .toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Divider(),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: bottomNavigationViewModel.token == null ||
                              bottomNavigationViewModel.token == ''
                          ? null
                          : () {
                              if (allServiceViewModel
                                      .serviceDetalModel!.user!.firstName !=
                                  'Guest') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ViewOtherProfile(),
                                    settings: RouteSettings(
                                      arguments: allServiceViewModel
                                          .serviceDetalModel!.user!,
                                    ),
                                  ),
                                );
                              }
                            },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 2,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            allServiceViewModel
                                        .serviceDetalModel!.user!.image ==
                                    null
                                ? CircleAvatar(
                                    radius: 24,
                                    backgroundColor: Colors.grey.shade100,
                                    child: const Icon(
                                      Icons.person,
                                      color: MyTheme.greenColor,
                                      size: 30,
                                    ),
                                  )
                                : CachedImageWidget(
                                    height: 50,
                                    width: 50,
                                    radius: 50,
                                    imgUrl: AppUrl.baseUrl +
                                        allServiceViewModel
                                            .serviceDetalModel!.user!.image
                                            .toString(),
                                  ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${allServiceViewModel.serviceDetalModel!.user!.firstName} ${allServiceViewModel.serviceDetalModel!.user!.lastName}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                if (allServiceViewModel
                                        .serviceDetalModel!.user!.firstName ==
                                    'Guest')
                                  const SizedBox(height: 6),
                                if (allServiceViewModel
                                        .serviceDetalModel!.user!.firstName ==
                                    'Guest')
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.phone,
                                        size: 20,
                                        color: Colors.black45,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        allServiceViewModel
                                            .serviceDetalModel!.user!.phone!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                if (allServiceViewModel
                                        .serviceDetalModel!.user!.firstName ==
                                    'Guest')
                                  const SizedBox(height: 6),
                                if (allServiceViewModel
                                        .serviceDetalModel!.user!.firstName ==
                                    'Guest')
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.email,
                                        size: 20,
                                        color: Colors.black45,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        allServiceViewModel
                                            .serviceDetalModel!.user!.email!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                if (allServiceViewModel.serviceDetalModel!.user!
                                            .firstName !=
                                        'Guest' &&
                                    allServiceViewModel.serviceDetalModel!.user!
                                            .firstName !=
                                        'User')
                                  const SizedBox(height: 2),
                                if (allServiceViewModel.serviceDetalModel!.user!
                                            .firstName !=
                                        'Guest' &&
                                    allServiceViewModel.serviceDetalModel!.user!
                                            .firstName !=
                                        'User')
                                  Text(
                                    translation(context).viewYourProfile,
                                    style: const TextStyle(
                                      color: MyTheme.greenColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                              ],
                            ),
                            const Spacer(),
                            if (allServiceViewModel
                                        .serviceDetalModel!.user!.firstName !=
                                    'Guest' &&
                                allServiceViewModel
                                        .serviceDetalModel!.user!.firstName !=
                                    'User')
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 18,
                              ),
                          ],
                        ),
                      ),
                    ),

                    // GestureDetector(
                    //   onTap: bottomNavigationViewModel.token == null ||
                    //           bottomNavigationViewModel.token == ''
                    //       ? null
                    //       : () {
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //               builder: (context) =>
                    //                   const ViewOtherProfile(),
                    //               settings: RouteSettings(
                    //                 arguments: allServiceViewModel
                    //                     .serviceDetalModel!.user,
                    //               ),
                    //             ),
                    //           );
                    //         },
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //       vertical: 6,
                    //       horizontal: 2,
                    //     ),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       children: [
                    //         allServiceViewModel
                    //                     .serviceDetalModel!.user!.image ==
                    //                 null
                    //             ? CircleAvatar(
                    //                 radius: 24,
                    //                 backgroundColor: Colors.grey.shade100,
                    //                 child: const Icon(
                    //                   Icons.person,
                    //                   color: MyTheme.greenColor,
                    //                   size: 30,
                    //                 ),
                    //               )
                    //             : CachedImageWidget(
                    //                 height: 50,
                    //                 width: 50,
                    //                 radius: 50,
                    //                 imgUrl: AppUrl.baseUrl +
                    //                     allServiceViewModel
                    //                         .serviceDetalModel!.user!.image
                    //                         .toString(),
                    //               ),
                    //         const SizedBox(width: 16),
                    //         Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               '${allServiceViewModel.serviceDetalModel!.user!.firstName} ${allServiceViewModel.serviceDetalModel!.user!.lastName}',
                    //               style: const TextStyle(fontSize: 16),
                    //             ),
                    //             const SizedBox(height: 2),
                    //             Text(
                    //               translation(context).viewYourProfile,
                    //               style: const TextStyle(
                    //                 color: MyTheme.greenColor,
                    //                 fontWeight: FontWeight.w500,
                    //                 fontSize: 15,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         const Spacer(),
                    //         const Icon(
                    //           Icons.arrow_forward_ios,
                    //           color: Colors.black,
                    //           size: 18,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 5),
                    const Divider(),
                    const SizedBox(height: 5),
                    Text(
                      translation(context).postLocationTitle,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GoogleMapScreen(allServiceViewModel: allServiceViewModel),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
