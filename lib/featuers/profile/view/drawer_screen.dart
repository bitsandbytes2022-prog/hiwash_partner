import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hiwash_partner/featuers/profile/view/widget/custome_switch.dart';
import 'package:hiwash_partner/language/String_constant.dart';
import 'package:hiwash_partner/network_manager/local_storage.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../route/route_strings.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/doted_horizontal_line.dart';
import '../../../widgets/components/dashed_line_widget.dart';
import '../../../widgets/components/hi_wash_text_field.dart';
import '../../../widgets/components/image_view.dart';

import '../../auth/auth_controller/auth_controller.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../controller/drawer_profile_controller.dart';
import 'my_account_screen.dart';
import 'terms _and_condition_screen.dart';

class DrawerScreen extends StatelessWidget {
  final DrawerProfileController drawerController = Get.put(
    DrawerProfileController(),
  );
  AuthController authController =
      Get.isRegistered<AuthController>()
          ? Get.find<AuthController>()
          : Get.put(AuthController());
  DashboardController dashboardController = Get.isRegistered<DashboardController>()?Get.find():Get.put(DashboardController());


  @override
  Widget build(BuildContext context) {
    return  Obx(() {
      return Drawer(
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(15),
            ),
          ),
          child:
          mainDrawerUI()

        ),
      );
    });
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
         child:  Obx(() {
            final profilePicUrl = dashboardController
                .getPartnerModel
                .value
                ?.data?.first
                .profilePicUrl;

            final hasValidUrl = profilePicUrl?.isNotEmpty ?? false;

            return CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[200],
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: hasValidUrl ? profilePicUrl! : '',
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                  placeholder: (context, url) => Center(
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    Assets.imagesDemoProfile,
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
            );
          }),
        ),
        11.heightSizeBox,
        Text(dashboardController.getPartnerModel.value?.data?.first.businessName ?? '', style: w700_16a(color: AppColor.c2C2A2A)),

        39.heightSizeBox,

        /// **Drawer Options**
        drawerRowWidget(
          onTap: () => Get.to(MyAccountScreen()),
          title: StringConstant.kMyAccount.tr,
          image: Assets.iconsIcAccount,
        ),

        Obx(() => drawerRowForTheme(
          title: StringConstant.kTheme.tr,
          image: Assets.iconsIcTheme,
          switchValue: drawerController.isSwitchOn.value,
          onSwitchChanged: (bool value) {
            drawerController.isSwitchOn.value = value;

             // Optional: toggle theme
            // Get.changeTheme(value ? ThemeData.dark() : ThemeData.light());
          },
        )),
        drawerRowWidget(
          padding: EdgeInsets.only(left: 15,right: 15,top: 15),
          onTap: () => Get.toNamed(RouteStrings.languageScreen),
          title: StringConstant.kLanguage.tr,
          image: Assets.iconsIcLanguage,
        ),
        drawerRowWidget(
          onTap: () => Get.toNamed(RouteStrings.privacySettingScreen),
          title: StringConstant.kPrivacySettings.tr,
          image: Assets.iconsIcPrivacy,
        ),
        drawerRowWidget(
          onTap: () => Get.to(TermsAndConditionScreen()),
          title: StringConstant.kTermsAndConditions.tr,
          image: Assets.iconsIcTermscondition,
        ),
        Spacer(),
        //  60.heightSizeBox,
        GestureDetector(
          onTap: () async {
            await LocalStorage().removeToken();
            final deviceLocale = Get.deviceLocale ?? const Locale('en', 'US');
            Get.updateLocale(deviceLocale);
            Get.offAllNamed(RouteStrings.welcomeScreen);

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
                Text(StringConstant.kLogout.tr, style: w500_14a(color: AppColor.c142293)),
              ],
            ),
          ),
        ),
        20.heightSizeBox,
      ],
    );
  }




  /// **Reusable Row Widget**
  Widget drawerRowWidget({
    required VoidCallback onTap,
    required String title,
    required String image,
    bool dashedLineWidget = true,
    EdgeInsets?padding
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: padding??EdgeInsets.only(left: 18, right: 12),
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
  Widget drawerRowForTheme({
    required String title,
    required String image,
    required bool switchValue,
    required ValueChanged<bool> onSwitchChanged,
    bool dashedLineWidget = true,
  }) {
    return Column(
      children: [
        Container(
          color: Colors.transparent,
          child: Padding(
            padding:  EdgeInsets.only(left: 15,right: 15,bottom: 15),
            child: Row(
              children: [
                ImageView(path: image, height: 20, width: 20),
                const SizedBox(width: 10),
                Text(title, style: w500_14a(color: AppColor.c2C2A2A)),
                const Spacer(),
                CustomContainerSwitch(
                  value: switchValue,
                  onChanged: onSwitchChanged,
                ),
              ],
            ),
          ),
        ),
        dashedLineWidget ? DotedHorizontalLine() : const SizedBox(),
      ],
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
