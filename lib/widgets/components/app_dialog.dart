import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../generated/assets.dart';
import '../../styling/app_color.dart';
import '../../styling/app_font_poppins.dart';
import 'image_view.dart';

class AppDialog extends StatelessWidget {
  Widget? child;
  String? remainingText;
  EdgeInsets?padding;
 VoidCallback?onTap;
   AppDialog({super.key, this.child,this.padding,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,

        child:     Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
                margin: EdgeInsets.only(left: 16, right: 16,bottom: 11),
                width: Get.width,
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(20)
                ),
                padding: padding??EdgeInsets.symmetric(horizontal: 14),
                child: child
            ),
            GestureDetector(
              onTap: onTap??(){
                Get.back();
              },
              child: Container(
                padding: EdgeInsets.only(right: 18,top: 10),
                child: ImageView(
                  path: Assets.iconsIcClose,
                  height: 28,
                  width: 32,
                ),
              ),
            )
          ],
        ),

        /* Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16,bottom: 11),
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 27),
                  child: child
                ),
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 18,top: 10),
                    child: ImageView(
                      path: Assets.iconsIcClose,
                      height: 28,
                      width: 32,
                    ),
                  ),
                )
              ],
            ),

            Container(
                padding: EdgeInsets.only(bottom: 0),
                margin: EdgeInsets.only(left: 50,right: 50,top: 40),
                *//*  decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(Assets.imagesDialogBottom),
                ),*//*

                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(Assets.imagesDialogBottom),
                    Text(remainingText??''.tr,style:w500_14p(color: AppColor.c2C2A2A) ,)
                  ],
                )

            )
          ],
        ),*/
      ),
    );
  }
}


