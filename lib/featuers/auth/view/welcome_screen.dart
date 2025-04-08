import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../generated/assets.dart';
import '../../../route/route_strings.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../widgets/components/bottom_sheet_bg.dart';
import '../../../widgets/components/get_start_button.dart';
import 'auth_controller/auth_controller.dart';
import 'auth_widgets/bg_widget.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BgWidget(imagePath: Assets.imagesWelcomeBg),

          Positioned(
            bottom: 0,
            child:
            GetBuilder<AuthController>(
            builder: (controller) {
              return
              Container(
                child: BottomSheetBg(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      80.heightSizeBox,


                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 200,
                        child: PageView.builder(
                          controller: authController.pageController,
                          onPageChanged: (index) {
                            authController.onPageChanged(index);
                          },
                          itemCount: authController.headingText.length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  authController.headingText[index].tr,
                                  style: w700_22a(color: AppColor.c2C2A2A),
                                ),
                                15.heightSizeBox,
                                Text(
                                  authController.subText[index].tr,
                                  textAlign: TextAlign.center,
                                  style: w400_16a(color: AppColor.c455A64),
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      // Smooth Page Indicator
                      SmoothPageIndicator(
                        controller: authController.pageController,
                        count: authController.headingText.length,
                        effect: ExpandingDotsEffect(
                          activeDotColor: AppColor.red,
                          dotColor: Colors.grey,
                          dotHeight: 8,
                          dotWidth: 8,
                          spacing: 4,
                        ),
                      ),
                      30.heightSizeBox,

                      GetStartButton(
                        width: 193,
                        text: "kGetStarted".tr,
                        onTap: () {
                          Get.toNamed(RouteStrings.loginScreen);
                        },
                      ),
                      15.heightSizeBox,
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(RouteStrings.termsAndConditionScreen);
                        },
                        child: Text(
                          "kTermsAndConditions".tr,
                          style: w500_14a(color: AppColor.red),
                        ),
                      ),
                      60.heightSizeBox,
                    ],
                  ),
                ),
              );
            },
         )
          ),
        ],
      ),
    );
  }
}