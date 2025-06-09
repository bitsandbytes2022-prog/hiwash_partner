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

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  AuthController authController =
      Get.isRegistered<AuthController>()
          ? Get.find<AuthController>()
          : Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final String phoneNumber = Get.arguments as String;
    authController.phoneRestController.text = phoneNumber;
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: AuthBg(
        headingText: "kReset".tr,
        subText: 'kPassword'.tr,

        child: Form(
          key: _formKey,
          child: Column(
            children: [
              110.heightSizeBox,
              Text(
                "kCreateNewPassword".tr,
                style: w700_22a(color: AppColor.c2C2A2A),
              ),
              14.heightSizeBox,
              Text(
                "kYourNewPasswordMust".tr,
                textAlign: TextAlign.center,
                style: w400_12p(color: AppColor.c455A64),
              ),
              23.heightSizeBox,
              HiWashTextField(
                readOnly: true,
                keyboardType: TextInputType.number,
                controller: authController.phoneRestController,
                hintText: "Phone".tr,
                labelText: "Phone".tr,

                validator: (value) {
                  return authController.validatePhoneNumberLogin(value);
                },
              ),
              20.heightSizeBox,
              Obx(() {
                return HiWashTextField(
                  controller: authController.passwordRestController,
                  hintText: "kPassword".tr,
                  labelText: "kPassword".tr,

                  obscuringCharacter: '*',
                  obscure: !authController.isPasswordVisible.value,
                  validator: (value) {
                    return authController.validatePassword(value);
                  },
                  onTap: () {
                    authController.togglePasswordVisibility();
                  },
                  suffixIcon: Icon(
                    authController.isPasswordVisible.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColor.c455A64.withOpacity(0.5),
                  ),
                );
              }),
              105.heightSizeBox,
              Obx(() {
                return HiWashButton(
                  isLoading: authController.isLoading.value,
                  text: 'kSave'.tr,
                  onTap: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      authController
                          .resetPassword(
                            authController.phoneRestController.text,
                            authController.passwordRestController.text,
                          )
                          .then((value) {
                            if (value != null) {
                              Get.offNamedUntil(
                                RouteStrings.loginScreen,
                                (route) => false,
                              );
                            }
                          });
                    }
                  },
                );
              }),

              30.heightSizeBox,
            ],
          ),
        ),
      ),
    );
  }
}
