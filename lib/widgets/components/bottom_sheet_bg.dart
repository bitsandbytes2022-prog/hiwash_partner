import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../generated/assets.dart';
import '../../styling/app_color.dart';
import 'hi_wash_button.dart';

class BottomSheetBg extends StatelessWidget {
  final Widget child;
  const BottomSheetBg({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top:100),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: Get.width,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              margin: EdgeInsets.only(top: 70),
              child: child
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              height: 155,
              width: 155,
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
    );
  }
}
