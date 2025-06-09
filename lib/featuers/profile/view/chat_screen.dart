/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/hi_wash_text_field.dart';
import '../../../widgets/components/image_view.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                padding: EdgeInsets.only(left: 16, right: 16, top: 40),
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
                      "Chat with Support",
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
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    reverse: true,
                    children: [rightChatBox(), 20.heightSizeBox, leftChatBox()],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(
                      color: AppColor.c142293.withOpacity(0.20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.c142293.withOpacity(0.10),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: HiWashTextField(
                    fillColor: AppColor.white,

                    hintText: "Type a message...",
                    suffixIcon: ImageView(
                      path: Assets.iconsIcSent,
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
                60.heightSizeBox,
              ],
            ),
          ),
        ],
      ),
    );
  }

  leftChatBox() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topLeft,
          children: [
            Container(
              margin: EdgeInsets.only(left: 31, right: 61, top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: AppColor.c142293.withOpacity(0.1),
              ),

              padding: EdgeInsets.only(top: 6, bottom: 3, left: 15, right: 13),

              width: Get.width,
              child: Text("kDemoText".tr),
            ),
            Positioned(
              left: 15,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(color: AppColor.c101D8D),
                    ),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundImage: AssetImage(Assets.imagesDemoProfile),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10, left: 10),
                    child: Text(
                      "2m ago",
                      style: w400_10p(color: AppColor.c455A64),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  rightChatBox() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              margin: EdgeInsets.only(left: 61, right: 31, bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                color: AppColor.cC31848.withOpacity(0.1),
              ),

              padding: EdgeInsets.only(top: 6, bottom: 14, left: 15, right: 13),

              width: Get.width,
              child: Text("kDemoText".tr),
            ),
            Positioned(
              right: 15,
              bottom: 0,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10, top: 10),
                    child: Text(
                      "1m ago ",
                      style: w400_10p(color: AppColor.c455A64),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(color: AppColor.c101D8D),
                    ),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundImage: AssetImage(Assets.imagesDemoProfile),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
*/
