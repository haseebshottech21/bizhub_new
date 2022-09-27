import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/deafult_button.dart';
import '../../utils/field_validator.dart';
import '../../utils/mytheme.dart';
import '../../view_model/auth_view_model.dart';
import '../../widgets/common/app_bar.dart';
import '../../widgets/common/input_textfield.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailAddressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final textFieldValidator = TextFieldValidators();

  validateAndVerify() {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      authViewModel.passwordVerificationEmail(
        context: context,
        emailAddress: emailAddressController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.whiteColor,
      resizeToAvoidBottomInset: false,
      appBar: mainAppBar(context: context, appBarTitle: 'Forgot Password'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
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
                        'Forgot Password',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Enter an email for verification',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      InputTextFormField(
                        controller: emailAddressController,
                        hintText: 'Email Address',
                        icon: Icons.email,
                        validator: textFieldValidator.emailErrorGetter,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Consumer<AuthViewModel>(
                builder: (context, authViewModel, _) {
                  return DeafultButton(
                    title: 'Send Verification',
                    isloading: authViewModel.loading,
                    onPress: () {
                      validateAndVerify();
                      // print(authViewModel.loading);
                      // authViewModel.signIn(context);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailAddressController.dispose();
    super.dispose();
  }
}
