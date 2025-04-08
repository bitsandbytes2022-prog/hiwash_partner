import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwash_partner/featuers/profile/view/chat_screen.dart';
import 'package:hiwash_partner/generated/assets.dart';
import 'package:hiwash_partner/styling/app_color.dart';
import 'package:hiwash_partner/styling/app_font_anybody.dart';
import 'package:hiwash_partner/widgets/components/doted_line.dart';
import 'package:hiwash_partner/widgets/components/doted_vertical_line.dart';
import 'package:hiwash_partner/widgets/components/image_view.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';

class SecondDrawer extends StatelessWidget {
  const SecondDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 40),
      child: Drawer(
        backgroundColor: AppColor.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            48.heightSizeBox,
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 7),
                child: Align(
                  alignment: Alignment.topRight,
                  child: ImageView(
                    path: Assets.iconsIcClose,
                    height: 28,
                    width: 32,
                  ),
                ),
              ),
            ),
            ImageView(path: Assets.imagesHelpSupport, height: 180),
            31.heightSizeBox,
            Text("Get Help?", style: w700_22a()),
            40.heightSizeBox,

            /// **Drawer Options**
            drawerRowWidget(
              onTap: () => {Get.to(ChatScreen())},
              title: 'Chat with Support',
              image: Assets.iconsIcChat,
            ),
            drawerRowWidget(
              onTap: () => {},
              title: 'Help Desk Ticket',
              image: Assets.iconsIcTicket,
            ),
            drawerRowWidget(
              onTap: () => {},
              title: 'FAQ’s',
              image: Assets.iconsIcFaq,
            ),
            drawerRowWidget(
              onTap: () => {},
              title: 'Step-by-Step Guide',
              dashedLineWidget: false,
              image: Assets.iconsIcGuideBook,
            ),

            Spacer(),
            DashedLineWidget(),
            Container(
              color: AppColor.cF6F7FF,
              alignment: Alignment.center,
              height: 86,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageView(height: 23, width: 23, path: Assets.iconsPhone),
                        Text("+974 7048 7070", style: w500_12a()),
                      ],
                    ),
                  ),
                  DotedVerticalLine(),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageView(
                          height: 23,
                          width: 23,
                          path: Assets.iconsIcAtSign,
                        ),
                        Text("info@hiwash.com", style: w500_12a()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerRowWidget({
    required VoidCallback onTap,
    required String title,
    bool dashedLineWidget = true,
    required String image,
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
}
