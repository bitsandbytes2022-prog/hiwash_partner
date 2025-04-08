import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:hiwash_partner/featuers/profile/view/chat_screen.dart';
import 'package:hiwash_partner/generated/assets.dart';
import 'package:hiwash_partner/styling/app_color.dart';
import 'package:hiwash_partner/styling/app_font_anybody.dart';
import 'package:hiwash_partner/widgets/components/image_view.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';
import 'doted_line.dart';
import 'doted_vertical_line.dart';

class AppHomeBg extends StatelessWidget {
  final String?headingText;
  final Widget?child;
  final Widget?iconRight;
  final Widget?iconLeft;
  final EdgeInsets?padding;


   AppHomeBg({super.key,  this.headingText, this.child, this.iconRight, this.iconLeft, this.padding, });
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
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
            drawerRowWidget(onTap: () => {

              Get.to(ChatScreen())
            }, title: 'Chat with Support', image: Assets.iconsIcChat),
            drawerRowWidget(onTap: () => {}, title: 'Help Desk Ticket', image: Assets.iconsIcTicket),
            drawerRowWidget(onTap: () => {}, title: 'FAQ’s', image: Assets.iconsIcFaq),
            drawerRowWidget(
              onTap: () => {},
              title: 'Step-by-Step Guide',
              dashedLineWidget: false, image: Assets.iconsIcGuideBook,
            ),

            Spacer(),
            DashedLineWidget(),
            Container(
              // padding: EdgeInsets.only(bottom: 20),
              color: AppColor.cF6F7FF,
              alignment: Alignment.center,
              height: 86,
              child: Row(

                children: [
                  Expanded(
                    child: Column(

                      mainAxisAlignment:MainAxisAlignment.center ,
                      children: [
                        ImageView(height: 23, width: 23, path: Assets.iconsPhone),
                        Text("+974 7048 7070", style: w500_12a()),
                      ],
                    ),
                  ),
                  DotedVerticalLine(),
                  // Container(height: Get.height, width: 1, color: AppColor.c142293.withOpacity(0.10)),

                  Expanded(
                    child: Column(
                      mainAxisAlignment:MainAxisAlignment.center ,
                      children: [
                        ImageView(height: 23, width: 23, path: Assets.iconsIcAtSign),
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
                padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    iconLeft??  GestureDetector(
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
                      headingText??'',
                      style: w700_16a(color: AppColor.white),
                    ),
                    iconRight?? GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      child: ImageView(
                        height: 23,
                        width: 23,
                        path: Assets.iconsIcMessage,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          15.heightSizeBox,
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: padding??EdgeInsets.symmetric(horizontal: 16),
                child: child
              ),
            ),
          ),
        ],
      ),
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
}
