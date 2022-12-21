import 'package:flutter/material.dart';
import '../../../components/deafult_button.dart';
import '../../../utils/mytheme.dart';
import '../../../widgets/common/dialog_box.dart';

class ConfirmDeletion extends StatefulWidget {
  const ConfirmDeletion({Key? key}) : super(key: key);

  @override
  State<ConfirmDeletion> createState() => _ConfirmDeletionState();
}

class _ConfirmDeletionState extends State<ConfirmDeletion> {
  final TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: mainAppBar(context: context, appBarTitle: 'Delete Profile'),
      appBar: AppBar(
        backgroundColor: MyTheme.greenColor,
        title: const Text(
          'Delete Account',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Delete Account',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'You will permanently lose all your reviews, messages, and profile info. After this, there is no turning back.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 30),
            DeafultButton(
              color: MyTheme.redBorder,
              title: 'CONFIRM DELETION',
              onPress: () {
                // Navigator.pushNamed(context, RouteName.createPost);
                // print(post.isPoster);
                if (confirmPassController.text.isNotEmpty) {
                  confirmPassController.clear();
                }
                showDialog(
                  context: context,
                  builder: (_) => confirmDeleteDialog(
                    context: context,
                    title: 'Type your account password',
                    controller: confirmPassController,
                    onPressed: () {},
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
