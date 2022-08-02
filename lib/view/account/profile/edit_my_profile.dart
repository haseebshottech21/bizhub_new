import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../components/deafult_button.dart';
import '../../../widgets/common/app_bar.dart';
import '../../../widgets/common/input_textfield.dart';

class EditMyProfile extends StatefulWidget {
  const EditMyProfile({Key? key}) : super(key: key);

  @override
  State<EditMyProfile> createState() => _EditMyProfileState();
}

class _EditMyProfileState extends State<EditMyProfile> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    // );

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: mainAppBar(context: context, appBarTitle: 'Edit Profile'),
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
              title: 'SAVE',
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
                      // const ProfileImage(),
                      const SizedBox(height: 20),
                      const LabelTextField(label: 'First Name'),
                      const SizedBox(height: 15),
                      const LabelTextField(label: 'Last Name'),
                      const SizedBox(height: 15),
                      const LabelTextField(label: 'Email Address'),
                      const SizedBox(height: 15),
                      const LabelTextField(label: 'Phone'),
                      const SizedBox(height: 15),
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
