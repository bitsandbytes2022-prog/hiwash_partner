import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';
import 'package:pinput/pinput.dart';

import '../../../generated/assets.dart';
import '../../../route/route_strings.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/auth_bg.dart';
import '../../../widgets/components/bottom_sheet_bg.dart';
import '../../../widgets/components/hi_wash_button.dart';
import '../../../widgets/components/hi_wash_text_field.dart';
import 'auth_controller/auth_controller.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  AuthController controller =
  Get.isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.c5C6B72.withOpacity(0.49)),
        borderRadius: BorderRadius.circular(100),

      ),


    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColor.c5C6B72.withOpacity(0.49)),
      borderRadius: BorderRadius.circular(100),

    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: AppColor.c5C6B72.withOpacity(0.1),

      ),
    );
    return Scaffold(
      body: AuthBg(
        headingText: "kAuthentication".tr,
        subText:  "kOTP".tr,

        child: Column(
          children: [
            110.heightSizeBox,
            Text(
              "kVerifyPhone".tr,
              style: w700_22a(color: AppColor.c2C2A2A),
            ),
            14.heightSizeBox,
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "kCodeHasBeenSentTo".tr,
                    style: w400_12p(color: AppColor.c455A64),
                  ),
                  TextSpan(
                    text: '+6281375112234',
                    style: w500_14p(color: AppColor.blue).copyWith(decoration: TextDecoration.underline,decorationColor: AppColor.c455A64),
                  ),
                ],
              ),
            ),

            20.heightSizeBox,

            Pinput(
              defaultPinTheme: defaultPinTheme.copyDecorationWith(

                color: AppColor.c5C6B72.withOpacity(0.1),
              ),
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              validator: (s) {
                return s == '2222' ? null : 'Pin is incorrect';
              },
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              showCursor: true,
              onCompleted: (pin) => print(pin),


            ),
            24.heightSizeBox,
            Text("00:23",style: w400_12p(color: AppColor.red),),

            45.heightSizeBox,

            Text("kDidGetOTPCode".tr,style: w400_12p(color: AppColor.c455A64),),
            5.heightSizeBox,
            Text("resendCode".tr,style: w400_12p(color: AppColor.red),),
            26.heightSizeBox,
            HiWashButton(
              text:  "kVerify".tr,
              onTap: () {
                Get.toNamed(RouteStrings.resetPasswordScreen);
              },
            ),

            30.heightSizeBox,
          ],
        ),
      ),
    );
  }
}
