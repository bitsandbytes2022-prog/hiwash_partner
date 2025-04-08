import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';
import '../../generated/assets.dart';
import '../../styling/app_color.dart';
import '../../styling/app_font_anybody.dart';
import 'image_view.dart';

class AppBg extends StatelessWidget {
  final String headingText;
  final String subText;
  final Widget child;
  final bool showBackButton;
  const AppBg({
    super.key,
    required this.headingText,
    required this.subText,
    required this.child,

   this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [

            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  ImageView(path: Assets.imagesAuthBg,fit: BoxFit.contain,),
                  Container(
                    width: Get.width,
                    height: double.maxFinite,
                    color: Colors.black,)
                ],
              ),
            ),
           GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Padding(
                padding: EdgeInsets.only(left: 11, top: 50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (showBackButton)Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 13,
                      ),
                    ),
                    12.widthSizeBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Text(headingText, style: w400_22a(color: AppColor.white)),
                        Text(subText, style: w800_24a(color: AppColor.white)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 90),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        color: AppColor.cF6F7FF,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      margin: EdgeInsets.only(top: 60),
                      child: child,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(77.5),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.blue.withOpacity(0.2),
                            blurRadius: 30,
                            spreadRadius: 4,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(child: Image.asset(Assets.imagesAppLogo)),
                    ),
                  ],
                ),
              ),
            ),

            //  Text("Skip"),
          ],
        ),

      ],
    );
  }
}
