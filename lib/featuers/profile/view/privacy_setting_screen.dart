import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hiwash_partner/language/String_constant.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';

import '../../../widgets/components/app_home_bg.dart';

class PrivacySettingScreen extends StatelessWidget {
  const PrivacySettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppHomeBg(
      headingText: StringConstant.kPrivacySettings.tr,
      iconRight: SizedBox(),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [15.heightSizeBox],
      ),
    );
  }
}
