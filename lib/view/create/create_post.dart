import 'package:flutter/material.dart';
import '../../components/deafult_button.dart';
import '../../utils/mytheme.dart';
import '../../widgets/common/app_bar.dart';
import '../../widgets/common/input_textfield.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MyTheme.whiteColor,
      resizeToAvoidBottomInset: false,
      appBar: mainAppBar(context: context, appBarTitle: 'Include some details'),
      bottomSheet: SafeArea(
        child: SizedBox(
          height: size.height * 0.10,
          // decoration: const BoxDecoration(
          //   border: Border(
          //     top: BorderSide(
          //       color: Colors.black54,
          //       width: 0.05,
          //     ),
          //   ),
          // ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
            child: DeafultButton(
              title: 'POST',
              onPress: () {
                // Navigator.pushNamed(context, RouteName.createPost);
              },
              // onPress: null,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 5.0,
            right: 5.0,
            top: 15.0,
            bottom: 70.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Container(
                        height: size.height * 0.25,
                        width: size.width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          // boxShadow: kElevationToShadow[1],
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Column(
                              children: [
                                Container(
                                  height: constraints.maxHeight * 0.25,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text('UPLOAD UP TO 20 PHOTOS'),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black,
                                        size: 16,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: constraints.maxHeight * 0.75,
                                  decoration: BoxDecoration(
                                    color: MyTheme.greenColor.withOpacity(0.8),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      topRight: Radius.circular(6),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text('Add Image'),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      // const ProfileImage(),
                      const SizedBox(height: 20),
                      const LabelTextField(label: 'Price *'),
                      const SizedBox(height: 25),
                      const LabelTextField(label: 'Title *'),
                      const SizedBox(height: 25),
                      const LabelTextField(label: 'Description *'),
                      const SizedBox(height: 25),
                      const LocationPicker(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
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

    return Container(
      width: size.width,
      decoration: BoxDecoration(
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
            left: 15,
            bottom: 10,
            top: 10,
            right: 15,
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
                  Text(
                    'Choose',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 18,
              )
            ],
          ),
        ),
      ),
    );
  }
}
