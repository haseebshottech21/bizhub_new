import 'dart:convert';
import 'package:bizhub_new/utils/utils.dart';
import 'package:bizhub_new/view/create/component/upload_images.dart';
import 'package:bizhub_new/view_model/category_view_model.dart';
import 'package:bizhub_new/view_model/my_service_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../components/deafult_button.dart';
import '../../language/language_constant.dart';
import '../../utils/field_validator.dart';
import '../../utils/mytheme.dart';
import '../../utils/routes/routes_name.dart';
import '../../view_model/bottom_navigation_view_model.dart';
import '../../view_model/location_view_model.dart';
import '../../widgets/common/dialog_box.dart';
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
  final textFieldValidator = TextFieldValidators();
  final _formKey = GlobalKey<FormState>();
  bool post = false;

  @override
  void initState() {
    // Provider.of<LocationViewModel>(context, listen: false)
    //     .getStoreLocationIfExist(context);
    Provider.of<LocationViewModel>(context, listen: false).getLatLong(context);
    super.initState();
  }

  validateAndJobPost() {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      final post = Provider.of<MyServiceViewModel>(context, listen: false);
      final category = Provider.of<CategoryViewModel>(context, listen: false);
      final location = Provider.of<LocationViewModel>(context, listen: false);
      // if (post.serviceImgaes.isEmpty) {
      //   Utils.toastMessage('Please add pictures');
      // }
      if (location.locationAddress.isEmpty) {
        Utils.toastMessage('Please choose location');
        return;
      }
      // if (post.serviceImgaes.isNotEmpty) {

      post.serviceBody['type'] = post.isPoster! ? '0' : '1';
      post.serviceBody['category_id'] = category.categoryId;
      // post.serviceBody['images'] = json.encode(post.serviceImgaes);
      post.serviceBody['title'] = titleController.text.trim();
      post.serviceBody['description'] = descController.text.trim();
      post.serviceBody['amount'] = priceController.text.trim();
      post.serviceBody['longitude'] = location.latLng.longitude.toString();
      post.serviceBody['latitude'] = location.latLng.latitude.toString();
      post.serviceBody['address'] = location.locationAddress.trim();
      post.serviceBody['is_negotiable'] = post.isPriceNegotiable ? '1' : '0';
      if (post.serviceBody['images'] != null) {
        post.serviceBody['images'] = json.encode(post.serviceImgaes);
      }
      post.createPost(post.serviceBody, context);
      // print(post.serviceBody['images']);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: MyTheme.whiteColor,
      // appBar: myAppBar(context: context, appBarTitle: 'Create Your Post'),
      appBar: AppBar(
        backgroundColor: MyTheme.whiteColor,
        automaticallyImplyLeading: false,
        elevation: 3,
        leading: IconButton(
          onPressed: () {
            Provider.of<BottomNavigationViewModel>(context, listen: false)
                .toggleCurrentIndex(0);
            final service =
                Provider.of<MyServiceViewModel>(context, listen: false);
            showDialog(
              context: context,
              builder: (_) => cancelDialog(
                context: context,
                title: 'Leave',
                subTitle: 'Are you sure you want to leave ?',
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteName.home,
                    (route) => false,
                  );
                  service.initailValue(context);
                  service.serviceImgaes.clear();
                },
              ),
            );
          },
          icon: const Icon(
            Icons.clear,
            color: Colors.black,
            size: 24,
          ),
        ),
        centerTitle: true,
        title: Text(
          translation(context).createPostTitle,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
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
                      const UploadImages(),
                      const SizedBox(height: 20),
                      LabelTextField(
                        label: 'Title *',
                        controller: titleController,
                        validator: textFieldValidator.titleErrorGetter,
                      ),
                      const SizedBox(height: 20),
                      LabelTextField(
                        label: 'Description *',
                        controller: descController,
                        textAreaField: true,
                        validator: textFieldValidator.descriptionErrorGetter,
                      ),
                      const SizedBox(height: 20),
                      const LocationPicker(),
                      const SizedBox(height: 20),
                      LabelTextField(
                        label: 'Price *',
                        controller: priceController,
                        validator: textFieldValidator.budgetRangeErrorGetter,
                        textInputType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(6),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Consumer<MyServiceViewModel>(
                builder: (ctx, serviceViewModel, _) {
                  return CheckboxListTile(
                    value: serviceViewModel.isPriceNegotiable,
                    onChanged: (val) {
                      serviceViewModel.togglePriceNegotiable();
                    },
                    title: const Text(
                      'Price Negotiable',
                      style: TextStyle(color: Colors.black),
                    ),
                    activeColor: MyTheme.greenColor,
                  );
                },
              ),
              const SizedBox(height: 20),
              Consumer<MyServiceViewModel>(
                builder: (context, serviceViewModel, _) {
                  // return DeafultButton(
                  //   title: 'POST',
                  //   isloading: serviceViewModel.loading,
                  //   onPress: () {
                  //     validateAndJobPost();
                  //   },
                  // );
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SizedBox(
                      height: size.height * 0.09,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 6,
                        ),
                        child: DeafultButton(
                          isloading: serviceViewModel.postLoading,
                          title: translation(context).postTxt,
                          onPress: () {
                            validateAndJobPost();
                          },
                        ),
                      ),
                    ),
                  );
                },
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
    final locationViewModel =
        Provider.of<LocationViewModel>(context, listen: true);

    // return Consumer<LocationViewModel>(
    //   builder: (context, locationViewModel, _) {
    //     // print(locationViewModel.address);
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
        onTap: () {
          Navigator.of(context).pushNamed(RouteName.searchLocation);
        },
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
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: size.width * 0.80,
                    child: Text(
                      locationViewModel.locationAddress.isEmpty
                          ? 'Choose'
                          : locationViewModel.locationAddress,
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
    //   },
    // );
  }
}
