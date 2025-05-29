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
final bool closeIconShow;
   AppDialog({super.key, this.child,this.padding,this.onTap,this.closeIconShow=true});

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
            if (closeIconShow)
              GestureDetector(
                onTap: onTap ?? () {
                  Get.back();
                },
                child: Container(
                  padding: EdgeInsets.only(right: 18, top: 10),
                  child: ImageView(
                    path: Assets.iconsIcClose,
                    height: 28,
                    width: 32,
                  ),
                ),
              ),
          ],
        ),

      ),
    );
  }
}


