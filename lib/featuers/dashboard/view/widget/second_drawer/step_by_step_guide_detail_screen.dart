import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';
import '../../../../../styling/app_font_poppins.dart';
import '../../../../../widgets/components/app_home_bg.dart';


class StepByStepGuideDetailScreen extends StatelessWidget {
  const StepByStepGuideDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? {};
    final String title = args['title'] ?? 'No Title';
    final String description = args['description'] ?? 'No Description';

    return AppHomeBg(


      headingText: "Step-by-Step Guide - Detail",
      iconRight: SizedBox(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          15.heightSizeBox,
          Text(title.trim(), style: w600_16p()),
          10.heightSizeBox,
          Text(description.trim(), style: w400_14p()),
        ],
      ),
    );
  }
}
