import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_partner/featuers/profile/controller/drawer_profile_controller.dart';
import 'package:hiwash_partner/language/String_constant.dart';
import 'package:hiwash_partner/widgets/components/app_home_bg.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../widgets/components/image_view.dart';

class TermsAndConditionScreen extends StatelessWidget {
  TermsAndConditionScreen({super.key});

  DrawerProfileController drawerProfileController = Get.find();

  @override
  Widget build(BuildContext context) {
    drawerProfileController.getTermsAndConditions();

    return AppHomeBg(
      headingText: StringConstant.kTermsAndCondition.tr,
      iconRight: SizedBox(),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          15.heightSizeBox,
          Obx(() {
            return Text(
              drawerProfileController
                      .termsAndConditionsResponseModel
                      .value
                      ?.data
                      ?.first
                      .content ??
                  "".tr,
            );
          }),
        ],
      ),
    );
  }
}
