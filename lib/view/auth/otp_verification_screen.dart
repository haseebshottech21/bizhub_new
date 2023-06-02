import 'package:bizhub_new/utils/mytheme.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../components/deafult_button.dart';
import '../../view_model/auth_view_model.dart';
import '../../widgets/common/app_bar.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  String currentText = "";
  TextEditingController otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  validateAndVerifyOTP() {
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      authViewModel.otpValidate(
        context: context,
        otpCode: otpController.text.trim(),
      );
    }
  }

  resendOTP() {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    authViewModel.resenOtp();
  }

  getOTPEmail() {
    final auth = context.read<AuthViewModel>();
    auth.getOTPEmail();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getOTPEmail();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: actionAppBar(
        context: context,
        appBarTitle: 'OTP Verification',
        btnText: 'Clear',
        onPressed: () {
          otpController.clear();
        },
      ),
      // appBar: mainAppBar(context: context, appBarTitle: 'OTP Verification'),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
                child: Text(
                  'ACCOUNT \nVERIFICATION',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
                child: Consumer<AuthViewModel>(
                  builder: (context, auth, _) {
                    return Text(
                      "We sent email with a 4-digit verification code to ${auth.sendOTPEmail}",
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 14),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 40.0,
                  ),
                  child: PinCodeTextField(
                    appContext: context,
                    // pastedTextStyle: TextStyle(
                    //   color: Colors.green.shade600,
                    //   fontWeight: FontWeight.bold,
                    // ),
                    length: 4,
                    obscureText: true,
                    obscuringCharacter: '*',
                    // obscuringWidget: const FlutterLogo(
                    //   size: 24,
                    // ),
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    // validator: (v) {
                    //   if (v!.length < 3) {
                    //     return "I'm from validator";
                    //   } else {
                    //     return null;
                    //   }
                    // },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 50,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      inactiveColor: Colors.black54,
                      borderWidth: 1,
                    ),
                    cursorColor: Colors.black,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    // errorAnimationController: errorController,
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    boxShadows: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        blurRadius: 5,
                      )
                    ],
                    onCompleted: (v) {
                      debugPrint("Completed");
                    },
                    // onTap: () {
                    //   print("Pressed");
                    // },
                    onChanged: (value) {
                      debugPrint(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      debugPrint("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't receive the code? ",
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                  TextButton(
                    // onPressed: () => snackBar("OTP resend!!"),
                    onPressed: () {
                      resendOTP();
                    },
                    child: const Text(
                      "RESEND",
                      style: TextStyle(
                        color: MyTheme.greenColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 14),
              Consumer<AuthViewModel>(
                builder: (context, authViewModel, _) {
                  return DeafultButton(
                    title: 'CONFIRM',
                    isloading: authViewModel.loading,
                    onPress: currentText.length != 4
                        ? null
                        : () {
                            // print(authViewModel.loading);
                            // authViewModel.otpVerify(context);
                            validateAndVerifyOTP();
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
    otpController.clear();
    super.dispose();
  }
}
