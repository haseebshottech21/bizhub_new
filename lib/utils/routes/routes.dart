import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:bizhub_new/view/account/about_us.dart';
import 'package:bizhub_new/view/account/change_password.dart';
import 'package:bizhub_new/view/account/settings/account_settings.dart';
import 'package:bizhub_new/view/account/settings/delete/confirm_deletion.dart';
import 'package:bizhub_new/view/account/settings/delete/select_delete_reason.dart';
import 'package:bizhub_new/view/account/privacy_policy.dart';
import 'package:bizhub_new/view/account/profile/edit_my_profile.dart';
import 'package:bizhub_new/view/account/profile/view_my_profile.dart';
// import 'package:bizhub_new/view/account/select_language.dart';
import 'package:bizhub_new/view/account/term_and_condition.dart';
import 'package:bizhub_new/view/auth/forgot_password_screen.dart';
import 'package:bizhub_new/view/auth/login_screen.dart';
import 'package:bizhub_new/view/auth/otp_sccess_screen.dart';
import 'package:bizhub_new/view/auth/reset_password_screen.dart';
import 'package:bizhub_new/view/auth/signup_screen.dart';
// import 'package:bizhub_new/view/auth/welcome_auth_screen.dart';
import 'package:bizhub_new/view/create/component/serach_location.dart';
import 'package:bizhub_new/view/create/create_post.dart';
import 'package:bizhub_new/view/create/select_category.dart';
import 'package:bizhub_new/view/create/select_service.dart';
import 'package:bizhub_new/view/auth/without_auth_screen.dart';
import 'package:bizhub_new/view/home/filter_screen.dart';
import 'package:bizhub_new/view/home/search_posts.dart';
import 'package:bizhub_new/view/navigation/bottom_navigation.dart';
import 'package:bizhub_new/view/onboard_screen.dart';
import 'package:bizhub_new/view/posts/my_posts.dart';
import 'package:bizhub_new/view/splash_screen.dart';
// import 'package:bizhub_new/view/test_location.dart';
import 'package:flutter/material.dart';
import '../../view/account/select_language.dart';
import '../../view/auth/otp_verification_screen.dart';
// import '../../view/posts/my_jobs/edit_poster_service.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final arguments = settings.arguments;
    switch (settings.name) {
      case RouteName.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RouteName.onboard:
        return MaterialPageRoute(builder: (context) => const OnboardScreen());
      case RouteName.authNotLogin:
        return MaterialPageRoute(
            builder: (context) => const WithoutAuthScreen());
      // case RouteName.welcome:
      //   return MaterialPageRoute(
      //       builder: (context) => const WelcomeAuthScreen());
      case RouteName.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case RouteName.signup:
        return MaterialPageRoute(builder: (context) => const SignupScreen());
      case RouteName.forgotPassword:
        return MaterialPageRoute(builder: (context) => const ForgotPassword());
      case RouteName.resetPassword:
        return MaterialPageRoute(builder: (context) => const ResetPassword());
      case RouteName.otp:
        return MaterialPageRoute(
            builder: (context) => const OTPVerificationScreen());
      case RouteName.otpSuccess:
        return MaterialPageRoute(
            builder: (context) => const OTPSuccessScreen());
      case RouteName.home:
        return MaterialPageRoute(
            builder: (context) => const NavigatoionBarScreen());
      case RouteName.filter:
        return MaterialPageRoute(builder: (context) => const FilterScreen());
      // case RouteName.postDetail:
      //   return MaterialPageRoute(builder: (context) => const PostJobDetail());
      case RouteName.searchPost:
        return MaterialPageRoute(builder: (context) => const SearchPosts());
      // case RouteName.myJobDetail:
      //   return MaterialPageRoute(

      //     builder: (context) => MyJobDetail(),
      //   );
      // case RouteName.myJobComplete:
      //   return MaterialPageRoute(builder: (context) => const JobComplete());
      case RouteName.myPosts:
        return MaterialPageRoute(builder: (context) => const MyPosts());
      case RouteName.selectService:
        return MaterialPageRoute(builder: (context) => const SelectService());
      case RouteName.selectCategory:
        return MaterialPageRoute(builder: (context) => const SelectCategory());
      case RouteName.createPost:
        return MaterialPageRoute(builder: (context) => const CreatePost());
      // case RouteName.editMyPosterService:
      //   return MaterialPageRoute(
      //       builder: (context) => const EditMyPosterService());
      case RouteName.searchLocation:
        return MaterialPageRoute(
            builder: (context) => const SearchLocationScreen());
      // Messages
      // case RouteName.posterMessages:
      //   return MaterialPageRoute(builder: (context) => const PosterMessages());
      // case RouteName.workerMessages:
      //   return MaterialPageRoute(builder: (context) => const WorkerMessages());
      // MORE
      case RouteName.viewMyProfile:
        return MaterialPageRoute(builder: (context) => const ViewMyProfile());
      case RouteName.editMyProfile:
        return MaterialPageRoute(builder: (context) => const EditMyProfile());
      case RouteName.changePassword:
        return MaterialPageRoute(builder: (context) => const ChangePassword());
      case RouteName.accountSetting:
        return MaterialPageRoute(builder: (context) => const AccountSettings());
      case RouteName.aboutUs:
        return MaterialPageRoute(builder: (context) => const AboutUs());
      case RouteName.termAndCondition:
        return MaterialPageRoute(
            builder: (context) => const TermAndCondition());
      case RouteName.privacyPolicy:
        return MaterialPageRoute(builder: (context) => const PrivacyPolicy());
      case RouteName.deleteAccount:
        return MaterialPageRoute(
            builder: (context) => const SelectDeleteReason());
      case RouteName.confirmDelete:
        return MaterialPageRoute(builder: (context) => const ConfirmDeletion());
      case RouteName.selectLanguage:
        return MaterialPageRoute(builder: (context) => const SelectLanguage());
      // case RouteName.testLocation:
      //   return MaterialPageRoute(builder: (context) => const TestLocation());
      // case RouteName.testSearchLocation:
      //   return MaterialPageRoute(
      //       builder: (context) => const TestSearchLocation());
      // case RouteName.contactUs:
      //   return MaterialPageRoute(builder: (context) => const ContactUs());
      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
            centerTitle: true,
          ),
          body: const Center(
            child: Text('No route defined'),
          ),
        );
      },
    );
  }
}
