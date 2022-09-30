import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/deafult_button.dart';
import '../../../utils/mytheme.dart';
import '../../../view_model/location_view_model.dart';
import '../../../view_model/my_service_view_model.dart';
import '../../../widgets/common/input_textfield.dart';

class EditMyPosterService extends StatefulWidget {
  const EditMyPosterService({Key? key}) : super(key: key);

  @override
  State<EditMyPosterService> createState() => _EditMyPosterServiceState();
}

class _EditMyPosterServiceState extends State<EditMyPosterService> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Service',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.clear, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
            // context.read<ProjectViewModel>().fieldsClear(context);
          },
        ),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 5.0,
            right: 5.0,
            top: 15.0,
            bottom: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const UploadImages(),
                      const SizedBox(height: 20),
                      LabelTextField(
                        label: 'Title *',
                        controller: titleController,
                      ),
                      const SizedBox(height: 20),
                      LabelTextField(
                        label: 'Description *',
                        controller: descController,
                        textAreaField: true,
                      ),
                      const SizedBox(height: 20),
                      const LocationPicker(),
                      const SizedBox(height: 20),
                      LabelTextField(
                        label: 'Price *',
                        controller: priceController,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: DeafultButton(
                  title: 'UPDATE',
                  onPress: () {
                    // print(post.isPoster);
                    // validateAndJobPost();
                  },
                  // onPress: null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
                    Text('UPLOAD UP TO 5 PHOTOS'),
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

class LocationPicker extends StatelessWidget {
  const LocationPicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<LocationViewModel>(
      builder: (context, locationViewModel, _) {
        return Container(
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Colors.black,
              width: 0.8,
            ),
          ),
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(
                left: 12,
                bottom: 10,
                top: 10,
                right: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Location',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: size.width * 0.80,
                        child: Text(
                          locationViewModel
                                  .placeDetailModel.placeAddress.isEmpty
                              ? 'Choose'
                              : locationViewModel.placeDetailModel.placeAddress,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 16,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
