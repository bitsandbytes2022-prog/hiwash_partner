import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_partner/featuers/auth/auth_controller/auth_controller.dart';
import 'package:hiwash_partner/language/String_constant.dart';
import 'package:hiwash_partner/widgets/components/dashed_line_widget.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../network_manager/local_storage.dart';
import '../../../route/route_strings.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../widgets/components/image_view.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  AuthController authController =
      Get.isRegistered<AuthController>()
          ? Get.find<AuthController>()
          : Get.put(AuthController());

  void _checkLoginStatus() async {
    final LocalStorage localStorage = LocalStorage();
    await Future.delayed(Duration(seconds: 2));

    final token = localStorage.getToken();
    print("Token retrieved: $token");

    if (token != null && token.isNotEmpty) {
      authController.refreshToken();
      Get.offNamed(RouteStrings.dashboardScreen);
    } else {
      Get.offNamed(RouteStrings.welcomeScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ImageView(
            path: Assets.imagesSplashBg,

            width: Get.width,
            fit: BoxFit.cover,
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: Get.width,
                  margin: EdgeInsets.only(left: 56, right: 56),

                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(200),
                      topRight: Radius.circular(200),
                      bottomLeft: Radius.circular(200),
                      bottomRight: Radius.circular(200),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.c000000.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 25,
                        offset: Offset(0, 25),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 115, left: 20, right: 20),

                        child: ImageView(
                          path: Assets.imagesAppLogo,
                          height: 55,
                        ),
                      ),

                      30.heightSizeBox,
                      DashedLineWidget(),

                      Container(
                        width: Get.width,
                        padding: EdgeInsets.only(bottom: 115, top: 25),

                        decoration: BoxDecoration(
                          color: AppColor.cF6F7FF,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(200),
                            bottomRight: Radius.circular(200),
                          ),
                        ),

                        child: Column(
                          children: [
                            Text(
                              "kWelcomeToThe".tr,
                              style: w400_22a(color: AppColor.c2C2A2A),
                            ),
                            Text(
                              "kHiWASH".tr,
                              style: w900_24a(color: AppColor.c2C2A2A),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 60),
                child: Text(
                  StringConstant.kDriveMoreBusinessWith.tr,
                  style: w500_16a(color: AppColor.white.withOpacity(0.4)),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
