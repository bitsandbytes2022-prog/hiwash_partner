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
import '../auth_controller/auth_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  AuthController controller =
      Get.isRegistered<AuthController>()
          ? Get.find<AuthController>()
          : Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: AuthBg(
        headingText: "kWelcomeBack".tr,
        subText: "kLogin".tr,

        showBackButton: true,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              114.heightSizeBox,

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
              40.heightSizeBox,
              HiWashTextField(
                controller: controller.loginPhoneController,
                keyboardType: TextInputType.phone,

                hintText: "Phone".tr,
                labelText: "Phone".tr,

                validator: (value) {
                  return controller.validatePhoneNumberLogin(value);
                },
              ),

              100.heightSizeBox,
              Obx(() {
                return HiWashButton(
                  isLoading: controller.isLoading.value,
                  text: "kRecoverPassword".tr,
                  onTap: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      String phoneNumber =
                          controller.loginPhoneController.text.trim();
                      await controller
                          .sendOtp(phoneNumber)
                          .then((value) {
                            if (value != null) {
                              Get.toNamed(
                                RouteStrings.otpScreen,
                                arguments: phoneNumber,
                              );
                              controller.loginPhoneController.clear();
                            }
                          })
                          .catchError((error) {
                            print("Error during OTP sending: $error");
                          });
                    }
                  },
                );
              }),

              20.heightSizeBox,
            ],
          ),
        ),
      ),
    );
  }
}
