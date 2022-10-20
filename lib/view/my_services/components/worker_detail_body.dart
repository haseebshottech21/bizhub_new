import 'package:flutter/material.dart';
import '../../../utils/app_url.dart';
// import '../../../utils/dummy_data.dart';
import '../../../view_model/my_service_view_model.dart';
import 'my_google_map.dart';

class MyWorkerDetailBody extends StatelessWidget {
  const MyWorkerDetailBody({
    Key? key,
    required this.myServiceViewModel,
  }) : super(key: key);

  final MyServiceViewModel myServiceViewModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: size.height * 0.28,
                child: myServiceViewModel.serviceModel!.imagesList!.isEmpty
                    ? Container(
                        color: Colors.black,
                        child: Image.asset('assets/images/bizhub_logo.png'),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            myServiceViewModel.serviceModel!.imagesList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          // final games = game[index];
                          final serviceImages = myServiceViewModel
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
                                      '${index + 1}/${myServiceViewModel.serviceModel!.imagesList!.length}',
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
                          );
                        },
                      ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$ ${myServiceViewModel.serviceModel!.serviceAmount}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      myServiceViewModel.serviceModel!.serviceTitle.toString(),
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
                      myServiceViewModel.serviceModel!.serviceDesc.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Location',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    MyGoogleMap(myServiceViewModel: myServiceViewModel),
                  ],
                ),
              )
            ],
          ),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  // decoration: const BoxDecoration(
                  // color: Colors.white,
                  // shape: BoxShape.circle,
                  // ),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child:
                        const Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                ),
                Container(
                  width: 40,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: InkWell(
                    onTap: () {
                      // Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.edit, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
