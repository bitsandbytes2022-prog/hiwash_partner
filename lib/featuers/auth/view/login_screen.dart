import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_partner/widgets/components/auth_bg.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../route/route_strings.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../widgets/components/bottom_sheet_bg.dart';
import '../../../widgets/components/hi_wash_button.dart';
import '../../../widgets/components/hi_wash_text_field.dart';
import '../auth_controller/auth_controller.dart';
import 'auth_widgets/bg_widget.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_partner/route/route_strings.dart';
import 'package:hiwash_partner/styling/app_color.dart';
import 'package:hiwash_partner/styling/app_font_anybody.dart';
import 'package:hiwash_partner/widgets/components/auth_bg.dart';
import 'package:hiwash_partner/widgets/components/hi_wash_button.dart';
import 'package:hiwash_partner/widgets/components/hi_wash_text_field.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: AuthBg(
        headingText: "kWelcomeBack".tr,
        subText: "kLogin".tr,
        //showBackButton: false,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              114.heightSizeBox,
              HiWashTextField(
                keyboardType: TextInputType.emailAddress,
                controller: authController.emailController,

                hintText: "kEmail".tr,
                labelText: "kEmail".tr,

                validator: (value) {
                  return authController.validateEmail(value);
                },
              ),
              24.heightSizeBox,
              HiWashTextField(
                controller: authController.passwordController,
                keyboardType: TextInputType.visiblePassword,
                hintText: "kPassword".tr,
                labelText: "kPassword".tr,

                validator: (value) {
                  return authController.validatePassword(value);
                },
              ),
              12.heightSizeBox,

              56.heightSizeBox,
              Obx(() {
                return HiWashButton(
                  isLoading: authController.isLoading.value,
                  text: "kLogIn".tr,
                  onTap: () {
                    // Get.offNamed(RouteStrings.dashboardScreen);
                    if (formKey.currentState?.validate() ?? false) {
                      authController
                          .login(
                            authController.emailController.text,
                            authController.passwordController.text,
                          )
                          .then((value) {
                            Get.offNamed(RouteStrings.dashboardScreen);
                          });
                    }
                  },
                );
              }),
              56.heightSizeBox,
              GestureDetector(
                onTap: () {
                  Get.toNamed(RouteStrings.forgotPasswordScreen);
                },
                child: Text(
                  "kForgotPassword".tr,
                  style: w500_14a(color: AppColor.red),
                ),
              ),
              20.heightSizeBox,
            ],
          ),
        ),
      ),
    );
  }
}
