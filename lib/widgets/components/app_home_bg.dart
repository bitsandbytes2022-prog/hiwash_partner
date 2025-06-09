import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:hiwash_partner/featuers/profile/view/chat_screen.dart';
import 'package:hiwash_partner/generated/assets.dart';
import 'package:hiwash_partner/styling/app_color.dart';
import 'package:hiwash_partner/styling/app_font_anybody.dart';
import 'package:hiwash_partner/widgets/components/image_view.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';
import 'dashed_line_widget.dart';
import 'doted_vertical_line.dart';


import 'doted_horizontal_line.dart';


class AppHomeBg extends StatelessWidget {
  final String? headingText;
  final Widget? child;

  final Widget? child1;
  final Widget? childAppBar;
  final Widget? iconRight;
  final Widget? iconLeft;
  final Widget? centerHeading;
  final EdgeInsets? padding;
  final EdgeInsets? buttonPadding;
  final double? height;

  AppHomeBg({
    super.key,
    this.headingText,
    this.child,
    this.iconRight,
    this.iconLeft,
    this.padding,
    this.childAppBar,
    this.centerHeading,
    this.height, this.child1, this.buttonPadding,
  });

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: AppColor.cF6F7FF,
        key: _scaffoldKey,

        body: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                Container(

                    height: height ?? 110,
                    decoration: BoxDecoration(
                      color: AppColor.blue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    padding:buttonPadding?? EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 40,

                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        iconLeft ??
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
                        centerHeading ??
                            Text(
                              headingText ?? '',
                              style: w700_16a(color: AppColor.white),
                            ),
                        iconRight ??
                            GestureDetector(
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
                    )

                ),
                childAppBar ?? SizedBox(),
              ],
            ),

            5.heightSizeBox,
            child1??   Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: padding ?? EdgeInsets.symmetric(horizontal: 16),
                  child: child,
                ),
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
          dashedLineWidget ? DotedHorizontalLine() : SizedBox(),
          18.heightSizeBox,
        ],
      ),
    );
  }
}

