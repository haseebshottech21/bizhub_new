import 'package:bizhub_new/utils/shared_prefrences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../components/deafult_button.dart';
import '../../../../language/language_constant.dart';
import '../../../../utils/field_validator.dart';
import '../../../../utils/mytheme.dart';
import '../../../../view_model/auth_view_model.dart';
import '../../../../widgets/common/dialog_box.dart';

class ConfirmDeletion extends StatefulWidget {
  const ConfirmDeletion({Key? key}) : super(key: key);

  @override
  State<ConfirmDeletion> createState() => _ConfirmDeletionState();
}

class _ConfirmDeletionState extends State<ConfirmDeletion> {
  final TextEditingController confirmPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final textFieldValidator = TextFieldValidators();

  validateAndConfirmDelete() async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      Map data = {
        "email": await Prefrences().getSharedPreferenceValue('email'),
        "password": confirmPassController.text.trim(),
      };
      authViewModel.deleteAccount(context: context, data: data);
      // print(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: MyTheme.greenColor,
        title: Text(
          translation(context).deleteAccount,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              translation(context).deleteAccount,
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              translation(context).deleteAccountDescTxt,
              style: TextStyle(
                fontSize: 17,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 30),
            DeafultButton(
              color: MyTheme.redBorder,
              title: translation(context).confirmDeletionTxt,
              onPress: () {
                if (confirmPassController.text.isNotEmpty) {
                  confirmPassController.clear();
                }
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (_) => Consumer<AuthViewModel>(
                      builder: (context, authViewModel, _) {
                    return confirmDeleteDialog(
                      context: context,
                      key: _formKey,
                      validator: textFieldValidator.passwordErrorGetter,
                      title: 'Type your account password',
                      controller: confirmPassController,
                      isloading: authViewModel.loading,
                      onPressed: () {
                        validateAndConfirmDelete();
                      },
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    confirmPassController.dispose();
    super.dispose();
  }
}
