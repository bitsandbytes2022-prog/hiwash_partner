import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_partner/widgets/components/app_home_bg.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../widgets/components/image_view.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:AppHomeBg(
        headingText:  "Terms and Condition",
        iconRight: SizedBox(),
        child: Column(children: [Text("kDemoText".tr)]),
      )


      /* Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: AppColor.c142293,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: ImageView(
                        path: Assets.iconsIcArrow,

                        height: 15,
                        width: 15,
                      ),
                    ),
                    Text(
                      "Terms and Condition",
                      style: w700_16a(color: AppColor.white),
                    ),
                    Text(""),
                  ],
                ),
              ),
            ],
          ),
          30.heightSizeBox,
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(children: [Text("kDemoText".tr)]),
              ),
            ),
          ),
        ],
      ),*/
    );
  }
}
