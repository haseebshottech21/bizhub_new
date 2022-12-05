import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../components/deafult_button.dart';
import '../../utils/field_validator.dart';
import '../../utils/mytheme.dart';
import '../../view_model/auth_view_model.dart';
import '../../widgets/common/input_textfield.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final verificationCodeController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final textFieldValidator = TextFieldValidators();

  validateAndResetPassword() {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      authViewModel.resetPassword(
        context: context,
        verificationCode: verificationCodeController.text.trim(),
        newPassword: newPasswordController.text.trim(),
        confirmNewPassword: confirmPasswordController.text.trim(),
      );
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
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
                        const SizedBox(height: 12),
                        const Text(
                          'Verification Code',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        InputTextFormField(
                          controller: verificationCodeController,
                          hintText: 'Code',
                          icon: Icons.verified_user,
                          validator: textFieldValidator.uniqueTokenErrorGetter,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Reset Password',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Consumer<AuthViewModel>(
                          builder: (context, authViewModel, _) {
                            return Column(
                              children: [
                                InputPasswordTextFormField(
                                  controller: newPasswordController,
                                  hintText: 'New Password',
                                  fontAwsomeIcon: Icons.password,
                                  validator:
                                      textFieldValidator.passwordErrorGetter,
                                  obscureText: authViewModel.passwordHide,
                                  onPress: authViewModel.togglePassword,
                                ),
                                const SizedBox(height: 8),
                                InputPasswordTextFormField(
                                  controller: confirmPasswordController,
                                  hintText: 'Confirm New Password',
                                  fontAwsomeIcon: Icons.password,
                                  validator: textFieldValidator
                                      .confirmPasswordErrorGetter,
                                  password: newPasswordController,
                                  obscureText:
                                      authViewModel.confirmPasswordHide,
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
                const SizedBox(height: 24),
                Consumer<AuthViewModel>(
                  builder: (context, authViewModel, _) {
                    return DeafultButton(
                      title: 'Reset Password',
                      isloading: authViewModel.loading,
                      onPress: () {
                        validateAndResetPassword();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
