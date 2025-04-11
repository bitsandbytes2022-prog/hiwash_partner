import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';

import '../../generated/assets.dart';
import '../../styling/app_color.dart';
import 'image_view.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget child;

  const CustomBottomSheet({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(

      //padding: EdgeInsets.all(16),
      height: Get.height / 1.2,
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
            children: [
              13.heightSizeBox,
              Container(
                height: 4,
                width: 45,
                decoration: BoxDecoration(
                  color: AppColor.c455A64,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              child,
            ],
          ),
          GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Container(
              padding: EdgeInsets.only(right: 5,top: 4),
              child: ImageView(
                path: Assets.iconsIcClose,
                height: 28,
                width: 32,
              ),
            ),
          )
        ],
      ),
    );
  }
}
