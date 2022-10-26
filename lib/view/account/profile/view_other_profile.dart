import 'package:bizhub_new/model/user_model.dart';
import 'package:bizhub_new/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_url.dart';
import '../../../utils/mytheme.dart';
import '../component/profile_description.dart';
import '../component/view_profile.dart';

class ViewOtherProfile extends StatefulWidget {
  const ViewOtherProfile({Key? key}) : super(key: key);

  @override
  State<ViewOtherProfile> createState() => _ViewOtherProfileState();
}

class _ViewOtherProfileState extends State<ViewOtherProfile> {
  showOtherProile() async {
    final profileViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final UserModel profile =
        ModalRoute.of(context)!.settings.arguments as UserModel;
    await profileViewModel.viewOtherProfile(
      context: context,
      userId: profile.userId.toString(),
    );
    // print(profile.userId);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showOtherProile(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final UserModel profile =
        ModalRoute.of(context)!.settings.arguments as UserModel;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyTheme.greenColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ViewProfile(
              userName: '${profile.firstName} ${profile.lastName}',
              userImage: profile.image!.isEmpty
                  ? 'https://i.pinimg.com/736x/25/78/61/25786134576ce0344893b33a051160b1.jpg'
                  : AppUrl.baseUrl + profile.image!,
            ),
            const SizedBox(height: 15),
            Consumer<AuthViewModel>(
              builder: (context, authViewModel, _) {
                if (authViewModel.loading) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Center(
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.5,
                          color: MyTheme.greenColor,
                        ),
                      ),
                    ),
                  );
                }
                return ProfileDescription(
                  description: authViewModel.viewUser!.description == null
                      ? 'No description added yet.'
                      : authViewModel.viewUser!.description.toString(),
                  url: authViewModel.viewUser!.url == null
                      ? 'www.google.com'
                      : authViewModel.viewUser!.url.toString(),
                  avgRating: authViewModel.viewUser!.avgRating == 'null'
                      ? '0.0'
                      : double.parse(
                              authViewModel.viewUser!.avgRating.toString())
                          .toString(),
                  totalReviews: authViewModel.viewUser!.totalReviews == '0'
                      ? '0'
                      : '${authViewModel.viewUser!.totalReviews}',
                  ratingAndReviews: authViewModel.viewUser!.ratingList,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
