import 'package:bizhub_new/widgets/common/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../components/deafult_button.dart';
import '../../utils/field_validator.dart';
import '../../utils/mytheme.dart';
import '../../utils/routes/routes_name.dart';
import '../../view_model/auth_view_model.dart';
import '../../widgets/common/auth_botom.dart';
import '../account/component/profile_image.dart';
import '../../widgets/common/input_textfield.dart';

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

  //   final emailAddressController = TextEditingController();
  // final passwordController = TextEditingController();
  // final _formKey = GlobalKey<FormState>();

  // final textFieldValidator = TextFieldValidators();

  validateAndSignup() {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      Map data = {
        "first_name": firstNameController.text.trim(),
        "last_name": lastNameController.text.trim(),
        "email": emailAddressController.text.trim(),
        "phone": phoneNumberController.text.trim(),
        "password": passwordController.text.trim(),
        "password_confirmation": confirmPasswordController.text.trim(),
        "device_id": '123',
      };
      authViewModel.signUp(data, context);
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

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(statusBarColor: MyTheme.whiteColor),
    // );

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
                      const ProfileImage(),
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
                          LengthLimitingTextInputFormatter(11),
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
                    // onPress: validateAndSignup,
                    onPress: () {
                      validateAndSignup();
                      // print(authViewModel.loading);
                      // authViewModel.signUp(context);
                    },
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
}
