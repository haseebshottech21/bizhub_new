import 'dart:convert';
import 'package:bizhub_new/utils/utils.dart';
import 'package:bizhub_new/view/create/component/upload_images.dart';
import 'package:bizhub_new/view_model/category_view_model.dart';
import 'package:bizhub_new/view_model/my_service_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/deafult_button.dart';
import '../../utils/mytheme.dart';
import '../../view_model/location_view_model.dart';
import '../../widgets/common/app_bar.dart';
import '../../widgets/common/input_textfield.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool post = false;

  @override
  void initState() {
    // Provider.of<LocationViewModel>(context, listen: false)
    //     .getCurrentLocation(context);
    Provider.of<LocationViewModel>(context, listen: false)
        .getStoreLocationIfExist(context);
    super.initState();
  }

  validateAndJobPost() {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      final post = Provider.of<MyServiceViewModel>(context, listen: false);
      final category = Provider.of<CategoryViewModel>(context, listen: false);
      final location = Provider.of<LocationViewModel>(context, listen: false);

      if (location.placeDetailModel.placeAddress.isEmpty) {
        Utils.toastMessage('Please choose location');
        return;
      }

      post.serviceBody['type'] = post.isPoster! ? '0' : '1';
      post.serviceBody['category_id'] = category.categoryId;
      post.serviceBody['images'] = jsonEncode(post.serviceImgaes);
      post.serviceBody['title'] = titleController.text.trim();
      post.serviceBody['description'] = descController.text.trim();
      post.serviceBody['amount'] = priceController.text.trim();
      post.serviceBody['longitude'] =
          location.placeDetailModel.placeLocation.longitude.toString();
      post.serviceBody['latitude'] =
          location.placeDetailModel.placeLocation.latitude.toString();
      post.serviceBody['address'] =
          location.placeDetailModel.placeAddress.trim();
      post.serviceBody['is_negotiable'] = '0';

      // provider.serviceBody['amount'] = jobBugetController.text.trim();
      // provider.serviceBody['people_required'] =
      //     noOfPeopleController.text.trim();
      // provider.serviceBody['category_id'] = provider.serviceCategoryId;
      // provider.serviceBody['is_negotiable'] =
      //     provider.isPriceNegotiable ? '1' : '0';
      // provider.serviceBody['type'] = provider.isPoster! ? '0' : '1';

      post.createPost(post.serviceBody, context);
      print(post.serviceBody);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: MyTheme.whiteColor,
      appBar: myAppBar(context: context, appBarTitle: 'Create Your Post'),
      bottomSheet: post == true
          ? SafeArea(
              child: SizedBox(
                height: size.height * 0.10,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
                  child: DeafultButton(
                    title: 'POST',
                    onPress: () {
                      // print(post.isPoster);
                    },
                    // onPress: null,
                  ),
                ),
              ),
            )
          : const SizedBox(),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 0),
                child: DeafultButton(
                  title: 'POST',
                  onPress: () {
                    // print(post.isPoster);
                    validateAndJobPost();
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
