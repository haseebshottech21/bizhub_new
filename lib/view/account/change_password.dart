import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/deafult_button.dart';
import '../../language/language_constant.dart';
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
  // final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final textFieldValidator = TextFieldValidators();

  validateAndUpdate() {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      Map data = {
        "password": newPasswordController.text,
        "password_confirmation": confirmPasswordController.text,
      };
      authViewModel.updatePassword(data, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.whiteColor,
      resizeToAvoidBottomInset: false,
      appBar: mainAppBar(
        context: context,
        appBarTitle: translation(context).changePassword,
      ),
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
                      Text(
                        translation(context).updatePassword,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Consumer<AuthViewModel>(
                        builder: (context, authViewModel, _) {
                          return Column(
                            children: [
                              InputPasswordTextFormField(
                                controller: newPasswordController,
                                hintText: translation(context).newPasswordField,
                                fontAwsomeIcon: Icons.password,
                                validator:
                                    textFieldValidator.passwordErrorGetter,
                                obscureText: authViewModel.passwordHide,
                                onPress: authViewModel.togglePassword,
                              ),
                              const SizedBox(height: 8),
                              InputPasswordTextFormField(
                                controller: confirmPasswordController,
                                hintText:
                                    translation(context).confirmPasswordField,
                                fontAwsomeIcon: Icons.password,
                                validator: textFieldValidator
                                    .confirmPasswordErrorGetter,
                                password: newPasswordController,
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
              const SizedBox(height: 20),
              Consumer<AuthViewModel>(
                builder: (context, authViewModel, _) {
                  return DeafultButton(
                    title: translation(context).updatePassword,
                    isloading: authViewModel.loading,
                    onPress: () {
                      validateAndUpdate();
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

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
