import 'package:bizhub_new/utils/app_url.dart';
import 'package:flutter/material.dart';
import '../../../utils/mytheme.dart';
import '../../../view_model/all_services_view_model.dart';
import '../../../widgets/common/cached_image.dart';

class AllServiceDetailBody extends StatelessWidget {
  const AllServiceDetailBody({
    Key? key,
    required this.allServiceViewModel,
  }) : super(key: key);

  final AllServicesViewModel allServiceViewModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: size.height * 0.28,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: allServiceViewModel.serviceModel!.imagesList!.length,
              itemBuilder: (BuildContext context, int index) {
                final serviceImages =
                    allServiceViewModel.serviceModel!.imagesList![index];
                return GestureDetector(
                  onTap: () => {},
                  child: Stack(
                    children: [
                      Container(
                        // margin: const EdgeInsets.only(right: 2.0),
                        height: size.height,
                        width: size.width,
                        decoration: BoxDecoration(
                          // color: Colors.amber,
                          // borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(
                              AppUrl.baseUrl + serviceImages.image.toString(),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
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
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}/${allServiceViewModel.serviceModel!.imagesList!.length}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$ ${allServiceViewModel.serviceModel!.serviceAmount.toString()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  allServiceViewModel.serviceModel!.serviceTitle.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Icon(Icons.location_pin),
                        SizedBox(width: 5),
                        Text('United State'),
                      ],
                    ),
                    const Text('30 JUL 2022')
                  ],
                ),
                const SizedBox(height: 5),
                const Divider(),
                const SizedBox(height: 5),
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  allServiceViewModel.serviceModel!.serviceDesc.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 5),
                const Divider(),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CachedImageWidget(
                          height: 55,
                          width: 55,
                          radius: 50,
                          imgUrl:
                              'https://i.pinimg.com/736x/25/78/61/25786134576ce0344893b33a051160b1.jpg',
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'USER NAME',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'VIEW PROFILE',
                              style: TextStyle(
                                color: MyTheme.greenColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
