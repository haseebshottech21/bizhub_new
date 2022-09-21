import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/deafult_button.dart';
import '../../utils/field_validator.dart';
import '../../utils/mytheme.dart';
import '../../view_model/auth_view_model.dart';
import '../../widgets/common/app_bar.dart';
import '../../widgets/common/input_textfield.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final textFieldValidator = TextFieldValidators();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.whiteColor,
      resizeToAvoidBottomInset: false,
      appBar: mainAppBar(context: context, appBarTitle: 'Change Password'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Current Password',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 12),
                      InputPasswordTextFormField(
                        controller: currentPasswordController,
                        hintText: 'Password',
                        fontAwsomeIcon: Icons.password,
                        validator: textFieldValidator.passwordErrorGetter,
                        // obscureText: authViewModel.passwordHide,
                        // onPress: authViewModel.togglePassword,
                        obscureText: true,
                        onPress: () {},
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'New Password',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 12),
                      InputPasswordTextFormField(
                        controller: newPasswordController,
                        hintText: 'New Password',
                        fontAwsomeIcon: Icons.password,
                        validator: textFieldValidator.passwordErrorGetter,
                        // obscureText: authViewModel.passwordHide,
                        // onPress: authViewModel.togglePassword,
                        obscureText: true,
                        onPress: () {},
                      ),
                      const SizedBox(height: 8),
                      InputPasswordTextFormField(
                        controller: confirmPasswordController,
                        hintText: 'Confirm New Password',
                        fontAwsomeIcon: Icons.password,
                        validator: textFieldValidator.passwordErrorGetter,
                        // obscureText: authViewModel.passwordHide,
                        // onPress: authViewModel.togglePassword,
                        obscureText: true,
                        onPress: () {},
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Consumer<AuthViewModel>(
                builder: (context, authViewModel, _) {
                  return DeafultButton(
                    title: 'Update Password',
                    isloading: authViewModel.loading,
                    onPress: () {
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
