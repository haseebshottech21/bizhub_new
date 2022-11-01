import 'dart:io';
import 'package:bizhub_new/widgets/common/app_bar.dart';
import 'package:bizhub_new/widgets/common/empty_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../components/deafult_button.dart';
import '../../main.dart';
import '../../utils/field_validator.dart';
import '../../utils/mytheme.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';
import '../../view_model/auth_view_model.dart';
import '../../widgets/common/auth_botom.dart';
import '../../widgets/common/input_textfield.dart';
import '../account/component/select_photo.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailAddressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final textFieldValidator = TextFieldValidators();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final auth = Provider.of<AuthViewModel>(context, listen: false);
    auth.initialSignupValues();
    super.initState();
  }

  validateAndSignup() {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      Map data = {
        if (authViewModel.imageDetail['imagePath'].toString().isNotEmpty)
          "image": authViewModel.imageDetail['image'].toString(),
        if (authViewModel.imageDetail['imagePath'].toString().isNotEmpty)
          "extension": authViewModel.imageDetail['extension'].toString(),
        "first_name": firstNameController.text.trim(),
        "last_name": lastNameController.text.trim(),
        "email": emailAddressController.text.trim(),
        "phone": phoneNumberController.text.trim(),
        "password": passwordController.text.trim(),
        "password_confirmation": confirmPasswordController.text.trim(),
        "device_id": MyApp.notifyToken,
      };
      // print(data);
      authViewModel.signUp(data, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(systemNavigationBarColor: Colors.white),
    );

    return Scaffold(
      backgroundColor: MyTheme.whiteColor,
      resizeToAvoidBottomInset: false,
      appBar: mainAppBar(context: context, appBarTitle: 'Create Account'),
      bottomSheet: AuthBottom(
        title: 'Already have an account?',
        text: 'Sign In!',
        onTap: () {
          Navigator.of(context).pushNamed(RouteName.login);
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            top: 10.0,
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
                      Consumer<AuthViewModel>(
                        builder: (context, auth, _) {
                          // print(auth.imageDetail['imagePath'].toString());
                          return GestureDetector(
                            onTap: () => _showSelectPhoto(context),
                            // onTap: () {},
                            child: SizedBox(
                              height: 150,
                              width: 150,
                              child: Stack(
                                children: [
                                  auth.imageDetail['imagePath']
                                          .toString()
                                          .isEmpty
                                      ? const EmptyProfile()
                                      : UploadedProfile(
                                          fileImage: FileImage(
                                            File(auth.imageDetail['imagePath']
                                                .toString()),
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
                      ),
                      const SizedBox(height: 15),
                      InputTextFormField(
                        controller: firstNameController,
                        hintText: 'First Name',
                        icon: Icons.person,
                        validator: textFieldValidator.firstNameErrorGetter,
                      ),
                      const SizedBox(height: 8),
                      InputTextFormField(
                        controller: lastNameController,
                        hintText: 'Last Name',
                        icon: Icons.person,
                        validator: textFieldValidator.lastNameErrorGetter,
                      ),
                      const SizedBox(height: 8),
                      InputTextFormField(
                        controller: emailAddressController,
                        hintText: 'Email Address',
                        icon: Icons.email,
                        validator: textFieldValidator.emailErrorGetter,
                      ),
                      const SizedBox(height: 8),
                      InputTextFormField(
                        controller: phoneNumberController,
                        hintText: 'Phone',
                        icon: Icons.phone,
                        validator: textFieldValidator.phoneNumberErrorGetter,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Consumer<AuthViewModel>(
                        builder: (context, authViewModel, _) {
                          return Column(
                            children: [
                              InputPasswordTextFormField(
                                controller: passwordController,
                                hintText: 'Password',
                                fontAwsomeIcon: Icons.password,
                                validator:
                                    textFieldValidator.passwordErrorGetter,
                                obscureText: authViewModel.passwordHide,
                                onPress: authViewModel.togglePassword,
                              ),
                              const SizedBox(height: 8),
                              InputPasswordTextFormField(
                                controller: confirmPasswordController,
                                hintText: 'Confirm Password',
                                fontAwsomeIcon: Icons.password,
                                validator: textFieldValidator
                                    .confirmPasswordErrorGetter,
                                password: passwordController,
                                obscureText: authViewModel.confirmPasswordHide,
                                onPress: authViewModel.toggleConfirmPassword,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Consumer<AuthViewModel>(
                    builder: (context, authViewModel, _) {
                      return Checkbox(
                        checkColor: Colors.white,
                        activeColor: MyTheme.greenColor,
                        value: authViewModel.isRemember,
                        onChanged: (bool? value) {
                          authViewModel.checkRemeber();
                        },
                      );
                    },
                  ),
                  const Text(
                    'Accept Term & Condition and Privacy Policy',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.0,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Consumer<AuthViewModel>(
                builder: (context, authViewModel, _) {
                  return DeafultButton(
                    title: 'Sign Up',
                    isloading: authViewModel.loading,
                    onPress: validateAndSignup,
                    // onPress: () {
                    //   validateAndSignup();
                    //   // print(authViewModel.loading);
                    //   // authViewModel.signUp(context);
                    // },
                  );
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailAddressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
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
