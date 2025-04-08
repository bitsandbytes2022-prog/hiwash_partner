import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
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
    Future.delayed(Duration(seconds: 2), () {
     return Get.offNamed(RouteStrings.welcomeScreen);
   });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ImageView(path: Assets.imagesSplashBg),
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

                        child: ImageView(path: Assets.imagesAppLogo, height: 55),
                      ),

                      30.heightSizeBox,
                      DottedLine(),

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
                padding:  EdgeInsets.only(bottom: 60),
                child: Text("Drive More Business with Us!",style: w500_16a(color: AppColor.white.withOpacity(0.4)),textAlign: TextAlign.center,),
              ),

            ],
          ),
        ],
      ),
    );
  }
}

class DottedLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.0,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColor.c142293.withOpacity(0.2),
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(40, (index) {
          return Container(
            width: 5.0,
            height: 1.0,
            color:
                index % 4 == 0
                    ? AppColor.c142293.withOpacity(0.2)
                    : Colors.transparent,
          );
        }),
      ),
    );
  }
}
