import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';

import '../../../route/route_strings.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/auth_bg.dart';
import '../../../widgets/components/hi_wash_button.dart';
import '../../../widgets/components/hi_wash_text_field.dart';
import 'auth_controller/auth_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  AuthController authController =
      Get.isRegistered<AuthController>()
          ? Get.find<AuthController>()
          : Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: AuthBg(
        headingText: "kForgot".tr,
        subText: 'kPassword'.tr,

        child: Form(
          key: _formKey,
          child: Column(
            children: [
              110.heightSizeBox,
              Text(
                "kEnterRegisteredPhone".tr,
                style: w700_22a(color: AppColor.c2C2A2A),
              ),
              14.heightSizeBox,
              Text(
                "kEnterThePhoneNumber".tr,
                textAlign: TextAlign.center,
                style: w400_12p(color: AppColor.c455A64),
              ),
              21.heightSizeBox,
              HiWashTextField(
                controller: authController.phoneForgotController,
                keyboardType: TextInputType.phone,
                hintText: "kEnterYourPhoneNumber".tr,
                labelText: "kPhone".tr,
                validator: (value){
                  return authController.validatePhoneNumber(value);
                },
              ),
              184.heightSizeBox,
              HiWashButton(
                text: "kRecoverPassword".tr,
                onTap: () {
                  if (_formKey.currentState?.validate() ?? false) {
                  Get.toNamed(RouteStrings.otpScreen);}
                },
              ),

              60.heightSizeBox,
            ],
          ),
        ),
      ),
    );
  }
}
