import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hiwash_partner/featuers/profile/view/terms%20_and_condition_screen.dart';
import '../featuers/auth/view/forgot_password_screen.dart';
import '../featuers/auth/view/login_screen.dart';
import '../featuers/auth/view/otp_screen.dart';
import '../featuers/auth/view/reset_password_screen.dart';
import '../featuers/auth/view/splash_screen.dart';
import '../featuers/auth/view/welcome_screen.dart';
import '../featuers/dashboard/view/dashbord_screen.dart';
import '../featuers/dashboard/view/widget/second_drawer/faq_screen.dart';
import '../featuers/dashboard/view/widget/second_drawer/help_desk_ticket_screen.dart';
import '../featuers/dashboard/view/widget/second_drawer/step_by_step_guide_detail_screen.dart';
import '../featuers/dashboard/view/widget/second_drawer/step_by_step_guide_screen.dart';
import '../featuers/profile/view/language_screen.dart';
import '../featuers/reward/view/reward_screen.dart';

import 'route_strings.dart';

class Routes {
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  static final pages = [
  GetPage(
  name: RouteStrings.splashScreen,
  page: () => SplashScreen(),
 ),
    GetPage(
  name: RouteStrings.welcomeScreen,
  page: () => WelcomeScreen(),
 ),

    GetPage(
  name: RouteStrings.loginScreen,
  page: () => LoginScreen(),
 ),


    GetPage(
  name: RouteStrings.forgotPasswordScreen,
  page: () => ForgotPasswordScreen(),
 ),
    GetPage(
  name: RouteStrings.otpScreen,
  page: () => OtpScreen(),
 ),

    GetPage(
  name: RouteStrings.resetPasswordScreen,
  page: () => ResetPasswordScreen(),
 ),

  GetPage(
  name: RouteStrings.rewardScreen,
  page: () => RewardScreen(),
 ),

    GetPage(
  name: RouteStrings.dashboardScreen,
  page: () => DashboardScreen(),
 ),

   GetPage(
  name: RouteStrings.termsAndConditionScreen,
  page: () => TermsAndConditionScreen(),
 ),
    GetPage(
      name: RouteStrings.faqScreen,
      page: () => FaqScreen(),
    ),

    GetPage(
      name: RouteStrings.helpDeskTicketScreen,
      page: () => HelpDeskTicketScreen(),
    ),
    GetPage(
      name: RouteStrings.stepByStepGuideScreen,
      page: () => StepByStepGuideScreen(),
    ),

    GetPage(
      name: RouteStrings.stepByStepGuideDetailScreen,
      page: () => StepByStepGuideDetailScreen(),
    ),

    GetPage(
      name: RouteStrings.languageScreen,
      page: () => LanguageScreen(),
    ),




  ];



}