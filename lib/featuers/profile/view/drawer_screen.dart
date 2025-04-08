import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../route/route_strings.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/doted_line.dart';
import '../../../widgets/components/hi_wash_text_field.dart';
import '../../../widgets/components/image_view.dart';

import '../controller/drawer.dart';
import 'my_account_screen.dart';
import 'terms _and_condition_screen.dart';

class DrawerScreen extends StatelessWidget {
  final DrawerControllerX drawerController = Get.put(DrawerControllerX());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Drawer(
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.horizontal(right: Radius.circular(15)),
            ),
            child:
                drawerController.currentDrawerSection.value == ''
                    ? mainDrawerUI()
                    : sectionDrawerUI(
                      drawerController.currentDrawerSection.value,
                    ),
          ),
        );
      }),
    );
  }

  /// **Main Drawer**
  Widget mainDrawerUI() {
    return Column(
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

        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: AppColor.blue.withOpacity(0.2)),
          ),
          child: CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(Assets.imagesDemoProfile),
          ),
        ),
        11.heightSizeBox,
        Text("Caltex Engine Oil", style: w700_16a(color: AppColor.c2C2A2A)),

        39.heightSizeBox,

        /// **Drawer Options**
        drawerRowWidget(
          onTap: () => Get.to(MyAccountScreen()),
          title: 'My Account',
          image: Assets.iconsIcAccount,
        ),

        drawerRowWidget(
          onTap: () => drawerController.toggleDrawer('Theme'),
          title: 'Theme',
          image: Assets.iconsIcTheme,
        ),
        drawerRowWidget(
          onTap: () => drawerController.toggleDrawer('Language'),
          title: 'Language',
          image: Assets.iconsIcLanguage,
        ),
        drawerRowWidget(
          onTap: () => drawerController.toggleDrawer('Privacy Settings'),
          title: 'Privacy Settings',
          image: Assets.iconsIcPrivacy,
        ),
        drawerRowWidget(
          onTap: () => Get.to(TermsAndConditionScreen()),
          title: 'Terms and Condition',
          image: Assets.iconsIcTermscondition,
        ),
        Spacer(),
        //  60.heightSizeBox,
        GestureDetector(
          onTap: () {
            Get.offAllNamed(RouteStrings.loginScreen);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 31, vertical: 10),
            decoration: BoxDecoration(
              color: AppColor.cF6F7FF,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: AppColor.cD83030),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageView(path: Assets.iconsIcLogout, height: 20, width: 20),
                5.widthSizeBox,
                Text("Logout", style: w500_14a(color: AppColor.c142293)),
              ],
            ),
          ),
        ),
        50.heightSizeBox,
      ],
    );
  }

  /// **Dynamic Section UI**
  Widget sectionDrawerUI(String section) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          40.heightSizeBox,

          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () {
                drawerController.toggleDrawer('');
                print("object");
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ImageView(
                      path: Assets.iconsIcArrow,
                      height: 15,
                      width: 15,
                      color: AppColor.c455A64,
                    ),
                    10.widthSizeBox,
                    Text(section, style: w500_14a(color: AppColor.c2C2A2A)),
                  ],
                ),
              ),
            ),
          ),
          // Text(section, style: w600_18p(color: AppColor.c142293)),
          // 20.heightSizeBox,

          /// **Content According to Section**
          if (section == 'My Account') myAccountUI(),

          if (section == 'Theme') themeUI(),
          if (section == 'Language') languageUI(),
          if (section == 'Privacy Settings') privacySettingsUI(),

          20.heightSizeBox,
        ],
      ),
    );
  }

  /// **Individual Section UIs**
  Widget myAccountUI() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: AppColor.blue.withOpacity(0.2)),
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(Assets.imagesDemoProfile),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColor.cC41949,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: AppColor.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.cC41949.withOpacity(0.25),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),

                child: ImageView(
                  path: Assets.iconsIcEdit,
                  height: 17,
                  width: 17,
                ),
              ),
            ],
          ),
          11.heightSizeBox,
          Text("Ibrahim Bafqia"),
          4.heightSizeBox,
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Your ',
                  style: w400_12p(color: AppColor.c455A64),
                ),
                TextSpan(
                  text: 'Unlimited Washes',
                  style: w600_14p(color: AppColor.cC31848),
                ),
                TextSpan(
                  text: ' pack\nexpiring in ',
                  style: w400_12p(color: AppColor.c455A64),
                ),
                TextSpan(
                  text: '15-oct-2025',
                  style: w600_12p(color: AppColor.c455A64),
                ),
              ],
            ),
          ),
          31.heightSizeBox,
          HiWashTextField(hintText: "Name", labelText: "Name"),
          20.heightSizeBox,
          HiWashTextField(hintText: "Email", labelText: "Email"),
          20.heightSizeBox,
          HiWashTextField(hintText: "Phone", labelText: "Phone"),
          20.heightSizeBox,

          TextFormField(
            maxLines: 3,

            style: w400_14p(color: AppColor.c2C2A2A.withOpacity(0.9)),
            decoration: InputDecoration(
              fillColor: AppColor.cF6F7FF,
              // hintText: "Address",
              //labelText: "Address",
              label: Text("Address"),
              filled: true,
              // suffixIcon: ImageView(path: Assets.iconsMyLocation,height: 5,width: 10,),
              labelStyle: w400_13a(color: AppColor.c455A64),
              hintStyle: w400_14p(color: AppColor.c2C2A2A.withOpacity(0.40)),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.cEAE8E8.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.c5C6B72.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.c5C6B72.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.c5C6B72.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.c5C6B72.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.c5C6B72.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),

          20.heightSizeBox,
          HiWashTextField(hintText: "Car Number", labelText: "Car Number"),
          20.heightSizeBox,
        ],
      ),
    );
  }

  Widget themeUI() {
    return Column(children: [Text("Select Theme"), 10.heightSizeBox]);
  }

  Widget languageUI() {
    return Column(children: [Text("Select Language")]);
  }

  Widget privacySettingsUI() {
    return Column(children: [Text("Privacy Settings")]);
  }

  /// **Reusable Row Widget**
  Widget drawerRowWidget({
    required VoidCallback onTap,
    required String title,
    required String image,
    bool dashedLineWidget = true,
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

  /// **Reusable  Row for subscriptionPlanUI Widget**
  Widget subscriptionRowWidget({
    required String title,
    Color? color,
    required String packName,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title.tr, style: w400_12p(color: AppColor.c455A64)),
        Text(packName.tr, style: w500_12p(color: color ?? AppColor.c2C2A2A)),
      ],
    );
  }
}
