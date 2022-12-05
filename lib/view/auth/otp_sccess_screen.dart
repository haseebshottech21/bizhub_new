import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import '../../components/deafult_button.dart';
import '../../utils/mytheme.dart';
import '../../utils/routes/routes_name.dart';
import '../../widgets/common/app_bar.dart';

class OTPSuccessScreen extends StatefulWidget {
  const OTPSuccessScreen({Key? key}) : super(key: key);


  @override
  State<OTPSuccessScreen> createState() => _OTPSuccessScreenState();
}

class _OTPSuccessScreenState extends State<OTPSuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceOut,
      reverseCurve: Curves.bounceInOut,
    );
    _animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.whiteColor,
      appBar: mainAppBar(context: context, appBarTitle: 'Account Verified'),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            child: Column(
              children: [
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                  child: Text(
                    'ACCOUNT VERIFIED',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                    ),
                  ),
                ),
                ScaleTransition(
                  scale: _animation,
                  child: Image.asset('assets/images/success.png', height: 120),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 50.0),
                  child: Text(
                    "You have Successfully Verified the account",
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                ),
                const Spacer(),
                DeafultButton(
                  title: 'CONTINUE',
                  onPress: () {
                    Navigator.pushNamed(context, RouteName.login);
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
