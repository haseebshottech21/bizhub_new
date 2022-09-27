import 'dart:io';
import 'package:bizhub_new/view/account/component/select_photo.dart';
import 'package:bizhub_new/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../utils/mytheme.dart';
import '../../../utils/utils.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, authViewModel, _) {
        return GestureDetector(
          onTap: () => _showSelectPhoto(context),
          child: SizedBox(
            height: 150,
            width: 150,
            child: Stack(
              children: [
                authViewModel.imageDetail['imagePath'].toString().isEmpty
                    ? Center(
                        child: Container(
                          width: 125,
                          height: 125,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 115,
                            color: Colors.black38,
                          ),
                        ),
                      )
                    : Center(
                        child: Container(
                          width: 125,
                          height: 125,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                File(
                                  authViewModel.imageDetail['imagePath']
                                      .toString(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                Positioned(
                  right: 5,
                  bottom: 5,
                  child: Container(
                    // width: 32,
                    // height: 32,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: MyTheme.greenColor,
                      borderRadius: BorderRadius.circular(6),
                      // border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        color: MyTheme.whiteColor,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSelectPhoto(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.22,
        maxChildSize: 0.26,
        minChildSize: 0.22,
        expand: false,
        builder: (context, scrollController) {
          return Consumer<AuthViewModel>(
            builder: (context, authViewModel, _) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Stack(
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: 10,
                      child: Container(
                        width: 50,
                        height: 4,
                        // margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.5),
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    // const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Column(
                        children: [
                          SelectPhoto(
                            textLabel: 'Select from Gallery',
                            icon: Icons.image,
                            onTap: () async {
                              var image = await Utils().getImageFromSource(
                                context,
                                ImageSource.gallery,
                              );
                              if (image == null) return;
                              authViewModel.setImage(
                                context: context,
                                file: image,
                              );
                            },
                          ),
                          // const SizedBox(height: 5),
                          SelectPhoto(
                            onTap: () async {
                              var image = await Utils().getImageFromSource(
                                context,
                                ImageSource.camera,
                              );
                              if (image == null) return;
                              authViewModel.setImage(
                                context: context,
                                file: image,
                              );
                            },
                            textLabel: 'Select from Camera',
                            icon: Icons.camera_alt_outlined,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
