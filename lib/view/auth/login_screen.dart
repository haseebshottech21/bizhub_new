import 'package:bizhub_new/components/deafult_button.dart';
import 'package:bizhub_new/utils/mytheme.dart';
import 'package:bizhub_new/view_model/auth_view_model.dart';
import 'package:bizhub_new/widgets/common/auth_botom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/field_validator.dart';
import '../../utils/routes/routes_name.dart';
import '../../widgets/common/input_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailAddressController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final textFieldValidator = TextFieldValidators();

  validateAndLogin() {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      Map data = {
        "email": emailAddressController.text,
        "password": passwordController.text,
      };
      authViewModel.login(data, context);
    }
  }

  @override
  void dispose() {
    emailAddressController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget bottom() {
    return AuthBottom(
      title: 'Don\'t have an account?',
      text: 'Sign Up!',
      onTap: () {
        Navigator.of(context).pushNamed(RouteName.signup);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // AuthViewModel authViewModel =
    //     Provider.of<AuthViewModel>(context, listen: false);

    // final size = MediaQuery.of(context).size;
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(statusBarColor: Colors.grey.shade50),
    // );

    return Scaffold(
      backgroundColor: MyTheme.whiteColor,
      resizeToAvoidBottomInset: false,
      bottomSheet: bottom(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 50.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 35),
              Center(
                child: Image.asset(
                  'assets/images/bizhub_logo_black.png',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'WELCOME TO BIZHUB',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Sign in to continue',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    InputTextFormField(
                      controller: emailAddressController,
                      hintText: 'Email Address',
                      icon: Icons.email,
                      validator: textFieldValidator.emailErrorGetter,
                    ),
                    const SizedBox(height: 12),
                    // InputTextfield(
                    //   controller: passwordController,
                    //   hintText: 'Password',
                    //   icon: Icons.password,
                    //   isPassword: true,
                    // ),
                    Consumer<AuthViewModel>(
                      builder: (ctx, authViewModel, _) {
                        // return FormPasswordIconTextField(
                        //   hintText: 'Enter Password',
                        //   controller: passwordController,
                        //   fontAwsomeIcon: passwordIcon,
                        //   validator: textFieldValidator.passwordErrorGetter,
                        //   onPress: signupToggle.togglePassword,
                        //   obscureText: signupToggle.passwordVisible,
                        // );
                        return InputPasswordTextFormField(
                          controller: passwordController,
                          hintText: 'Password',
                          fontAwsomeIcon: Icons.password,
                          validator: textFieldValidator.passwordErrorGetter,
                          obscureText: authViewModel.passwordHide,
                          onPress: authViewModel.togglePassword,
                        );
                      },
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                              'Remember me',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                              ),
                            )
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            // Navigator.of(context).pushNamed(
                            //   ForgotPasswordScreen.routeName,
                            // );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 5),
                            child: const Text(
                              'Forgot Password ?',
                              style: TextStyle(
                                color: MyTheme.greenColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Consumer<AuthViewModel>(
                      builder: (context, authViewModel, _) {
                        return DeafultButton(
                          title: 'Log In',
                          isloading: authViewModel.loading,
                          onPress: () {
                            // validateAndLogin();
                            // print(authViewModel.loading);
                            authViewModel.signIn(context);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
