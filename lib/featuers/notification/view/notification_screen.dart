import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_partner/widgets/components/app_home_bg.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/doted_line.dart';
import '../../../widgets/components/doted_vertical_line.dart';
import '../../../widgets/components/image_view.dart';
import '../../profile/view/chat_screen.dart';
import '../controller/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  NotificationController controller = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(

          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: 20,
          separatorBuilder: (context, index) {
            return DashedLineWidget();
          },
          itemBuilder: (context, index) {
            return Obx(() {
              return notificationContainer(index);
            });
          },
        ),
      ],
    );

  }

  Widget drawerRowWidget({
    required VoidCallback onTap,
    required String title,
    bool dashedLineWidget = true,
    required String image
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 18, right: 12),
            child: Row(
              children: [
                ImageView(path: image, height: 20, width: 20),
                10.widthSizeBox,
                Text(title, style: w500_14a(color: AppColor.c2C2A2A)),
                Spacer(),
                ImageView(
                  path: Assets.iconsBlackForwardArrow,
                  height: 13,
                  width: 13,
                ),
              ],
            ),
          ),
          18.heightSizeBox,
          dashedLineWidget ? DashedLineWidget() : SizedBox(),
          18.heightSizeBox,
        ],
      ),
    );
  }

  Widget notificationContainer(int index) {
    return GestureDetector(
      onTap: () {
        controller.toggleSelection(index);
      },
      child: Container(
        width: Get.width,
        color:
            controller.selectedIndices[index] ? Colors.white : AppColor.cF6F7FF,
        padding: EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 26),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(

              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(

                shape: BoxShape.circle,
                border: Border.all(color: AppColor.blue.withOpacity(0.2)),
              ),
              child: Container(
                height: 38,
                width: 38,
                  padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:AppColor.cCACEE9,

                  shape: BoxShape.circle,
                  //borderRadius: BorderRadius.circular(100),
                ),
                child: ImageView(
                  path: Assets.iconsIcCheck,
                  color: AppColor.c455A64,
                  height: 9,
                  width: 14,

                )
              ),
            ),

            9.widthSizeBox,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "kDemoText".tr,
                    style: w500_12p(color: AppColor.c2C2A2A),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  4.heightSizeBox,
                  Text("12 am", style: w400_10p(color: AppColor.c455A64)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

