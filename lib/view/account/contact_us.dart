import 'package:flutter/material.dart';

import '../../components/deafult_button.dart';
import '../../utils/mytheme.dart';
import '../../widgets/common/app_bar.dart';
import '../../widgets/common/input_textfield.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final firstNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.whiteColor,
      resizeToAvoidBottomInset: false,
      appBar: mainAppBar(context: context, appBarTitle: 'Contact Us'),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'WE\'D LOVE TO HELP YOU IN EMAIL OR VIA CALL!',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Please Email us using the contact form or call us.',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),
                    EditLabelTextFields(
                      label: 'Your First Name',
                      hintText: 'Enter First name',
                      controller: firstNameController,
                      validator: () {},
                    ),
                    const SizedBox(height: 15),
                    EditLabelTextFields(
                      label: 'Your Last Name',
                      hintText: 'Enter Last name',
                      controller: firstNameController,
                      validator: () {},
                    ),
                    const SizedBox(height: 15),
                    EditLabelTextFields(
                      label: 'Your Phone Number',
                      hintText: 'e.g 03111444975',
                      controller: firstNameController,
                      validator: () {},
                    ),
                    const SizedBox(height: 15),
                    EditLabelTextFields(
                      label: 'Your Email',
                      hintText: 'example@example.com',
                      controller: firstNameController,
                      validator: () {},
                    ),
                    const SizedBox(height: 15),
                    EditLabelTextFields(
                      label: 'Subject',
                      hintText: '',
                      controller: firstNameController,
                      validator: (val) {
                        if (val.toString().isEmpty) {
                          return 'Please Enter Subject';
                        } else if (val.toString().length < 5) {
                          return 'minimum 5 Characters are Required';
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    // EditLabelTextArea(
                    //   label: 'Your Message',
                    //   hintText: '',
                    //   controller: messageController,
                    //   validator: (val) {
                    //     if (val.toString().isEmpty) {
                    //       return 'Please Enter Message';
                    //     } else if (val.toString().length < 5) {
                    //       return 'minimum 5 Characters are Required';
                    //     }
                    //   },
                    // ),
                    const SizedBox(height: 10),
                    // FormButton(
                    //   text: 'SEND',
                    //   color: AppColors.primaryColor,
                    //   size: const Size(100, 40),
                    //   onPressed: () {
                    //     validateAndContactUs();
                    //   },
                    // ),
                    DeafultButton(
                      title: 'SEND',
                      // isloading: authViewModel.loading,
                      onPress: () {
                        // print(authViewModel.loading);
                        // authViewModel.signUp(context);
                      },
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      height: 10.0,
                      child: Center(
                        child: Container(
                          // margin: const EdgeInsetsDirectional.only(
                          //   start: 1.0,
                          //   end: 1.0,
                          // ),
                          height: 2,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Center(
                      child: Text(
                        'PHONE:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        '+1 (000) 333 0000',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Center(
                      child: Text(
                        'EMAIL:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'support@bizhub.com',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Center(
                      child: Text(
                        'ADDRESS:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      '92 Lorem simply street line New York, USA',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
            // Consumer<AuthenticationViewModel>(
            //   builder: (ctx, auth, neverBuildChild) {
            //     return auth.isLoading
            //         ? SizedBox(
            //             height: MediaQuery.of(context).size.height,
            //             child: loadingOne(context),
            //           )
            //         : const SizedBox();
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
