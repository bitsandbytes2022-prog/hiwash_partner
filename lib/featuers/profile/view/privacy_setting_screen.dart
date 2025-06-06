import 'package:flutter/cupertino.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';

import '../../../widgets/components/app_home_bg.dart';

class PrivacySettingScreen extends StatelessWidget {
  const PrivacySettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppHomeBg(
      headingText: "Privacy Settings",
      iconRight: SizedBox(),

      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            15.heightSizeBox,
           ]
      )

      ,
    );
  }
}
