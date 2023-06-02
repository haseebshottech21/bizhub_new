import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../language/language_constant.dart';
import '../../../utils/app_url.dart';
import '../../../utils/mytheme.dart';
import '../../../view_model/my_service_view_model.dart';
import 'edit_my_post.dart';
import 'my_google_map.dart';

class MyPostDetail extends StatefulWidget {
  const MyPostDetail({
    Key? key,
    required this.myServiceViewModel,
  }) : super(key: key);

  final MyServiceViewModel myServiceViewModel;

  @override
  State<MyPostDetail> createState() => _MyPostDetailState();
}

class _MyPostDetailState extends State<MyPostDetail> {
  GoogleMapController? mapController;

  bool? loading;
  double? lat;
  double? lng;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Circle>? circles;

  @override
  initState() {
    loading = true;
    lat = double.parse(
      widget.myServiceViewModel.serviceModel!.latitude.toString(),
    );
    lng = double.parse(
      widget.myServiceViewModel.serviceModel!.longitude.toString(),
    );

    circles = {
      Circle(
        circleId: const CircleId("myCircle"),
        radius: 2000,
        center: LatLng(lat!, lng!),
        fillColor: const Color.fromRGBO(52, 186, 37, .6),
        strokeColor: Colors.white,
        strokeWidth: 1,
        // onTap: () {
        //   print('circle pressed');
        // },
      )
    };
    loading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: size.height * 0.35,
                child: widget
                        .myServiceViewModel.serviceModel!.imagesList!.isEmpty
                    ? Container(
                        color: Colors.black,
                        child: Image.asset('assets/images/bizhub_logo.png'),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.myServiceViewModel.serviceModel!
                            .imagesList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final serviceImages = widget.myServiceViewModel
                              .serviceModel!.imagesList![index];
                          return Stack(
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
                                      AppUrl.baseUrl +
                                          serviceImages.image.toString(),
                                    ),
                                    fit: BoxFit.fitHeight,
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
                                    color: MyTheme.greenColor.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${index + 1}/${widget.myServiceViewModel.serviceModel!.imagesList!.length}',
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
                      '\$ ${widget.myServiceViewModel.serviceModel!.serviceAmount.toString()}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.myServiceViewModel.serviceModel!.serviceTitle
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
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.myServiceViewModel.serviceModel!.serviceDesc
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
                    Text(
                      translation(context).postLocationTitle,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // MyGoogleMap(myServiceViewModel: widget.myServiceViewModel),
                    loading == false
                        ? SizedBox(
                            height: size.height * 0.22,
                            child: MyGoogleLocation(
                              circles: circles,
                              onMapCreated: _onMapCreated,
                              lat: lat!,
                              lng: lng!,
                            ),
                          )
                        : const Center(child: CircularProgressIndicator()),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: 0,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.09,
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            CupertinoIcons.back,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        widget.myServiceViewModel.serviceModel!.serviceStatus ==
                                '0'
                            ? InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const EditMyPost(),
                                      settings: RouteSettings(
                                        arguments: widget
                                            .myServiceViewModel.serviceModel,
                                      ),
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 26,
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
