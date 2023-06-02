import 'dart:io';
import 'package:bizhub_new/view/home/home_screen.dart';
import 'package:bizhub_new/widgets/common/app_bar.dart';
import 'package:bizhub_new/widgets/common/empty_profile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/deafult_button.dart';
// import '../../main.dart';
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
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    if (!_formKey.currentState!.validate()) {
      return;
    } else if (!authViewModel.isCheckTCAndPP) {
      // Fluttertoast.showToast(msg: 'Please Accept Term&Conditon');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            titlePadding: const EdgeInsets.only(top: 16, left: 24, bottom: 6),
            contentPadding:
                const EdgeInsets.only(top: 2, bottom: 12, left: 24, right: 24),
            title: Column(
              children: const [
                Icon(
                  Icons.check_circle_outline,
                  size: 60,
                  color: Colors.green,
                ),
                SizedBox(height: 6),
                Text(
                  'ACCEPT TERMS',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.3,
                  ),
                ),
              ],
            ),
            content: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "By creating an account, Please Accept ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  TextSpan(
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                    text: "Term & Conditions",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        _launchUrl(
                            'https://app.websitepolicies.com/policies/view/5r6t2xx1');
                      },
                  ),
                  const TextSpan(
                    text: " and ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  TextSpan(
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                    text: "Privacy Policy",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        _launchUrl(
                            'https://app.websitepolicies.com/policies/view/r06kud3i');
                      },
                  ),
                ],
              ),
            ),
            actionsPadding:
                const EdgeInsets.only(top: 6, bottom: 16, right: 12),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyTheme.greenColor,
                  // padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: const Text(
                  ' OK ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

      return;
    } else {
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
        "device_id": HomeScreen.notifyToken,
      };
      // print(data);
      // authViewModel.sendOTPEmail = emailAddressController.text.trim();
      authViewModel.signUp(data, emailAddressController.text.trim(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(systemNavigationBarColor: Colors.white),
    );

    // final TextStyle textstyle =
    //     TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
    // final InputDecoration decoration = InputDecoration(
    //   border: OutlineInputBorder(),
    // );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyTheme.whiteColor,
      appBar: mainAppBar(context: context, appBarTitle: 'Create Account'),
      bottomSheet: AuthBottom(
        title: 'Already have an account?',
        text: 'Sign In!',
        onTap: () {
          Navigator.of(context).pushNamed(RouteName.login);
        },
      ),
      body: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
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
                              auth.imageDetail['imagePath'].toString().isEmpty
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
                  const SizedBox(height: 16),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: InputTextFormField(
                      controller: firstNameController,
                      hintText: 'First Name',
                      icon: Icons.person,
                      validator: textFieldValidator.firstNameErrorGetter,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: InputTextFormField(
                      controller: lastNameController,
                      hintText: 'Last Name',
                      icon: Icons.person,
                      validator: textFieldValidator.lastNameErrorGetter,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: InputTextFormField(
                      controller: emailAddressController,
                      hintText: 'Email Address',
                      icon: Icons.email,
                      validator: textFieldValidator.emailErrorGetter,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: InputTextFormField(
                      controller: phoneNumberController,
                      hintText: 'Phone',
                      icon: Icons.phone,
                      validator: textFieldValidator.phoneNumberErrorGetter,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Consumer<AuthViewModel>(
                    builder: (context, authViewModel, _) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            InputPasswordTextFormField(
                              controller: passwordController,
                              hintText: 'Password',
                              fontAwsomeIcon: Icons.password,
                              validator: textFieldValidator.passwordErrorGetter,
                              obscureText: authViewModel.passwordHide,
                              onPress: authViewModel.togglePassword,
                            ),
                            const SizedBox(height: 8),
                            InputPasswordTextFormField(
                              controller: confirmPasswordController,
                              hintText: 'Confirm Password',
                              fontAwsomeIcon: Icons.password,
                              validator:
                                  textFieldValidator.confirmPasswordErrorGetter,
                              password: passwordController,
                              obscureText: authViewModel.confirmPasswordHide,
                              onPress: authViewModel.toggleConfirmPassword,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Consumer<AuthViewModel>(
                          builder: (context, authViewModel, _) {
                            return Checkbox(
                              checkColor: Colors.white,
                              activeColor: MyTheme.greenColor,
                              value: authViewModel.isCheckTCAndPP,
                              onChanged: (bool? value) {
                                authViewModel.toggleTCAndPP();
                              },
                            );
                          },
                        ),
                        // const Text(
                        //   'Accept Term & Condition and Privacy Policy',
                        //   style: TextStyle(
                        //     color: Colors.black,
                        //     fontSize: 13.0,
                        //   ),
                        // )
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Accept ",
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                style: const TextStyle(
                                  color: MyTheme.greenColor,
                                  decoration: TextDecoration.underline,
                                ),
                                text: "Term & Condition",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    _launchUrl(
                                        'https://app.websitepolicies.com/policies/view/5r6t2xx1');
                                  },
                              ),
                              const TextSpan(
                                text: " and ",
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                style: const TextStyle(
                                  color: MyTheme.greenColor,
                                  decoration: TextDecoration.underline,
                                ),
                                text: "Privacy Policy",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    _launchUrl(
                                        'https://app.websitepolicies.com/policies/view/r06kud3i');
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Consumer<AuthViewModel>(
                    builder: (context, authViewModel, _) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: DeafultButton(
                          title: 'Sign Up',
                          isloading: authViewModel.loading,
                          onPress: validateAndSignup,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
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
