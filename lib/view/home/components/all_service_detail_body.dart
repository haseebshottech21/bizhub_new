import 'package:bizhub_new/utils/app_url.dart';
import 'package:bizhub_new/view/account/profile/view_other_profile.dart';
import 'package:bizhub_new/view/home/components/google_map_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../language/language_constant.dart';
import '../../../utils/mytheme.dart';
import '../../../view_model/all_services_view_model.dart';
import '../../../view_model/bottom_navigation_view_model.dart';
import '../../../widgets/common/cached_image.dart';

class AllServiceDetailBody extends StatelessWidget {
  const AllServiceDetailBody({
    Key? key,
    required this.allServiceViewModel,
    required this.bottomNavigationViewModel,
  }) : super(key: key);

  final AllServicesViewModel allServiceViewModel;
  final BottomNavigationViewModel bottomNavigationViewModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = allServiceViewModel.serviceDetalModel!.user!;

    // print(allServiceViewModel.serviceDetalModel!.imagesList!);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: size.height * 0.35,
              child: allServiceViewModel.serviceDetalModel!.imagesList!.isEmpty
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
                                    color: MyTheme.greenColor.withOpacity(0.8),
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ViewOtherProfile(),
                                settings: RouteSettings(
                                  arguments: user,
                                ),
                              ),
                            );
                          },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          user.image == null
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
                                  imgUrl:
                                      AppUrl.baseUrl + user.image.toString(),
                                ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${user.firstName} ${user.lastName}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 2),
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
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
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
  }
}
