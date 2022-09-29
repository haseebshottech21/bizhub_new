import 'package:bizhub_new/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/deafult_button.dart';
import '../../../widgets/common/app_bar.dart';
import '../../../widgets/common/input_textfield.dart';
import '../component/profile_image.dart';

class EditMyProfile extends StatefulWidget {
  const EditMyProfile({Key? key}) : super(key: key);

  @override
  State<EditMyProfile> createState() => _EditMyProfileState();
}

class _EditMyProfileState extends State<EditMyProfile> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailAddressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void getProfileValues() async {
    final auth = Provider.of<AuthViewModel>(context, listen: false);
    await auth.getUser(context);
    firstNameController.text = auth.user!.firstName.toString();
    lastNameController.text = auth.user!.lastName.toString();
    emailAddressController.text = auth.user!.email.toString();
    phoneNumberController.text = auth.user!.phone.toString();
    print('Image: ${auth.user!.image.toString()}');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getProfileValues();
    });
  }

  validateAndUpdate() {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      Map data = {
        "first_name": firstNameController.text.trim(),
        "last_name": lastNameController.text.trim(),
        "email": emailAddressController.text.trim(),
        "phone": phoneNumberController.text.trim(),
        // if (authViewModel.imageDetail['imagePath'].toString().isNotEmpty)
        //   "image": authViewModel.imageDetail['image'].toString(),
        // "extension": authViewModel.imageDetail['extension'].toString(),
        "device_id": '123',
      };
      authViewModel.updateUser(data, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      // resizeToAvoidBottomInset: false,
      appBar: mainAppBar(context: context, appBarTitle: 'Edit Profile'),
      body: auth.loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                            const ProfileImage(),
                            const SizedBox(height: 20),
                            LabelTextField(
                              label: 'First Name',
                              controller: firstNameController,
                            ),
                            const SizedBox(height: 20),
                            LabelTextField(
                              label: 'Last Name',
                              controller: lastNameController,
                            ),
                            const SizedBox(height: 20),
                            LabelTextField(
                              label: 'Email',
                              controller: emailAddressController,
                            ),
                            const SizedBox(height: 20),
                            LabelTextField(
                              label: 'Phone',
                              controller: phoneNumberController,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Consumer<AuthViewModel>(
                      builder: (context, authViewModel, _) {
                        return DeafultButton(
                          title: 'Update',
                          isloading: authViewModel.btnloading,
                          onPress: () {
                            validateAndUpdate();
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
}
