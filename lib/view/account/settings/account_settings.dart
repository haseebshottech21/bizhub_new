import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/deafult_button.dart';
import '../../../language/language_constant.dart';
import '../../../utils/mytheme.dart';
import '../../../utils/routes/routes_name.dart';
import '../../../view_model/auth_view_model.dart';
import '../../../widgets/common/dialog_box.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthViewModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.greenColor,
        title: Text(
          translation(context).settings,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultOutlineButton(
                  title: translation(context).logout,
                  btnTextColor: MyTheme.redBorder,
                  borderColor: MyTheme.redBorder,
                  onPress: () {
                    simpleShowDialog(
                      context: context,
                      title: 'Confirm Logout',
                      subTitle: 'You are about to logout',
                      press: () {
                        Navigator.of(context).pop();
                        // authViewModel.logout(context);
                        context.read<AuthViewModel>().logout(context);
                      },
                    );
                  },
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),
                actionItem(
                  context: context,
                  text: 'Delete account',
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.deleteAccount);
                  },
                )
              ],
            ),
          ),
          auth.loading
              ? Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: 65,
                    width: MediaQuery.of(context).size.width * 0.42,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: kElevationToShadow[6],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.grey[200],
                            valueColor: const AlwaysStoppedAnimation(
                                MyTheme.greenColor),
                            strokeWidth: 2.5,
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Text(
                          "Please Wait...",
                          style: TextStyle(
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}

Widget actionItem({
  required BuildContext context,
  required String text,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.only(
        top: 12,
        bottom: 14,
        left: 16,
        right: 16,
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              // color: profile[index]['title'] == 'Logout'
              //     ? Color(0xFF3c7cbc)
              //     : Theme.of(context).textTheme.bodyText1!.color,
              // color: Color(0xFF50182c),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios_outlined,
            color: Theme.of(context).iconTheme.color,
            size: 17,
          ),
        ],
      ),
    ),
  );
}
