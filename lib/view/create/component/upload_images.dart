import 'dart:io';
import 'package:bizhub_new/view_model/my_service_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/mytheme.dart';

class UploadImages extends StatelessWidget {
  const UploadImages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<MyServiceViewModel>(
      builder: (context, postViewModel, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                postViewModel.selectMulipleImages();
              },
              child: Container(
                width: size.width,
                height: size.height * 0.06,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: Colors.black,
                      width: 0.5,
                    )
                    // boxShadow: kElevationToShadow[1],
                    ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'UPLOAD MULTIPLE PHOTOS',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  Icon(
                    Icons.attach_file,
                    size: 18,
                    color: Colors.grey[500],
                  ),
                  const SizedBox(width: 5),
                  Text(
                    postViewModel.serviceImgaes.isEmpty
                        ? 'No Picture Attached'
                        : '${postViewModel.serviceImgaes.length} Picture Attached',
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
            postViewModel.serviceImgaes.isEmpty
                ? const Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Icon(
                      Icons.photo_library,
                      size: 70,
                      color: MyTheme.greenColor,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Stack(
                      children: [
                        Container(
                          height: size.height * 0.20,
                          width: size.width * 0.45,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            border: Border.all(
                              color: MyTheme.greenColor,
                            ),
                            borderRadius: BorderRadius.circular(3),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: FileImage(
                                File(
                                  postViewModel.serviceImgaes[0]['imagePath'],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          top: 5,
                          right: 5,
                          child: Icon(
                            Icons.photo_library,
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              postViewModel.clearImages();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                ),
                                color: MyTheme.greenColor.withOpacity(0.8),
                              ),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        );
      },
    );
  }
}
