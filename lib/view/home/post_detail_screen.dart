import 'package:bizhub_new/components/deafult_button.dart';
import 'package:bizhub_new/utils/dummy_data.dart';
import 'package:bizhub_new/utils/icons.dart';
import 'package:bizhub_new/widgets/common/cached_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import '../../utils/mytheme.dart';
import 'components/make_offer.dart';

class PostJobDetail extends StatefulWidget {
  const PostJobDetail({Key? key}) : super(key: key);

  @override
  State<PostJobDetail> createState() => _PostJobDetailState();
}

class _PostJobDetailState extends State<PostJobDetail> {
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
                  onPress: () {},
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
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.28,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: sliderImages.length,
                    itemBuilder: (BuildContext context, int index) {
                      // final games = game[index];
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
                                  image: NetworkImage(sliderImages[index]),
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
                                    '${index + 1}/${sliderImages.length}',
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '\$ 500',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'I will create your bussiness website with new features 2022...',
                        style: TextStyle(
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
                      const Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                        style: TextStyle(
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
                                    style: TextStyle(
                                      // color: Theme.of(context)
                                      //     .textTheme
                                      //     .headline1!
                                      //     .color,
                                      // color: Color(0xFF50182c),
                                      fontSize: 14,
                                    ),
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
